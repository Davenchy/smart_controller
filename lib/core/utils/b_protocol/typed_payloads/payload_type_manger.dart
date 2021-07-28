import 'package:smart_controller/core/utils/b_protocol/typed_payloads/action_constants.dart';
import 'package:smart_controller/core/utils/b_protocol/typed_payloads/payload_types.dart';

typedef PayloadTypeBuilder<T extends PayloadType> = T Function(
    List<int> payload);

abstract class PayloadType {
  const PayloadType();
  List<int> encode();
}

class PayloadTypeManager {
  static final Map<int, PayloadTypeBuilder> _builders = {
    Actions.OK_ACTION: OKPayloadType.builder,
    Actions.KEEP_ALIVE_ACTION: KeepAlivePayloadType.builder,
    Actions.CONNECT_ACTION: ConnectPayloadType.builder,
    Actions.DISCONNECT_ACTION: DisconnectPayloadType.builder,
    Actions.ACTIVATE_ACTION: ActivatePayloadType.builder,
    Actions.DEACTIVATE_ACTION: DeactivatePayloadType.builder,
    Actions.WHO_ARE_YOU_ACTION: WhoAreYouPayloadType.builder,
    Actions.COMMAND_ACTION: CommandPayloadType.builder,
  };
  static final Map<Type, int> _actions = {
    OKPayloadType: Actions.OK_ACTION,
    KeepAlivePayloadType: Actions.KEEP_ALIVE_ACTION,
    ConnectPayloadType: Actions.CONNECT_ACTION,
    DisconnectPayloadType: Actions.DISCONNECT_ACTION,
    ActivatePayloadType: Actions.ACTIVATE_ACTION,
    DeactivatePayloadType: Actions.DEACTIVATE_ACTION,
    WhoAreYouPayloadType: Actions.WHO_ARE_YOU_ACTION,
    CommandPayloadType: Actions.COMMAND_ACTION,
  };

  static setBuilder<T extends PayloadType>(
    int action,
    PayloadTypeBuilder<T> builder,
  ) =>
      _builders[action] = builder;

  static PayloadTypeBuilder<T> getBuilder<T extends PayloadType>(int action) {
    final PayloadTypeBuilder? builder = _builders[action];
    if (builder == null)
      throw PayloadTypeManagerException(
        'Undefined_Action_Code',
        'no defined builder for action code: $action',
      );
    return builder as PayloadTypeBuilder<T>;
  }

  static T buildPayloadType<T extends PayloadType>(
    int action,
    List<int> payload,
  ) {
    final PayloadTypeBuilder<T> builder = getBuilder<T>(action);
    return builder.call(payload);
  }

  static void setActionToPayloadType<T extends PayloadType>(int action) {
    _actions[T] = action;
  }

  static int getActionByPayloadType(PayloadType payloadType) {
    for (MapEntry entry in _actions.entries) {
      if (entry.key == payloadType.runtimeType) return entry.value;
    }
    throw PayloadTypeManagerException(
      'Undefined_Payload_Type',
      'no action code for payload type ${payloadType.runtimeType}',
    );
  }
}

class PayloadTypeManagerException implements Exception {
  const PayloadTypeManagerException(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() =>
      'PayloadTypeManagerException(code: $code, message: $message)';
}
