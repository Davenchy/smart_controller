import 'dart:io';

import 'package:smart_controller/core/utils/b_protocol/connection_manager.dart';
import 'package:smart_controller/core/utils/b_protocol/packet.dart';
import 'package:smart_controller/core/utils/b_protocol/packet_event_controller.dart';
import 'package:smart_controller/core/utils/b_protocol/typed_payloads/payload_type_manger.dart';
import 'package:smart_controller/core/utils/b_protocol/typed_payloads/payload_types.dart';

class BPeer {
  const BPeer(this.connectionManager, this.address, this.port);

  final BConnectionManager connectionManager;
  final InternetAddress address;
  final int port;

  Future<PacketEventController<T>?> sendPacket<T extends PayloadType>(
    Packet packet, {
    Duration? timeout,
    int? retries,
  }) =>
      connectionManager.sendAndWait<T>(
        address,
        port,
        packet,
        timeout: timeout,
        retries: retries,
      );

  Future<PacketEventController<T>?> sendOKPacket<T extends PayloadType>(
    int? connectionId, {
    Duration? timeout,
    int? retries,
  }) =>
      sendPayload<T>(
        OKPayloadType(),
        connectionId: connectionId,
        timeout: timeout,
        retries: retries,
      );

  Future<PacketEventController<T>?> sendPayload<T extends PayloadType>(
    PayloadType payload, {
    int? connectionId,
    Duration? timeout,
    int? retries,
  }) {
    final Packet packet = Packet.fromPayloadType(payload, connectionId);
    return sendPacket(packet, timeout: timeout, retries: retries);
  }

  Future<void> close() => connectionManager.close();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BPeer && other.address == address && other.port == port;
  }

  @override
  int get hashCode => address.hashCode ^ port.hashCode;
}
