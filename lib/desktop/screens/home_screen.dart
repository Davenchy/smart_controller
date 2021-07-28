import 'package:flutter/material.dart';
import 'package:smart_controller/core/utils/shared.dart';
import 'package:smart_controller/core/widgets/text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_controller/desktop/controllers/desktop_controller.dart';
import 'package:smart_controller/desktop/controllers/server_info_controller.dart';
import 'package:smart_controller/desktop/widgets/add_device_modal.dart';
import 'package:smart_controller/desktop/widgets/device_view.dart';
import 'package:smart_controller/desktop/widgets/disconnect_modal.dart';
import 'package:smart_controller/desktop/widgets/settings_modal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Controller"),
        actions: [
          IconButton(
            onPressed: () => _openSettingsModal(context),
            icon: Icon(Icons.add),
            tooltip: 'add new devices',
          ),
          Consumer(
            builder: (context, watch, child) {
              final controller = watch(desktopControllerProvider);
              return IconButton(
                onPressed:
                    controller.isBusy ? null : () => controller.restartServer(),
                icon: Icon(Icons.restart_alt_rounded),
                tooltip: 'restart server',
              );
            },
          ),
          IconButton(
            onPressed: () => openModal(context, SettingsModal()),
            icon: Icon(Icons.settings),
            tooltip: 'settings',
          ),
        ],
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final state = watch(desktopControllerProvider);
          if (state.isBusy)
            return _buildMessage(state.busyMessage);
          else
            return _buildList(context, state);
        },
      ),
    );
  }

  Widget _buildMessage(String message) => Center(
        child: QText(message, size: 20, weight: FontWeight.bold),
      );

  Widget _buildList(BuildContext context, DesktopController controller) {
    final devices = controller.devices;
    if (devices.isEmpty) return _buildMessage('No Devices');
    return ListView.separated(
      itemBuilder: (context, index) {
        final device = devices[index];
        return DeviceView(
          device: device,
          onDisconnectPressed: () => openModal(
            context,
            DisconnectModal(
              () {
                controller.disconnect(device);
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => Divider(),
      itemCount: devices.length,
    );
  }

  void _openSettingsModal(BuildContext context) {
    context.read(serverInfoController).loadData();
    openModal(context, AddDeviceModal());
  }
}
