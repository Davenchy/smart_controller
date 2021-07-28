part of 'connection_manager.dart';

@freezed
class ConnectionManagerEvent {
  factory ConnectionManagerEvent.packet(
    BPeer peer,
    Packet packet,
  ) = CME_Packet;
  factory ConnectionManagerEvent.newPeer(BPeer peer) = CME_NewPeer;
  factory ConnectionManagerEvent.error(String error) = CME_Error;
}
