import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

const Size screenSize = Size(400, 650);

Future<void> setupDesktopWindow() async {
  setWindowMaxSize(screenSize);
  setWindowMinSize(screenSize);
  final Screen? screen = await getCurrentScreen();

  final Rect rect = Rect.fromLTWH(
    screen != null ? screen.visibleFrame.width / 2 - screenSize.width / 2 : 0,
    screen != null ? screen.visibleFrame.height / 2 - screenSize.height / 2 : 0,
    screenSize.width,
    screenSize.height,
  );
  setWindowFrame(rect);
}
