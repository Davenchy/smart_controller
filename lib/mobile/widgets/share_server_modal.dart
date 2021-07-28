import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_controller/core/widgets/text.dart';
import 'package:smart_controller/mobile/entities/server_entity.dart';

class ShareServerModal extends StatelessWidget {
  const ShareServerModal(this.serverEntity, {Key? key}) : super(key: key);

  final ServerEntity serverEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            child: QText(
              'Share Server',
              align: TextAlign.center,
              size: 30,
              weight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          _buildRowText('Server Name:', serverEntity.name),
          _buildRowText('Server IP:', serverEntity.ip),
          _buildRowText('Server Port:', serverEntity.port.toString()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: QrImage(
                data: jsonEncode(serverEntity.toJson()),
                size: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildRowText(String title, String content) => Row(
        children: [
          QText(title, size: 18.0, weight: FontWeight.bold),
          SizedBox(width: 10.0),
          QText(content, size: 18.0),
        ],
      );
}
