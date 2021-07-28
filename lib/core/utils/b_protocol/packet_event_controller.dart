import 'package:smart_controller/core/utils/b_protocol/packet.dart';
import 'package:smart_controller/core/utils/b_protocol/connection_manager.dart';
import 'package:smart_controller/core/utils/b_protocol/peer.dart';
import 'package:smart_controller/core/utils/b_protocol/typed_payloads/payload_type_manger.dart';
import 'package:smart_controller/core/utils/b_protocol/typed_payloads/payload_types.dart';

class PacketEventController<T extends PayloadType> {
  PacketEventController(this.event) {
    peer = event.peer;
    packet = event.packet;
    connectionId = packet.connectionId;
    payload = packet.toPayloadType<T>();
  }

  final CME_Packet event;
  late final BPeer peer;
  late final Packet packet;
  late final int connectionId;
  late final T payload;

  bool check<T extends PayloadType>() => payload is T;

  bool get isOK => check<OKPayloadType>();
  bool get isDisconnect => check<DisconnectPayloadType>();
  bool get isConnect => check<ConnectPayloadType>();
  bool get isActivate => check<ActivatePayloadType>();
  bool get isDeactivate => check<DeactivatePayloadType>();
  bool get isKeepAlive => check<KeepAlivePayloadType>();
  bool get isWhoAreYou => check<WhoAreYouPayloadType>();
  bool get isCommand => check<CommandPayloadType>();

  Future<PacketEventController<T>?> sendOK<T extends PayloadType>() =>
      answer<T>(OKPayloadType());

  Future<PacketEventController<T>?> send<T extends PayloadType>(
    T payload,
  ) =>
      peer.sendPayload<T>(payload);

  Future<PacketEventController<T>?> answer<T extends PayloadType>(
    PayloadType payload,
  ) =>
      peer.sendPayload<T>(payload, connectionId: connectionId);
}
