import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_controller/core/utils/constants.dart';
import 'package:smart_controller/core/widgets/button.dart';
import 'package:smart_controller/core/widgets/text.dart';
import 'package:smart_controller/mobile/controllers/mobile_controller.dart';
import 'package:smart_controller/mobile/entities/server_entity.dart';

class DefineServerModal extends StatefulWidget {
  DefineServerModal({Key? key, this.entity}) : super(key: key);

  final ServerEntity? entity;

  @override
  _DefineServerModalState createState() => _DefineServerModalState();
}

class _DefineServerModalState extends State<DefineServerModal> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final ipController = TextEditingController();

  final portController = TextEditingController();

  ServerEntity? get entity => widget.entity;
  bool get isEditMode => entity != null;

  @override
  void initState() {
    super.initState();

    if (isEditMode) {
      nameController.text = entity!.name;
      ipController.text = entity!.ip;
      portController.text = entity!.port.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            QText(
              'Define Server',
              size: 30,
              weight: FontWeight.bold,
            ),
            SizedBox(height: 20),
            _buildTextField(
              controller: nameController,
              label: 'Server Name',
              hint: 'e.g. My Gaming PC',
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Please enter server name!";
              },
            ),
            SizedBox(height: 10),
            _buildTextField(
              controller: ipController,
              label: 'Server IP (IPv4)',
              hint: 'e.g. 192.168.1.10',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Please enter server ip address!";

                const String error = "Invalid ip address!";

                if (value.length > 15 || value.length < 7) return error;

                final addressList = value.split('.');
                if (addressList.length != 4) return error;

                final r = addressList.every((code) {
                  final int? n = int.tryParse(code);
                  if (n == null || n < 0 || n > 255) return false;
                  return true;
                });

                if (!r) return error;
              },
            ),
            SizedBox(height: 10),
            _buildTextField(
              controller: portController,
              label: 'Server Port',
              hint: 'e.g. 8000',
              keyboardType: TextInputType.numberWithOptions(
                decimal: false,
                signed: false,
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Please enter server port!";

                final int? port = int.tryParse(value);
                if (port == null) return 'incorrect value';

                if (port < 1025 || port > 65535)
                  return "port must be in range [1025, 65535]";
              },
            ),
            SizedBox(height: 20),
            QButton(isEditMode ? 'Save' : 'Define',
                onPressed: () => _save(context)),
          ],
        ),
      ),
    );
  }

  TextFormField _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    required String? Function(String? value) validator,
    TextInputType? keyboardType,
  }) =>
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        validator: validator,
      );

  Future<void> _save(BuildContext context) async {
    final FormState? state = formKey.currentState;
    if (state == null || !state.validate()) return;

    final String name = nameController.text;
    final String ip = ipController.text;
    final String p = portController.text;
    final int port = int.tryParse(p) ?? defaultPort;

    final ServerEntity entity = ServerEntity(
      id: isEditMode ? this.entity!.id : null,
      name: name,
      ip: ip,
      port: port,
    );

    final controller = context.read(mobileControllerProvider);

    if (isEditMode) {
      await controller.updateServer(entity);
    } else {
      await controller.defineServer(entity);
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    portController.dispose();
    ipController.dispose();
    super.dispose();
  }
}
