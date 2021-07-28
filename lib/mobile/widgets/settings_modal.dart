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

  final controllerNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snap) {
        if (snap.hasData)
          return _buildBody(context, snap.data!);
        else if (snap.hasError) {
          print(snap.error);
          return Center(
            child: QText('Failed to load settings', size: 18),
          );
        } else
          return Center(
            child: QText('Loading Settings...', size: 18),
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
            QText(
              'Settings',
              size: 30.0,
              weight: FontWeight.bold,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: controllerNameController
                ..text = prefs.getString('controller_name') ??
                    "$defaultMachineName`s VController",
              decoration: InputDecoration(
                labelText: 'Controller Name',
                hintText: 'VController',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Please enter controller name!';
              },
            ),
            SizedBox(height: 20),
            QButton(
              "SAVE",
              color: Colors.green,
              onPressed: () => _save(context, prefs),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save(BuildContext context, SharedPreferences prefs) async {
    final FormState? state = formKey.currentState;
    if (state == null || !state.validate()) return;

    final String controllerName = controllerNameController.text;
    print(controllerName);
    prefs.setString('controller_name', controllerName);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    controllerNameController.dispose();
    super.dispose();
  }
}
