part of '../virtual_controller.dart';

class EventType {
  const EventType._();
  static const int SYNC = 0x00;
  static const int KEY = 0x01;
  static const int RELATIVE = 0x02;
  static const int ABSOLUTE = 0x03;
}

class EventCode {
  const EventCode._();
  static const int SYNC_REPORT = 0x00;
}

class BTNCode {
  const BTNCode._();
  static const int BTN_MISC = 0x100;
  static const int BTN_0 = 0x100;
  static const int BTN_1 = 0x101;
  static const int BTN_2 = 0x102;
  static const int BTN_3 = 0x103;
  static const int BTN_4 = 0x104;
  static const int BTN_5 = 0x105;
  static const int BTN_6 = 0x106;
  static const int BTN_7 = 0x107;
  static const int BTN_8 = 0x108;
  static const int BTN_9 = 0x109;
  static const int BTN_MOUSE = 0x110;
  static const int BTN_LEFT = 0x110;
  static const int BTN_RIGHT = 0x111;
  static const int BTN_MIDDLE = 0x112;
  static const int BTN_SIDE = 0x113;
  static const int BTN_EXTRA = 0x114;
  static const int BTN_FORWARD = 0x115;
  static const int BTN_BACK = 0x116;
  static const int BTN_TASK = 0x117;
  static const int BTN_JOYSTICK = 0x120;
  static const int BTN_TRIGGER = 0x120;
  static const int BTN_THUMB = 0x121;
  static const int BTN_THUMB2 = 0x122;
  static const int BTN_TOP = 0x123;
  static const int BTN_TOP2 = 0x124;
  static const int BTN_PINKIE = 0x125;
  static const int BTN_BASE = 0x126;
  static const int BTN_BASE2 = 0x127;
  static const int BTN_BASE3 = 0x128;
  static const int BTN_BASE4 = 0x129;
  static const int BTN_BASE5 = 0x12a;
  static const int BTN_BASE6 = 0x12b;
  static const int BTN_DEAD = 0x12f;
  static const int BTN_GAMEPAD = 0x130;
  static const int BTN_SOUTH = 0x130;
  static const int BTN_A = BTN_SOUTH;
  static const int BTN_EAST = 0x131;
  static const int BTN_B = BTN_EAST;
  static const int BTN_C = 0x132;
  static const int BTN_NORTH = 0x133;
  static const int BTN_X = BTN_NORTH;
  static const int BTN_WEST = 0x134;
  static const int BTN_DPAD_UP = 0x220;
  static const int BTN_DPAD_DOWN = 0x221;
  static const int BTN_DPAD_LEFT = 0x222;
  static const int BTN_DPAD_RIGHT = 0x223;
  static const int BTN_Y = BTN_WEST;
  static const int BTN_Z = 0x135;
  static const int BTN_TL = 0x136;
  static const int BTN_TR = 0x137;
  static const int BTN_TL2 = 0x138;
  static const int BTN_TR2 = 0x139;
  static const int BTN_SELECT = 0x13a;
  static const int BTN_START = 0x13b;
  static const int BTN_MODE = 0x13c;
  static const int BTN_THUMBL = 0x13d;
  static const int BTN_THUMBR = 0x13e;
  static const int BTN_WHEEL = 0x150;
  static const int BTN_GEAR_DOWN = 0x150;
  static const int BTN_GEAR_UP = 0x151;
}

class RelativeCode {
  const RelativeCode._();

  static const int REL_X = 0x00;
  static const int REL_Y = 0x01;
  static const int REL_Z = 0x02;
  static const int REL_RX = 0x03;
  static const int REL_RY = 0x04;
  static const int REL_RZ = 0x05;
  static const int REL_HWHEEL = 0x06;
  static const int REL_DIAL = 0x07;
  static const int REL_WHEEL = 0x08;
  static const int REL_MISC = 0x09;
}

class AbsoluteCode {
  const AbsoluteCode._();

  static const int ABS_X = 0x00;
  static const int ABS_Y = 0x01;
  static const int ABS_Z = 0x02;
  static const int ABS_RX = 0x03;
  static const int ABS_RY = 0x04;
  static const int ABS_RZ = 0x05;
  static const int ABS_THROTTLE = 0x06;
  static const int ABS_RUDDER = 0x07;
  static const int ABS_WHEEL = 0x08;
  static const int ABS_GAS = 0x09;
  static const int ABS_BRAKE = 0x0a;
  static const int ABS_HAT0X = 0x10;
  static const int ABS_HAT0Y = 0x11;
  static const int ABS_HAT1X = 0x12;
  static const int ABS_HAT1Y = 0x13;
  static const int ABS_HAT2X = 0x14;
  static const int ABS_HAT2Y = 0x15;
  static const int ABS_HAT3X = 0x16;
  static const int ABS_HAT3Y = 0x17;
  static const int ABS_PRESSURE = 0x18;
  static const int ABS_DISTANCE = 0x19;
  static const int ABS_TILT_X = 0x1a;
  static const int ABS_TILT_Y = 0x1b;
  static const int ABS_TOOL_WIDTH = 0x1c;
  static const int ABS_VOLUME = 0x20;
  static const int ABS_MISC = 0x28;
}

class ToggleValue {
  const ToggleValue._();
  static const int pressed = 1;
  static const int released = 0;
  static const int on = 1;
  static const int off = 0;
}
