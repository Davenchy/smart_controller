// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'connection_manager.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ConnectionManagerEventTearOff {
  const _$ConnectionManagerEventTearOff();

  CME_Packet packet(BPeer peer, Packet packet) {
    return CME_Packet(
      peer,
      packet,
    );
  }

  CME_NewPeer newPeer(BPeer peer) {
    return CME_NewPeer(
      peer,
    );
  }

  CME_Error error(String error) {
    return CME_Error(
      error,
    );
  }
}

/// @nodoc
const $ConnectionManagerEvent = _$ConnectionManagerEventTearOff();

/// @nodoc
mixin _$ConnectionManagerEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BPeer peer, Packet packet) packet,
    required TResult Function(BPeer peer) newPeer,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BPeer peer, Packet packet)? packet,
    TResult Function(BPeer peer)? newPeer,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CME_Packet value) packet,
    required TResult Function(CME_NewPeer value) newPeer,
    required TResult Function(CME_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CME_Packet value)? packet,
    TResult Function(CME_NewPeer value)? newPeer,
    TResult Function(CME_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionManagerEventCopyWith<$Res> {
  factory $ConnectionManagerEventCopyWith(ConnectionManagerEvent value,
          $Res Function(ConnectionManagerEvent) then) =
      _$ConnectionManagerEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ConnectionManagerEventCopyWithImpl<$Res>
    implements $ConnectionManagerEventCopyWith<$Res> {
  _$ConnectionManagerEventCopyWithImpl(this._value, this._then);

  final ConnectionManagerEvent _value;
  // ignore: unused_field
  final $Res Function(ConnectionManagerEvent) _then;
}

/// @nodoc
abstract class $CME_PacketCopyWith<$Res> {
  factory $CME_PacketCopyWith(
          CME_Packet value, $Res Function(CME_Packet) then) =
      _$CME_PacketCopyWithImpl<$Res>;
  $Res call({BPeer peer, Packet packet});
}

/// @nodoc
class _$CME_PacketCopyWithImpl<$Res>
    extends _$ConnectionManagerEventCopyWithImpl<$Res>
    implements $CME_PacketCopyWith<$Res> {
  _$CME_PacketCopyWithImpl(CME_Packet _value, $Res Function(CME_Packet) _then)
      : super(_value, (v) => _then(v as CME_Packet));

  @override
  CME_Packet get _value => super._value as CME_Packet;

  @override
  $Res call({
    Object? peer = freezed,
    Object? packet = freezed,
  }) {
    return _then(CME_Packet(
      peer == freezed
          ? _value.peer
          : peer // ignore: cast_nullable_to_non_nullable
              as BPeer,
      packet == freezed
          ? _value.packet
          : packet // ignore: cast_nullable_to_non_nullable
              as Packet,
    ));
  }
}

/// @nodoc

class _$CME_Packet implements CME_Packet {
  _$CME_Packet(this.peer, this.packet);

  @override
  final BPeer peer;
  @override
  final Packet packet;

  @override
  String toString() {
    return 'ConnectionManagerEvent.packet(peer: $peer, packet: $packet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CME_Packet &&
            (identical(other.peer, peer) ||
                const DeepCollectionEquality().equals(other.peer, peer)) &&
            (identical(other.packet, packet) ||
                const DeepCollectionEquality().equals(other.packet, packet)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(peer) ^
      const DeepCollectionEquality().hash(packet);

  @JsonKey(ignore: true)
  @override
  $CME_PacketCopyWith<CME_Packet> get copyWith =>
      _$CME_PacketCopyWithImpl<CME_Packet>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BPeer peer, Packet packet) packet,
    required TResult Function(BPeer peer) newPeer,
    required TResult Function(String error) error,
  }) {
    return packet(peer, this.packet);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BPeer peer, Packet packet)? packet,
    TResult Function(BPeer peer)? newPeer,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (packet != null) {
      return packet(peer, this.packet);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CME_Packet value) packet,
    required TResult Function(CME_NewPeer value) newPeer,
    required TResult Function(CME_Error value) error,
  }) {
    return packet(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CME_Packet value)? packet,
    TResult Function(CME_NewPeer value)? newPeer,
    TResult Function(CME_Error value)? error,
    required TResult orElse(),
  }) {
    if (packet != null) {
      return packet(this);
    }
    return orElse();
  }
}

abstract class CME_Packet implements ConnectionManagerEvent {
  factory CME_Packet(BPeer peer, Packet packet) = _$CME_Packet;

  BPeer get peer => throw _privateConstructorUsedError;
  Packet get packet => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CME_PacketCopyWith<CME_Packet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CME_NewPeerCopyWith<$Res> {
  factory $CME_NewPeerCopyWith(
          CME_NewPeer value, $Res Function(CME_NewPeer) then) =
      _$CME_NewPeerCopyWithImpl<$Res>;
  $Res call({BPeer peer});
}

/// @nodoc
class _$CME_NewPeerCopyWithImpl<$Res>
    extends _$ConnectionManagerEventCopyWithImpl<$Res>
    implements $CME_NewPeerCopyWith<$Res> {
  _$CME_NewPeerCopyWithImpl(
      CME_NewPeer _value, $Res Function(CME_NewPeer) _then)
      : super(_value, (v) => _then(v as CME_NewPeer));

  @override
  CME_NewPeer get _value => super._value as CME_NewPeer;

  @override
  $Res call({
    Object? peer = freezed,
  }) {
    return _then(CME_NewPeer(
      peer == freezed
          ? _value.peer
          : peer // ignore: cast_nullable_to_non_nullable
              as BPeer,
    ));
  }
}

/// @nodoc

class _$CME_NewPeer implements CME_NewPeer {
  _$CME_NewPeer(this.peer);

  @override
  final BPeer peer;

  @override
  String toString() {
    return 'ConnectionManagerEvent.newPeer(peer: $peer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CME_NewPeer &&
            (identical(other.peer, peer) ||
                const DeepCollectionEquality().equals(other.peer, peer)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(peer);

  @JsonKey(ignore: true)
  @override
  $CME_NewPeerCopyWith<CME_NewPeer> get copyWith =>
      _$CME_NewPeerCopyWithImpl<CME_NewPeer>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BPeer peer, Packet packet) packet,
    required TResult Function(BPeer peer) newPeer,
    required TResult Function(String error) error,
  }) {
    return newPeer(peer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BPeer peer, Packet packet)? packet,
    TResult Function(BPeer peer)? newPeer,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (newPeer != null) {
      return newPeer(peer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CME_Packet value) packet,
    required TResult Function(CME_NewPeer value) newPeer,
    required TResult Function(CME_Error value) error,
  }) {
    return newPeer(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CME_Packet value)? packet,
    TResult Function(CME_NewPeer value)? newPeer,
    TResult Function(CME_Error value)? error,
    required TResult orElse(),
  }) {
    if (newPeer != null) {
      return newPeer(this);
    }
    return orElse();
  }
}

abstract class CME_NewPeer implements ConnectionManagerEvent {
  factory CME_NewPeer(BPeer peer) = _$CME_NewPeer;

  BPeer get peer => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CME_NewPeerCopyWith<CME_NewPeer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CME_ErrorCopyWith<$Res> {
  factory $CME_ErrorCopyWith(CME_Error value, $Res Function(CME_Error) then) =
      _$CME_ErrorCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class _$CME_ErrorCopyWithImpl<$Res>
    extends _$ConnectionManagerEventCopyWithImpl<$Res>
    implements $CME_ErrorCopyWith<$Res> {
  _$CME_ErrorCopyWithImpl(CME_Error _value, $Res Function(CME_Error) _then)
      : super(_value, (v) => _then(v as CME_Error));

  @override
  CME_Error get _value => super._value as CME_Error;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(CME_Error(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CME_Error implements CME_Error {
  _$CME_Error(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'ConnectionManagerEvent.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CME_Error &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  $CME_ErrorCopyWith<CME_Error> get copyWith =>
      _$CME_ErrorCopyWithImpl<CME_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BPeer peer, Packet packet) packet,
    required TResult Function(BPeer peer) newPeer,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BPeer peer, Packet packet)? packet,
    TResult Function(BPeer peer)? newPeer,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CME_Packet value) packet,
    required TResult Function(CME_NewPeer value) newPeer,
    required TResult Function(CME_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CME_Packet value)? packet,
    TResult Function(CME_NewPeer value)? newPeer,
    TResult Function(CME_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CME_Error implements ConnectionManagerEvent {
  factory CME_Error(String error) = _$CME_Error;

  String get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CME_ErrorCopyWith<CME_Error> get copyWith =>
      throw _privateConstructorUsedError;
}
