import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class InactiveUsersScreenBuilder extends StatelessWidget {
    const InactiveUsersScreenBuilder({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        // Add your screen builder logic here
        return Scaffold(
            appBar: AppBar(title: Text('InactiveUsers')),
            body: Center(child: Text('Build the UI here')),
        );
    }
}
