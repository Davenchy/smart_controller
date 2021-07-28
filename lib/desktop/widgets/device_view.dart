import 'package:flutter/material.dart';
import 'package:smart_controller/desktop/models/device.dart';

class DeviceView extends StatelessWidget {
  const DeviceView({
    Key? key,
    required this.device,
    required this.onDisconnectPressed,
  }) : super(key: key);

  final Device device;
  final void Function() onDisconnectPressed;

  @override
  Widget build(BuildContext context) {
    final String networkAddress =
        '${device.peer.address.address}:${device.peer.port}';

    return ListTile(
      title: Text(
        device.isConnecting
            ? 'Connecting with $networkAddress'
            : '${device.name} - $networkAddress',
        style: TextStyle(
          color: device.isActive ? Colors.green : null,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDisconnectPressed,
            icon: Icon(
              Icons.app_blocking_rounded,
              color: Colors.red,
            ),
            tooltip: 'disconnect',
          ),
        ],
      ),
    );
  }
}
