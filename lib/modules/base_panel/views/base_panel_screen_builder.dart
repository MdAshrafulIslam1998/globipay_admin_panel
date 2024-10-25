import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/widgets/header.dart';
import 'package:globipay_admin_panel/core/widgets/sidemenu/sidebar.dart';


class BasePanelScreenBuilder extends StatelessWidget {
    final Widget child;
  const BasePanelScreenBuilder({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("::::::::::::::::::::::::::base panel build::::::::::::::::::");
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
}
