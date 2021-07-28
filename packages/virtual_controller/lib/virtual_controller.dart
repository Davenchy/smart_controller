library virtual_controller;

import 'dart:io';
import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';
import 'package:path/path.dart';

part 'src/generated_virtual_controller_bindings.dart';
part 'src/input_event_codes.dart';
part 'src/controller_builder.dart';

/// build and define controller pads
typedef OnControllerBuild = void Function(ControllerBuilder builder);

/// create simple virtual controller
///
/// predefined constants can be found in `./input_event_codes.dart`
/// [BTNCode], [EventType], [EventCode], [RelativeCode], [AbsoluteCode], [ToggleValue]
class VirtualController {
  VirtualController({
    required this.name,
    required this.vendor,
    required this.product,
    required OnControllerBuild onControllerBuild,
  })  : assert(name.length <= 80, 'controller name maximum length is 80'),
        assert(Platform.isLinux, 'only linux supported') {
    final fullPath = join(
      File(Platform.resolvedExecutable).parent.path,
      'lib',
      'lib_virtual_controller.so',
    );
    _controller = VirtualControllerFFI(
      ffi.DynamicLibrary.open(fullPath),
    );

    controllerFileDescriptor = _controller.openRequest();

    final builder = ControllerBuilder(controllerFileDescriptor, _controller);
    onControllerBuild(builder);
    builder.build();

    _controller.createDevice(
      controllerFileDescriptor,
      name.toNativeUtf8().cast(),
      vendor,
      product,
    );

    sleep(const Duration(seconds: 1));
  }

  late final VirtualControllerFFI _controller;
  late final int controllerFileDescriptor;
  final String name;
  final int vendor;
  final int product;

  /// emit an event
  ///
  /// for [event] use [EventType]
  ///
  /// for [code] use [BTNCode], [RelativeCode], [AbsoluteCode], [EventCode]
  ///
  /// for [value] use any integer or predefine constant [ToggleValue]
  ///
  /// example
  /// `emitEvent(EventType.KEY, BTNCode.BTN_A, ToggleValue.pressed)`
  void emitEvent(int event, int code, int value) =>
      _controller.emitEvent(controllerFileDescriptor, event, code, value);

  /// emit a report
  ///
  /// used after emitting event or related events to sync
  void emitReport() => emitEvent(EventType.SYNC, EventCode.SYNC_REPORT, 0);

  /// set key or button state
  ///
  /// for [keyCode] use [BTNCode]
  /// Note: after emitting the event, emits a report too
  ///
  /// example:
  /// `setKeyState(BTNCode.BTN_A, true)`
  void setKeyState(int keyCode, bool isPressed) {
    emitEvent(
      EventType.KEY,
      keyCode,
      isPressed ? ToggleValue.on : ToggleValue.off,
    );
    emitReport();
  }

  /// emit event to set value of [code]
  ///
  /// for [type] use [EventType]
  /// for [code] use [BTNCode] [AbsoluteCode] [RelativeCode]
  /// for [value] use any [integer] number
  /// [emit] by default `true` set it to `false` to prevent auto sent report
  ///
  /// example
  /// `emitValue(EventType.Absolute, AbsoluteCode.ABS_X, 512)`
  void emitValue(int type, int code, int value, [bool emit = true]) {
    emitEvent(type, code, value);
    if (emit) emitReport();
  }

  /// press key of with [code] value
  ///
  /// example
  /// `pressKey(BTNCode.BTN_A)`
  void pressKey(int code) => setKeyState(code, true);

  /// release key of with [code] value
  ///
  /// example
  /// `pressKey(BTNCode.BTN_A)`
  void releaseKey(int code) => setKeyState(code, false);

  /// destroy controller
  ///
  /// very important to remove the controller from the system
  /// and close its file descriptor
  void destroy() {
    sleep(const Duration(seconds: 1));
    _controller.destroyDevice(controllerFileDescriptor);
    _controller.closeRequest(controllerFileDescriptor);
  }
}
