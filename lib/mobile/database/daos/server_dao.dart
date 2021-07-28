import 'package:floor/floor.dart';
import 'package:smart_controller/mobile/entities/server_entity.dart';

@dao
abstract class ServerDao {
  @Query('SELECT * FROM Server')
  Future<List<ServerEntity>> getAllServers();

  @insert
  Future<void> insertServer(ServerEntity server);

  @update
  Future<void> updateServer(ServerEntity server);

  @delete
  Future<void> removeServer(ServerEntity server);
}
