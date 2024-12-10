import 'package:flutter/cupertino.dart';
import 'package:globipay_admin_panel/data/models/call_model.dart';
import 'package:globipay_admin_panel/modules/chat/call/call_waiting/views/call_waiting_screen_builder.dart';

/**
 * Created by Abdullah on 27/10/24.
 */


class CallWaitingScreen extends StatelessWidget {
  final CallModel data;
  const CallWaitingScreen({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return CallWaitingScreenBuilder(data: data);
  }
}
