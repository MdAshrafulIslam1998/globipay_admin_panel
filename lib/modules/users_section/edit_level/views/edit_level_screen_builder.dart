import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class EditLevelScreenBuilder extends StatelessWidget {
    const EditLevelScreenBuilder({super.key});

    @override
    Widget build(BuildContext context) {
        // Add your screen builder logic here
        return Scaffold(
            appBar: AppBar(title: const Text('EditLevel')),
            body: const Center(child: Text('This is EditLevel Page. Build the UI here')),
        );
    }
}
