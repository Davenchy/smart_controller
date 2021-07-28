import 'dart:io';

import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'server_entity.g.dart';

@Entity(tableName: 'Server')
@JsonSerializable()
class ServerEntity {
  ServerEntity({
    this.id,
    required this.name,
    required this.ip,
    required this.port,
  });

  @primaryKey
  final int? id;
  final String name;
  final String ip;
  final int port;

  InternetAddress get address => InternetAddress(ip);

  factory ServerEntity.fromJson(Map<String, dynamic> json) =>
      _$ServerEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ServerEntityToJson(this);
}
