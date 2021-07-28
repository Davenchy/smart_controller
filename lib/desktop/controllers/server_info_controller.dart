import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_controller/core/utils/constants.dart';

final serverInfoController = ChangeNotifierProvider<ServerInfoController>(
  (ref) => ServerInfoController(),
  name: "Server Information Controller",
);

class ServerInfoController extends ChangeNotifier {
  String _serverName = "";
  String _ip = "";
  int _port = 0;
  bool _isReady = false;

  String get serverName => _serverName;
  String get ip => _ip;
  int get port => _port;
  String get portStr => _port.toString();
  bool get isReady => _isReady;

  Future<void> loadData() async {
    _isReady = false;
    notifyListeners();

    final info = NetworkInfo();
    _ip = await info.getWifiIP() ?? "Unknown";

    final prefs = await SharedPreferences.getInstance();
    _port = prefs.getInt('port') ?? defaultPort;
    _serverName =
        prefs.getString('server_name') ?? '$defaultMachineName`s Server';

    _isReady = true;

    notifyListeners();
  }
}
