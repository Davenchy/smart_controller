import 'package:flutter/material.dart';
import 'package:smart_controller/core/widgets/button.dart';
import 'package:smart_controller/core/widgets/text.dart';

class ConfirmModal extends StatelessWidget {
  const ConfirmModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          QText(
            'Delete Server',
            size: 30,
            weight: FontWeight.bold,
          ),
          SizedBox(height: 20),
          QText(
            'Do you want to delete this server definition?',
            size: 18,
            lineHeight: 1.8,
          ),
          SizedBox(height: 20),
          QButton(
            'Delete',
            color: Colors.red,
            onPressed: () => _close(context, true),
          ),
          SizedBox(height: 10),
          QButton('Cancel', onPressed: () => _close(context, false)),
        ],
      ),
    );
  }

  void _close(BuildContext context, bool value) =>
      Navigator.pop(context, value);
}
