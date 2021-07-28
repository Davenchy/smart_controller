import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_controller/core/utils/b_protocol/connection_manager.dart';
import 'package:smart_controller/core/utils/b_protocol/peer.dart';
import 'package:smart_controller/core/utils/b_protocol/typed_payloads/payload_types.dart';
import 'package:smart_controller/core/utils/constants.dart';
import 'package:smart_controller/mobile/database/app_database.dart';
import 'package:smart_controller/mobile/entities/server_entity.dart';

enum ServerState {
  online,
  offline,
  unknown,
}

final mobileControllerProvider = ChangeNotifierProvider<MobileController>(
  (ref) => MobileController(),
  name: 'Mobile Controller',
);

class MobileController extends ChangeNotifier {
  MobileController() {
    refreshServers();
    _timer = Timer.periodic(const Duration(seconds: 5), _fetchServerState);
    _fetchServerState(null);
  }

  final List<ServerEntity> _entities = [];
  final Map<int, ServerState> _serversState = {};
  late final Timer _timer;
  bool _isBusy = true;
  String _busyMessage = 'Loading Servers';

  List<ServerEntity> get entities => List.unmodifiable(_entities);
  Map<int, ServerState> get serversState => Map.unmodifiable(_serversState);
  bool get isBusy => _isBusy;
  String get bustMessage => _busyMessage;
  AppDatabase? _databaseInstance;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _setLiveState() {
    _isBusy = false;
    _busyMessage = '';
    notifyListeners();
  }

  void _setBusyState(String message) {
    _isBusy = true;
    _busyMessage = message;
    notifyListeners();
  }

  Future<void> _fetchServerState(timer) async {
    _serversState.clear();
    await Future.forEach<ServerEntity>(_entities, (entity) async {
      _serversState[entity.id!] = ServerState.unknown;
      try {
        final BPeer peer = await BConnectionManager.connect(
          entity.address,
          entity.port,
        );

        final ans = await peer.sendPayload(
          KeepAlivePayloadType(),
          timeout: const Duration(seconds: 2),
          retries: 2,
        );

        if (ans != null) {
          if (ans.isWhoAreYou) {
            // print('id requested');
            ans.answer(
              ConnectPayloadType(
                (await SharedPreferences.getInstance())
                        .getString('controller_name') ??
                    '$defaultMachineName`s VController',
              ),
            );
          }

          _serversState[entity.id!] = ServerState.online;
        } else
          _serversState[entity.id!] = ServerState.offline;

        await peer.close();
      } catch (err) {
        print('ERROR(Fetch Server State): $err');
      }
    });
    if (!_isBusy) notifyListeners();
  }

  Future<AppDatabase> get database async {
    if (_databaseInstance == null) _databaseInstance = await databaseBuilder();
    return _databaseInstance!;
  }

  Future<void> refreshServers() async {
    _setBusyState('Refresh Servers');
    _entities.clear();
    final List<ServerEntity> dbEntities =
        await (await database).serverDao.getAllServers();
    _entities.addAll(dbEntities);
    _setLiveState();
  }

  Future<void> defineServer(ServerEntity serverEntity) async {
    _setBusyState('Defining New Server');
    await (await database).serverDao.insertServer(serverEntity);
    refreshServers();
  }

  Future<void> updateServer(ServerEntity serverEntity) async {
    _setBusyState('Updating Server');
    await (await database).serverDao.updateServer(serverEntity);
    refreshServers();
  }

  Future<void> removeServer(ServerEntity serverEntity) async {
    _setBusyState('Removing Server');
    await (await database).serverDao.removeServer(serverEntity);
    _entities.remove(serverEntity);
    refreshServers();
  }
}
