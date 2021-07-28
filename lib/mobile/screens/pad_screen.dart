import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_controller/core/widgets/text.dart';
import 'package:smart_controller/mobile/controllers/pad_controller.dart';
import 'package:smart_controller/mobile/entities/server_entity.dart';
import 'package:smart_controller/mobile/widgets/pad_parts/controller_button.dart';
import 'package:smart_controller/mobile/widgets/pad_parts/touch_pad.dart';
import 'package:virtual_controller/virtual_controller.dart';

class PadScreen extends StatefulWidget {
  PadScreen(this.serverEntity, {Key? key}) : super(key: key);

  final ServerEntity serverEntity;

  @override
  _PadScreenState createState() => _PadScreenState();
}

class _PadScreenState extends State<PadScreen> {
  late final padControllerProvider;

  @override
  void initState() {
    super.initState();
    padControllerProvider = ChangeNotifierProvider.autoDispose<PadController>(
      (ref) => PadController(widget.serverEntity),
      name: 'Pad Controller',
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProviderListener<PadController>(
      provider: padControllerProvider,
      onChange: (context, controller) {
        if (controller.shouldKill) Navigator.pop(context);
      },
      child: Consumer(
        builder: (context, watch, _) {
          try {
            final controller = watch(padControllerProvider);

            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => controller.disconnect(),
                child: Icon(Icons.exit_to_app_rounded),
              ),
              body: SafeArea(
                child: _buildBody(context, controller),
              ),
            );
          } catch (err) {
            print(err);
            rethrow;
          }
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, PadController controller) {
    if (!controller.isPaused)
      return _buildPadState(context, controller);
    else
      return Center(
        child: QText(
          controller.pausedMessage,
          size: 20,
          weight: FontWeight.bold,
        ),
      );
  }

  // Future<void> _showErrorAlert(BuildContext context, String message) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) => Dialog(
  //       child: Padding(
  //         padding: const EdgeInsets.all(20.0),
  //         child: QText(
  //           message,
  //           align: TextAlign.center,
  //           size: 20,
  //           weight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPadState(BuildContext context, PadController controller) {
    return Container(
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TouchPad(
            diameter: 200,
            stickDiameter: 60,
            onPositionChanged: (position) {
              controller.sendABSCommand(AbsoluteCode.ABS_X, position.dx);
              controller.sendABSCommand(AbsoluteCode.ABS_Y, position.dy);
            },
          ),
          ControllerButton(
            child: Icon(Icons.menu, color: Colors.white),
            onStateChanged: (state) => controller.sendBTNCommand(
              BTNCode.BTN_SELECT,
              state,
            ),
          ),
          ControllerButton(
            child: Icon(Icons.play_arrow, color: Colors.white),
            onStateChanged: (state) => controller.sendBTNCommand(
              BTNCode.BTN_START,
              state,
            ),
          ),
          Row(
            children: [
              ControllerButton.text(
                text: 'X',
                color: Colors.blue,
                onStateChanged: (state) => controller.sendBTNCommand(
                  BTNCode.BTN_X,
                  state,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ControllerButton.text(
                    text: 'Y',
                    color: Colors.yellow,
                    onStateChanged: (state) =>
                        controller.sendBTNCommand(BTNCode.BTN_Y, state),
                  ),
                  SizedBox(height: 60),
                  ControllerButton.text(
                    text: 'A',
                    color: Colors.green,
                    onStateChanged: (state) =>
                        controller.sendBTNCommand(BTNCode.BTN_A, state),
                  ),
                ],
              ),
              ControllerButton.text(
                text: 'B',
                color: Colors.red,
                onStateChanged: (state) => controller.sendBTNCommand(
                  BTNCode.BTN_B,
                  state,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
