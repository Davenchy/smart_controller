import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_controller/core/utils/constants.dart';
import 'package:smart_controller/core/widgets/button.dart';
import 'package:smart_controller/core/widgets/text.dart';

class SettingsModal extends StatefulWidget {
  SettingsModal({Key? key}) : super(key: key);

  @override
  _SettingsModalState createState() => _SettingsModalState();
}

class _SettingsModalState extends State<SettingsModal> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final portController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return _buildBody(context, snapshot.data!);
        else if (snapshot.hasError) {
          print(snapshot.error);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: QText(
                'Failed To Load Settings',
                size: 20,
                weight: FontWeight.bold,
              ),
            ),
          );
        } else
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: QText(
                'Loading Settings',
                size: 20,
                weight: FontWeight.bold,
              ),
            ),
          );
      },
    );
  }

  Widget _buildBody(BuildContext context, SharedPreferences prefs) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildTextField(
              label: 'Server Name',
              controller: nameController
                ..text = prefs.getString('server_name') ??
                    '$defaultMachineName`s Server',
              validator: (String? name) {
                if (name == null || name.isEmpty)
                  return 'please enter server name';
                if (name.length > 20) return 'maximum length is 20 character';
              },
            ),
            SizedBox(height: 10),
            _buildTextField(
              label: 'Port',
              hint: 'port must be in range [1025, 65535]',
              controller: portController
                ..text =
                    prefs.getInt('port')?.toString() ?? defaultPort.toString(),
              keyboardType: TextInputType.numberWithOptions(
                signed: false,
                decimal: false,
              ),
              validator: (String? portStr) {
                if (portStr == null || portStr.isEmpty)
                  return 'please enter port';
                final int? port = int.tryParse(portStr);
                if (port == null) return 'only numbers allowed';
                if (port < 1025 || port > 65535)
                  return 'port must be in range [1025, 65535]';
              },
            ),
            SizedBox(height: 20),
            QButton(
              'SAVE',
              onPressed: () => _save(context, prefs),
              color: Colors.green,
            ),
            SizedBox(height: 10),
            QButton(
              'CANCEL',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _buildTextField({
    required String label,
    String? hint,
    TextEditingController? controller,
    TextInputType? keyboardType,
    String? Function(String? value)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: validator,
    );
  }

  void _save(BuildContext context, SharedPreferences prefs) {
    final FormState? state = formKey.currentState;
    if (state == null || !state.validate()) return;

    final int port = int.tryParse(portController.text) ?? defaultPort;
    prefs.setInt('port', port);

    prefs.setString('server_name', nameController.text);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    portController.dispose();
    super.dispose();
  }
}
