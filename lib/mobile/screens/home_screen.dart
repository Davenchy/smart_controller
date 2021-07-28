import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_controller/core/utils/shared.dart';
import 'package:smart_controller/core/widgets/text.dart';
import 'package:smart_controller/mobile/controllers/mobile_controller.dart';
import 'package:smart_controller/mobile/entities/server_entity.dart';
import 'package:smart_controller/mobile/screens/pad_screen.dart';
import 'package:smart_controller/mobile/widgets/add_menu_modal.dart';
import 'package:smart_controller/mobile/widgets/confirm_modal.dart';
import 'package:smart_controller/mobile/widgets/define_server_modal.dart';
import 'package:smart_controller/mobile/widgets/help_modal.dart';
import 'package:smart_controller/mobile/widgets/settings_modal.dart';
import 'package:smart_controller/mobile/widgets/share_server_modal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Smart Controller'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => openModal(context, HelpModal()),
            icon: Icon(Icons.help_outline_rounded),
          ),
          IconButton(
            onPressed: () => openModal(context, SettingsModal()),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openModal(
          context,
          AddMenuModal(),
        ),
        child: Icon(Icons.add),
      ),
      body: Consumer(
        builder: (context, watch, _) {
          final controller = watch(mobileControllerProvider);
          if (controller.isBusy)
            return Center(
              child: QText(
                controller.bustMessage,
                size: 20,
                weight: FontWeight.bold,
              ),
            );
          else
            return _buildBody(
              context,
              controller.entities,
              controller.serversState,
            );
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    List<ServerEntity> entities,
    Map<int, ServerState> serversState,
  ) {
    if (entities.isEmpty)
      return Center(
        child: QText(
          'No Servers',
          size: 20,
          weight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      );

    return RefreshIndicator(
      onRefresh: () => context.read(mobileControllerProvider).refreshServers(),
      child: ListView.separated(
        itemBuilder: (_, index) => _buildDismissibleItem(
          context,
          entities[index],
          serversState[entities[index].id!] ?? ServerState.unknown,
        ),
        separatorBuilder: (_, __) => Divider(),
        itemCount: entities.length,
      ),
    );
  }

  Widget _buildDismissibleItem(
    BuildContext context,
    ServerEntity entity,
    ServerState serverState,
  ) {
    return Dismissible(
      key: ValueKey(entity.id!),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 14.0),
        child: Icon(Icons.delete_rounded, color: Colors.white),
      ),
      confirmDismiss: (_) => openModal<bool>(context, ConfirmModal()),
      onDismissed: (_) =>
          context.read(mobileControllerProvider).removeServer(entity),
      child: _buildItem(context, entity, serverState),
    );
  }

  Widget _buildItem(
    BuildContext context,
    ServerEntity entity,
    ServerState serverState,
  ) {
    return ListTile(
      title: QText(
        entity.name,
        color: serverState == ServerState.unknown
            ? Colors.orange
            : serverState == ServerState.offline
                ? Colors.red
                : Colors.green,
      ),
      subtitle: Text('${entity.ip}:${entity.port}'),
      trailing: IconButton(
        onPressed: () => openModal(context, ShareServerModal(entity)),
        icon: Icon(
          Icons.share_rounded,
          color: Colors.blue,
        ),
      ),
      onTap: serverState == ServerState.online
          ? () => _connectServer(context, entity)
          : null,
      onLongPress: () => openModal(
        context,
        DefineServerModal(entity: entity),
      ),
    );
  }

  Future<void> _connectServer(
    BuildContext context,
    ServerEntity server,
  ) async {
    await SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    );

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PadScreen(server),
      ),
    );

    await SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }
}
