import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_controller/core/utils/b_protocol/peer.dart';
import 'package:smart_controller/core/utils/b_protocol/connection_manager.dart';
import 'package:smart_controller/core/utils/b_protocol/packet_event_controller.dart';
import 'package:smart_controller/core/utils/b_protocol/typed_payloads/payload_types.dart';
import 'package:smart_controller/core/utils/constants.dart';
import 'package:smart_controller/desktop/models/device.dart';

final desktopControllerProvider = ChangeNotifierProvider<DesktopController>(
  (ref) {
    final controller = DesktopController();
    return controller;
  },
  name: "Desktop Controller",
);

class DesktopController extends ChangeNotifier {
  DesktopController() : super() {
    _buildServer();
    _activityTimer = Timer.periodic(
      const Duration(seconds: 10),
      _activityTimerHandler,
    );
  }

  final List<Device> _devices = [];
  bool _isBusy = true;
  String _busyMessage = "Starting Server";

  List<Device> get devices => List<Device>.unmodifiable(_devices);
  bool get isBusy => _isBusy;
  String get busyMessage => _busyMessage;

  BConnectionManager? _connectionManager;
  late final Timer _activityTimer;

  bool get isServerRunning => _connectionManager != null;

  // overrides
  @override
  Future<void> dispose() async {
    print('killing controller');
    _activityTimer.cancel();
    if (isServerRunning) await _connectionManager!.close();
    super.dispose();
  }

  // controller methods
  /// restart the server
  Future<void> restartServer() async {
    _setBusyState('Restarting Server...');
    for (Device device in _devices)
      await device.peer.sendPayload(DisconnectPayloadType());
    _devices.clear();

    await Future.delayed(const Duration(seconds: 1));
    await _buildServer();
    _setLiveState();
  }

  /// disconnect [device] and remove from devices list
  void disconnect(Device device) {
    print('disconnect');
    _disconnectDevice(device);
    _setLiveState();
  }

  // handlers
  /// handle any new peers
  void _onNewPeer(CME_NewPeer event) {
    final device = Device(peer: event.peer, isConnecting: true);
    if (!_devices.contains(device)) _devices.add(device);
    _setLiveState();
  }

  /// handle received packets
  Future<void> _onPacket(PacketEventController controller) async {
    final device = _findDevice(controller.peer);
    device.lastActive = DateTime.now();
    if (controller.isOK) return;
    // print('On Desktop - ${controller.payload}');

    if (!controller.isConnect && device.isConnecting) {
      // print('ask who are you');
      controller.answer(WhoAreYouPayloadType());
      _devices.remove(device);
      return;
    }

    if (controller.isConnect) {
      // print('connect');
      device.name = (controller.payload as ConnectPayloadType).deviceName;
      device.isConnecting = false;
      _setLiveState();
      controller.sendOK();
    } else if (controller.isActivate) {
      // TODO: read controller config in the payload
      // print('activate');
      device.createController();
      controller.sendOK();
    } else if (controller.isDeactivate) {
      // print('deactivate');
      device.killController();
      controller.sendOK();
    } else if (controller.isKeepAlive) {
      controller.sendOK();
    } else if (controller.isActivate) {
      if (!device.isActive) device.createController();
      controller.sendOK();
    } else if (controller.isCommand) {
      final CommandPayloadType payload =
          controller.payload as CommandPayloadType;
      device.setControllerAction(payload.type, payload.key, payload.value);
    } else if (controller.isDisconnect) {
      // print('android says bye');
      _disconnectDevice(device);
      _setLiveState();
      controller.sendOK();
    }
  }

  /// check inactive devices and disconnect them
  void _activityTimerHandler(Timer timer) {
    if (_devices.isEmpty) return;

    final minimumActiveTime = Duration(
          microseconds: DateTime.now().microsecondsSinceEpoch,
        ) -
        Duration(seconds: 20);

    devices.forEach((device) {
      final lastActive = Duration(
        microseconds: device.lastActive.microsecondsSinceEpoch,
      );

      if (lastActive < minimumActiveTime) {
        _disconnectDevice(device);
        print('kill android');
      } else if (device.isConnecting) {
        device.peer.sendPayload(WhoAreYouPayloadType());
      }
    });

    _setLiveState();
  }

  // utils
  /// build or restart server and listen to its events
  Future<void> _buildServer() async {
    final prefs = await SharedPreferences.getInstance();
    final int port = prefs.getInt('port') ?? defaultPort;

    if (isServerRunning) await _connectionManager!.close();

    _connectionManager = await BConnectionManager.create(port);
    _connectionManager!.onPacket(_onPacket);
    _connectionManager!.handleEventOn<CME_NewPeer>(_onNewPeer);
    _setLiveState();
  }

  /// find [Device] with [peer] in device list or create new one
  Device _findDevice(BPeer peer) => _devices.firstWhere(
        (device) => device.peer == peer,
        orElse: () {
          final device = Device(
            peer: peer,
            isConnecting: true,
          );
          _devices.add(device);
          return device;
        },
      );

  /// set current state to live
  void _setLiveState() {
    // print('live state');
    _isBusy = false;
    _busyMessage = "";
    this.notifyListeners();
  }

  /// set current state to busy and show [message]
  void _setBusyState(String message) {
    // print('busy state');
    _isBusy = true;
    _busyMessage = message;
    notifyListeners();
  }

  /// disconnect device and remove it from the list without refreshing ui
  Future<void> _disconnectDevice(Device device) async {
    device.killController();
    _devices.remove(device);
    await device.peer.sendPayload(DisconnectPayloadType());
  }
}
