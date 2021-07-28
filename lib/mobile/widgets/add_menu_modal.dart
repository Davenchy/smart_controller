import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_controller/core/utils/shared.dart';
import 'package:smart_controller/mobile/controllers/mobile_controller.dart';
import 'package:smart_controller/mobile/entities/server_entity.dart';
import 'package:smart_controller/mobile/widgets/define_server_modal.dart';

class AddMenuModal extends StatelessWidget {
  const AddMenuModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.qr_code_rounded),
            title: Text('Scan QR Code'),
            onTap: () => _scan(context),
          ),
          ListTile(
            leading: Icon(Icons.edit_rounded),
            title: Text('Create Device'),
            onTap: () {
              Navigator.pop(context);
              openModal(context, DefineServerModal());
            },
          ),
        ],
      ),
    );
  }

  Future<void> _scan(BuildContext context) async {
    final String result = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      "Cancel",
      true,
      ScanMode.QR,
    );

    if (result != '-1') _defineServer(context, result);
  }

  Future<void> _defineServer(
    BuildContext context,
    String serverDataJson,
  ) async {
    final json = jsonDecode(serverDataJson);
    final info = ServerEntity.fromJson(json);
    await context.read(mobileControllerProvider).defineServer(info);
    Navigator.pop(context);
  }
}
