import 'package:flutter/material.dart';
import 'package:virtual_controller/virtual_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final VirtualController controller;

  @override
  void initState() {
    super.initState();
    controller = VirtualController(
      name: 'My Controller',
      vendor: 0x1234,
      product: 0x5678,
      onControllerBuild: (builder) {
        builder.setKeyCode(BTNCode.BTN_A);
      },
    );
  }

  @override
  void dispose() {
    controller.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: GestureDetector(
            onTapUp: (_) => controller.setKeyState(BTNCode.BTN_A, false),
            onTapDown: (_) => controller.setKeyState(BTNCode.BTN_A, true),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
