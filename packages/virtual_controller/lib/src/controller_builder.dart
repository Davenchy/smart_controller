part of '../virtual_controller.dart';

class AbsoluteSetup {
  const AbsoluteSetup(this.code, this.min, this.max);
  final int code;
  final int min;
  final int max;
}

class ControllerBuilder {
  ControllerBuilder(this._fd, this._controller);

  final int _fd;
  final VirtualControllerFFI _controller;
  final List<int> _buttons = [];
  final List<int> _relatives = [];
  final List<AbsoluteSetup> _absolutes = [];

  void build() {
    if (_buttons.isNotEmpty) {
      _controller.setEventType(_fd, EventType.KEY);
      _buttons.forEach((code) => _controller.setKeyCode(_fd, code));
    }

    if (_relatives.isNotEmpty) {
      _controller.setEventType(_fd, EventType.RELATIVE);
      _relatives.forEach((code) => _controller.setRelCode(_fd, code));
    }

    if (_absolutes.isNotEmpty) {
      _controller.setEventType(_fd, EventType.ABSOLUTE);
      _absolutes.forEach(
        (setup) => _controller.setAbsCode(
          _fd,
          setup.code,
          setup.min,
          setup.max,
        ),
      );
    }
  }

  /// define controller key
  ///
  /// for [code] use [BTNCode]
  ///
  /// example
  /// `setKeyCode(BTNCode.BTN_A)`
  void setKeyCode(int code) => _buttons.add(code);

  /// define controller relative key
  ///
  /// for [code] use [RelativeCode]
  ///
  /// example
  /// `setRelCode(RelativeCode.REL_X)`
  void setRelCode(int code) => _relatives.add(code);

  /// define controller absolute key
  ///
  /// for [code] use [AbsoluteCode]
  ///
  /// example
  /// `setAbsCode(AbsoluteCode.ABS_X, -512, 512)`
  void setAbsCode(int code, [int min = -512, int max = 512]) =>
      _absolutes.add(AbsoluteSetup(code, min, max));
}
