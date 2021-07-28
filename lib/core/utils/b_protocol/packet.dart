import 'dart:math' show Random;
import 'dart:typed_data';

import 'package:smart_controller/core/utils/b_protocol/typed_payloads/payload_type_manger.dart';

class Packet {
  const Packet(this.action, this.connectionId, this.payload)
      : assert(action >= 0 && action <= 1 << 8, 'action only 1 byte'),
        assert(
          connectionId <= 1 << 16 && connectionId >= 0,
          'connection_id only 2bytes unsigned integer',
        ),
        assert(
          payload.length <= 256,
          'payload length only one byte [maximum encoded payload length is 256]',
        );

  final int action;
  final int connectionId;
  final List<int> payload;

  static fromPayloadType(
    PayloadType payloadType, [
    int? connectionId,
  ]) {
    final int action = PayloadTypeManager.getActionByPayloadType(payloadType);
    return Packet(
      action,
      connectionId ?? Packet.randomId(),
      payloadType.encode(),
    );
  }

  /// generate random secure id
  static int randomId() => Random.secure().nextInt(1 << 16);

  T toPayloadType<T extends PayloadType>() {
    final builder = PayloadTypeManager.getBuilder<T>(action);
    return builder.call(payload);
  }

  /// generate buffer
  List<int> encode() {
    ByteData header = ByteData(4);
    header.setUint8(0, action);
    header.setUint16(1, connectionId);
    header.setUint8(3, payload.length);
    final buffer = header.buffer.asUint8List().toList();
    buffer.addAll(payload);
    return buffer;
  }

  static Packet decode(List<int> buffer) {
    final ByteData data = Uint8List.fromList(buffer).buffer.asByteData();
    final int action = data.getUint8(0);
    final int connectionId = data.getUint16(1);
    final int payloadLength = data.getUint8(3);

    final int start = 4;
    final List<int> payload = buffer
        .getRange(
          start,
          start + payloadLength,
        )
        .toList();

    return Packet(action, connectionId, payload);
  }
}

// class Packet extends BPacket {
//   Packet(int action, int connectionId, List<int> payload)
//       : super(
//           action,
//           connectionId,
//           payload,
//         );

//   factory Packet.random(int action, List<int> payload) => Packet(
//         action,
//         BPacket.randomId(),
//         payload,
//       );

  
// }
