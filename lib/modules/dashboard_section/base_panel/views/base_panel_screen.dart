import 'package:flutter/cupertino.dart';
import 'base_panel_screen_builder.dart';

class BasePanelScreen extends StatelessWidget {
  final Widget child;

  const BasePanelScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePanelScreenBuilder(child: child);
  }
}
