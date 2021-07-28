import 'package:flutter/material.dart';
import 'package:smart_controller/core/widgets/text.dart';

class HelpModal extends StatelessWidget {
  const HelpModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          QText(
            'Label Colors',
            size: 20,
            weight: FontWeight.bold,
            align: TextAlign.center,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              QText('Orange', size: 16, color: Colors.orange),
              SizedBox(width: 10),
              QText('color text for unknown state', size: 16),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              QText('Red', size: 16, color: Colors.red),
              SizedBox(width: 10),
              QText('color text for offline state', size: 16),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              QText('Green', size: 16, color: Colors.green),
              SizedBox(width: 10),
              QText('color text for online state', size: 16),
            ],
          ),
        ],
      ),
    );
  }
}
