import 'package:flutter/material.dart';
import 'package:smart_controller/core/widgets/button.dart';
import 'package:smart_controller/core/widgets/text.dart';

class DisconnectModal extends StatelessWidget {
  const DisconnectModal(this.disconnect, {Key? key}) : super(key: key);

  final void Function() disconnect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: QText(
              'Disconnect Device',
              size: 30,
              weight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          QText(
            'Do you really want to disconnect this device?',
            size: 20,
          ),
          SizedBox(height: 10),
          QText(
            'This device can reconnect again!',
            size: 18,
            weight: FontWeight.bold,
          ),
          SizedBox(height: 20),
          QButton(
            'DISCONNECT',
            color: Colors.red,
            onPressed: disconnect,
          ),
          SizedBox(height: 10),
          QButton(
            'CANCEL',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
