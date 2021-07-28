import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_controller/core/utils/b_protocol/connection_manager.dart';
import 'package:smart_controller/core/utils/b_protocol/packet_event_controller.dart';
import 'package:smart_controller/core/utils/b_protocol/peer.dart';
import 'package:smart_controller/core/utils/b_protocol/typed_payloads/payload_types.dart';
import 'package:smart_controller/core/utils/constants.dart';
import 'package:smart_controller/mobile/entities/server_entity.dart';
import 'package:virtual_controller/virtual_controller.dart';

class PadController extends ChangeNotifier {
  PadController(this.serverEntity) {
    _connect();
  }

  bool _isPaused = true;
  String _pausedMessage = 'Connecting...';
  bool _shouldKill = false;

  bool get isPaused => _isPaused;
  String get pausedMessage => _pausedMessage;
  bool get shouldKill => _shouldKill;

  late final BPeer _serverPeer;
  late final Timer _keepAliveTimer;
  final ServerEntity serverEntity;

  Future<void> _onPacket(PacketEventController controller) async {
    if (controller.isOK)
      return;
    else if (controller.isDisconnect) {
      controller.sendOK();
      _kill();
    }
  }

  Future<void> _connect() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _serverPeer = await BConnectionManager.connect(
        serverEntity.address,
        serverEntity.port,
      );

      _serverPeer.connectionManager.onPacket(_onPacket);

      final PacketEventController? pec = await _serverPeer.sendPayload(
        ConnectPayloadType(
          prefs.getString(
                'controller_name',
              ) ??
              '$defaultMachineName`s VController',
        ),
      );

      if (pec == null || !pec.isOK) throw 'no response';

      _keepAliveTimer = Timer.periodic(
        const Duration(seconds: 5),
        _keepAliveHandler,
      );

      // activate controller
      await _serverPeer.sendPayload(ActivatePayloadType());

      _setLiveMode();
    } catch (err) {
      print('Error: $err');
      _emitError('Connection Failed');
    }
  }

  Future<void> _keepAliveHandler(Timer timer) async {
    final res = await _serverPeer.sendPayload(KeepAlivePayloadType(),
        timeout: const Duration(
          milliseconds: 500,
        ),
        retries: 5);
    if (res == null || !res.isOK) disconnect();
  }

  Future<void> disconnect() async {
    // print('bye bye linux');
    _serverPeer.sendPayload(DisconnectPayloadType());
    _kill();
  }

  void _kill() {
    if (_shouldKill == true) return;
    _shouldKill = true;
    _setPausedMode('Disconnection...');
    _killServer();
  }

  void _emitError(String message) => _setPausedMode('Error: $message');

  void _setPausedMode(String message) {
    // print('set pause');
    _isPaused = true;
    _pausedMessage = message;
    notifyListeners();
  }

  void _setLiveMode() {
    // print('set live');
    _isPaused = false;
    _pausedMessage = '';
    notifyListeners();
  }

  Future<void> _killServer() async {
    _keepAliveTimer.cancel();
    await _serverPeer.connectionManager.close();
  }

  @override
  Future<void> dispose() async {
    await _killServer();
    super.dispose();
  }

  void sendBTNCommand(int key, bool state) {
    // print('send $key with state $state');
    _serverPeer.sendPayload(
      CommandPayloadType(
        EventType.KEY,
        key,
        state ? 1 : 0,
      ),
      retries: 0,
    );
  }

  static const min = -512;
  static const max = 512;
  static const diff = max - min;

  void sendABSCommand(int key, double value) {
    _serverPeer.sendPayload(
      CommandPayloadType(
        EventType.ABSOLUTE,
        key,
        (diff * value + min).toInt(),
      ),
      retries: 0,
    );
  }
}
