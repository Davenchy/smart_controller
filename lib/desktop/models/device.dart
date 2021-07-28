import 'package:smart_controller/core/utils/b_protocol/peer.dart';
import 'package:virtual_controller/virtual_controller.dart';

const min = -512;
const max = 512;
// const diff = max - min;

class Device {
  Device({
    required this.peer,
    this.name = 'Unknown Device',
    this.isConnecting = false,
    DateTime? lastActive,
  }) : this.lastActive = lastActive ?? DateTime.now();

// todo: create getter and setter
  final BPeer peer;
  String name;
  bool isConnecting;
  DateTime lastActive;
  VirtualController? _controller;

  bool get isActive => _controller != null;

  void createController() {
    if (isActive) return;
    _controller = VirtualController(
      name: name,
      vendor: 0x2255,
      product: 0x0089,
      onControllerBuild: (builder) {
        builder.setKeyCode(BTNCode.BTN_A);
        builder.setKeyCode(BTNCode.BTN_B);
        builder.setKeyCode(BTNCode.BTN_X);
        builder.setKeyCode(BTNCode.BTN_Y);

        builder.setKeyCode(BTNCode.BTN_DPAD_UP);
        builder.setKeyCode(BTNCode.BTN_DPAD_DOWN);
        builder.setKeyCode(BTNCode.BTN_DPAD_LEFT);
        builder.setKeyCode(BTNCode.BTN_DPAD_RIGHT);

        builder.setKeyCode(BTNCode.BTN_TL);
        builder.setKeyCode(BTNCode.BTN_TR);

        builder.setKeyCode(BTNCode.BTN_TL2);
        builder.setKeyCode(BTNCode.BTN_TR2);

        builder.setKeyCode(BTNCode.BTN_SELECT);
        builder.setKeyCode(BTNCode.BTN_START);

        builder.setKeyCode(BTNCode.BTN_THUMBL);
        builder.setKeyCode(BTNCode.BTN_THUMBR);

        builder.setAbsCode(AbsoluteCode.ABS_X, min, max);
        builder.setAbsCode(AbsoluteCode.ABS_Y, min, max);

        builder.setAbsCode(AbsoluteCode.ABS_RX, min, max);
        builder.setAbsCode(AbsoluteCode.ABS_RY, min, max);
      },
    );
  }

  void setControllerAction(int type, int key, int value) {
    // print('type: $type, key: $key, value: $value');
    _controller!.emitValue(
      type,
      key,
      value,
    );
  }

  // void setControllerAction(Map<String, Object?> commands) {
  //   if (!isActive) return;

  //   print(commands);

  //   final btnA = commands['BTN_A'] as bool?;
  //   final btnB = commands['BTN_B'] as bool?;
  //   final btnX = commands['BTN_X'] as bool?;
  //   final btnY = commands['BTN_Y'] as bool?;

  //   final absX = commands['DPAD_X'] as double?;
  //   final absY = commands['DPAD_Y'] as double?;

  //   if (btnA != null) _controller!.setKeyState(BTNCode.BTN_A, btnA);
  //   if (btnB != null) _controller!.setKeyState(BTNCode.BTN_B, btnB);
  //   if (btnX != null) _controller!.setKeyState(BTNCode.BTN_X, btnX);
  //   if (btnY != null) _controller!.setKeyState(BTNCode.BTN_Y, btnY);

  //   if (absX != null)
  //     _controller!.emitValue(
  //       EventType.ABSOLUTE,
  //       AbsoluteCode.ABS_X,
  //       (diff * absX + min).toInt(),
  //     );

  //   if (absY != null)
  //     _controller!.emitValue(
  //       EventType.ABSOLUTE,
  //       AbsoluteCode.ABS_Y,
  //       (diff * absY + min).toInt(),
  //     );
  // }

  void killController() {
    if (!isActive) return;
    _controller!.destroy();
  }
}
