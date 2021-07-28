import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:smart_controller/mobile/database/daos/server_dao.dart';
import 'package:smart_controller/mobile/entities/server_entity.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [ServerEntity])
abstract class AppDatabase extends FloorDatabase {
  ServerDao get serverDao;
}

Future<AppDatabase> databaseBuilder() =>
    $FloorAppDatabase.databaseBuilder('servers.db').build();
