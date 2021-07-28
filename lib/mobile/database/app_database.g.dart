// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ServerDao? _serverDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Server` (`id` INTEGER, `name` TEXT NOT NULL, `ip` TEXT NOT NULL, `port` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ServerDao get serverDao {
    return _serverDaoInstance ??= _$ServerDao(database, changeListener);
  }
}

class _$ServerDao extends ServerDao {
  _$ServerDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _serverEntityInsertionAdapter = InsertionAdapter(
            database,
            'Server',
            (ServerEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'ip': item.ip,
                  'port': item.port
                }),
        _serverEntityUpdateAdapter = UpdateAdapter(
            database,
            'Server',
            ['id'],
            (ServerEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'ip': item.ip,
                  'port': item.port
                }),
        _serverEntityDeletionAdapter = DeletionAdapter(
            database,
            'Server',
            ['id'],
            (ServerEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'ip': item.ip,
                  'port': item.port
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ServerEntity> _serverEntityInsertionAdapter;

  final UpdateAdapter<ServerEntity> _serverEntityUpdateAdapter;

  final DeletionAdapter<ServerEntity> _serverEntityDeletionAdapter;

  @override
  Future<List<ServerEntity>> getAllServers() async {
    return _queryAdapter.queryList('SELECT * FROM Server',
        mapper: (Map<String, Object?> row) => ServerEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            ip: row['ip'] as String,
            port: row['port'] as int));
  }

  @override
  Future<void> insertServer(ServerEntity server) async {
    await _serverEntityInsertionAdapter.insert(
        server, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateServer(ServerEntity server) async {
    await _serverEntityUpdateAdapter.update(server, OnConflictStrategy.abort);
  }

  @override
  Future<void> removeServer(ServerEntity server) async {
    await _serverEntityDeletionAdapter.delete(server);
  }
}
