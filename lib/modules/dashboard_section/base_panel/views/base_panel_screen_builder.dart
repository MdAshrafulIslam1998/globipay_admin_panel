import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/widgets/app_print.dart';
import 'package:globipay_admin_panel/core/widgets/header.dart';
import 'package:globipay_admin_panel/core/widgets/sidemenu/sidebar.dart';
import 'package:globipay_admin_panel/data/services/message_listener.dart';
import 'package:globipay_admin_panel/entity/response/message/message.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';
import 'package:globipay_admin_panel/utils/views/chat_notifications_snack_bar.dart';
import 'package:go_router/go_router.dart';


class BasePanelScreenBuilder extends StatelessWidget {
    final Widget child;
  const BasePanelScreenBuilder({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext cx) {
    String? currentRouteName = GoRouterState.of(cx).fullPath ?? "";

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      MessagesListener().listenForMessages().listen((value) {
        if (currentPathNotInRequirements(currentRouteName)){
          showChatSnackBar(cx, message: value);
        }
      });
    });
    appPrint("::::::::::::::::::::::::::base panel build (${currentRouteName})::::::::::::::::::");
    return Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            child: Column(
              children: [
                Header(),
                Expanded(child: child)
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showChatSnackBar(BuildContext context, {required Message message}) {
    {
      ChatNotificationManager().show(
        context,
        userName: "New Message",
        message: message.message ?? "",
        imageUrl: message.media_url ?? "",
        timestamp: DateTime.now(),
      );
    }
  }

  bool currentPathNotInRequirements(String currentPath) {
    var requirements = [
      RoutePath.start,
      RoutePath.login,
      RoutePath.chat,
      ];
    return !requirements.contains(currentPath);
  }
}
