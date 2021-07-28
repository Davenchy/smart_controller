import 'dart:async';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_controller/core/utils/b_protocol/packet.dart';
import 'package:smart_controller/core/utils/b_protocol/packet_event_controller.dart';
import 'package:smart_controller/core/utils/b_protocol/peer.dart';
import 'package:smart_controller/core/utils/b_protocol/typed_payloads/payload_type_manger.dart';

part 'connection_manager.freezed.dart';
part 'connection_manager_event.dart';

class BConnectionManager {
  BConnectionManager(this._port, this._socket) {
    _handleSocketEvents();
  }

  int _port;
  RawDatagramSocket _socket;
  final List<StreamSubscription> _subscriptions = [];
  final List<BPeer> peers = [];
  late StreamController<ConnectionManagerEvent> _controller;
  RawDatagramSocket get socket => _socket;

  static Future<BConnectionManager> create(int port) async {
    final RawDatagramSocket socket = await _createSocket(port);
    return BConnectionManager(port, socket);
  }

  static Future<BPeer> connect(
    InternetAddress address,
    int port,
  ) async {
    final BConnectionManager cm = await create(port);
    final BPeer peer = BPeer(cm, address, port);
    cm.peers.add(peer);
    return peer;
  }

  static Future<RawDatagramSocket> _createSocket(int port) =>
      RawDatagramSocket.bind(
        InternetAddress.anyIPv4,
        port,
      );

  BPeer getPeer(InternetAddress address, int port) => peers.firstWhere(
        (peer) => peer.address == address && peer.port == port,
        orElse: () {
          final peer = BPeer(this, address, port);
          peers.add(peer);
          final event = ConnectionManagerEvent.newPeer(peer);
          emitEvent(event);
          return peer;
        },
      );

  Future<PacketEventController<R>?> sendAndWait<R extends PayloadType>(
    InternetAddress address,
    int port,
    Packet packet, {
    Duration? timeout,
    int? retries,
    void Function(
      InternetAddress address,
      int port,
      Packet packet,
    )?
        killFunction,
  }) async {
    final int connectionId = packet.connectionId;
    final completer = Completer<CME_Packet?>();
    final StreamSubscription subscription = onEvent<CME_Packet>().listen(
      (event) {
        if (event.packet.connectionId == connectionId) {
          if (!completer.isCompleted) completer.complete(event);
        }
      },
    );

    _socket.send(packet.encode(), address, port);
    int counter = 0;
    Timer? timer;

    if (retries != 0) {
      timer = Timer.periodic(
        timeout ?? const Duration(milliseconds: 20),
        (timer) {
          if (counter >= (retries ?? 25)) {
            killFunction?.call(address, port, packet);
            completer.complete(null);
            timer.cancel();
            return;
          }
          _socket.send(packet.encode(), address, port);
          counter++;
        },
      );
    }

    return completer.future.then<PacketEventController<R>?>((event) {
      if (event == null) return null;
      if (timer != null) timer.cancel();
      final controller = PacketEventController<R>(event);
      subscription.cancel();
      return controller;
    });
  }

  void _handleSocketEvents() {
    _controller = StreamController.broadcast();
    final StreamSubscription sub = _socket.listen((event) {
      if (event == RawSocketEvent.read) {
        final Datagram? dg = _socket.receive();
        if (dg == null) return;
        _onPacket(dg);
      }
    });
    _subscriptions.add(sub);
  }

  void _onPacket(Datagram dg) {
    ConnectionManagerEvent event;

    try {
      final peer = getPeer(dg.address, dg.port);
      final packet = Packet.decode(dg.data);
      event = ConnectionManagerEvent.packet(peer, packet);
    } catch (err) {
      print(err);
      event = ConnectionManagerEvent.error("failed to parse packet");
    }

    emitEvent(event);
  }

  void emitEvent(ConnectionManagerEvent event) => _controller.add(event);

  Stream<T> onEvent<T extends ConnectionManagerEvent>() =>
      _controller.stream.where((event) => event is T).cast<T>();

  void handleEventOn<T extends ConnectionManagerEvent>(
    void Function(T event) handler,
  ) {
    final StreamSubscription subscription = onEvent<T>().listen(handler);
    _subscriptions.add(subscription);
  }

  void onPacket(void Function(PacketEventController controller) handler) =>
      handleEventOn<CME_Packet>(
        (event) => handler(PacketEventController(event)),
      );

  Future<void> restart([int? port]) async {
    try {
      await close();
    } catch (_) {
      print('Restart Error: $_');
    }

    if (port != null) _port = port;
    _socket = await _createSocket(_port);
    _handleSocketEvents();
  }

  Future<void> close() async {
    _subscriptions.forEach((sub) {
      sub.cancel();
    });

    for (StreamSubscription sub in _subscriptions) await sub.cancel();
    _subscriptions.clear();
    await _controller.close();
    _socket.close();
    peers.clear();
  }
}
