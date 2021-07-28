import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_controller/core/widgets/button.dart';
import 'package:smart_controller/core/widgets/text.dart';
import 'package:smart_controller/desktop/controllers/server_info_controller.dart';
import 'package:smart_controller/mobile/entities/server_entity.dart';

class AddDeviceModal extends StatelessWidget {
  const AddDeviceModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final controller = watch(serverInfoController);

        if (controller.isReady)
          return _buildBody(context, controller);
        else
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: QText('Loading...', size: 20, weight: FontWeight.bold),
            ),
          );
      },
    );
  }

  Widget _buildBody(BuildContext context, ServerInfoController controller) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            child: QText(
              'Add Device',
              align: TextAlign.center,
              size: 30,
              weight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          _buildRowText('Server Name:', controller.serverName),
          _buildRowText('Local IP:', controller.ip),
          SizedBox(height: 10.0),
          Center(
            child: QrImage(
              data: jsonEncode(
                ServerEntity(
                  name: controller.serverName,
                  ip: controller.ip,
                  port: controller.port,
                ).toJson(),
              ),
              size: 180,
            ),
          ),
          SizedBox(height: 10.0),
          QButton(
            'CLOSE',
            onPressed: () => Navigator.of(context).pop(),
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
