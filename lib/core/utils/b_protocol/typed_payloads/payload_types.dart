import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'payload_type_manger.dart';

class ConnectPayloadType implements PayloadType {
  ConnectPayloadType(this.deviceName);
  final String deviceName;

  static ConnectPayloadType builder(List<int> payload) =>
      ConnectPayloadType(String.fromCharCodes(payload));

  @override
  List<int> encode() => deviceName.codeUnits;
}

class OKPayloadType implements PayloadType {
  OKPayloadType();

  static OKPayloadType builder(List<int> payload) => OKPayloadType();

  @override
  List<int> encode() => const [];
}

class ActivatePayloadType implements PayloadType {
  ActivatePayloadType();

  static ActivatePayloadType builder(List<int> payload) =>
      ActivatePayloadType();

  @override
  List<int> encode() => const [];
}

class DeactivatePayloadType implements PayloadType {
  DeactivatePayloadType();

  static DeactivatePayloadType builder(List<int> payload) =>
      DeactivatePayloadType();

  @override
  List<int> encode() => const [];
}

class KeepAlivePayloadType implements PayloadType {
  KeepAlivePayloadType();

  static KeepAlivePayloadType builder(List<int> payload) =>
      KeepAlivePayloadType();

  @override
  List<int> encode() => const [];
}

class DisconnectPayloadType implements PayloadType {
  DisconnectPayloadType();

  static DisconnectPayloadType builder(List<int> payload) =>
      DisconnectPayloadType();

  @override
  List<int> encode() => const [];
}

class WhoAreYouPayloadType implements PayloadType {
  WhoAreYouPayloadType();

  static WhoAreYouPayloadType builder(List<int> payload) =>
      WhoAreYouPayloadType();

  @override
  List<int> encode() => const [];
}

class CommandPayloadType implements PayloadType {
  CommandPayloadType(this.type, this.key, this.value);

  final int type;
  final int key;
  final int value;

  static CommandPayloadType builder(List<int> payload) {
    final ByteData data = ByteData.view(Uint8List.fromList(payload).buffer);
    return CommandPayloadType(
      data.getUint8(0),
      data.getUint16(1),
      data.getInt16(3),
    );
  }

  @override
  List<int> encode() {
    final ByteData byteData = ByteData(5);
    byteData.setUint8(0, type);
    byteData.setUint16(1, key);
    byteData.setInt16(3, value);
    return byteData.buffer.asUint8List();
  }
}
