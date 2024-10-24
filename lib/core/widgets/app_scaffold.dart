import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/widgets/sidebar/sidebar.dart';

class AppScaffold extends StatelessWidget {
  final String currentRoute;
  final Widget child;

  const AppScaffold({
    Key? key,
    required this.currentRoute,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(currentRoute: currentRoute),
          Expanded(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}