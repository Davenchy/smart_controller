// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerEntity _$ServerEntityFromJson(Map<String, dynamic> json) {
  return ServerEntity(
    id: json['id'] as int?,
    name: json['name'] as String,
    ip: json['ip'] as String,
    port: json['port'] as int,
  );
}

Map<String, dynamic> _$ServerEntityToJson(ServerEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ip': instance.ip,
      'port': instance.port,
    };
