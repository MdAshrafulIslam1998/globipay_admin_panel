import 'package:flutter/cupertino.dart';
import 'package:globipay_admin_panel/modules/chat/call/audio_call/views/audio_call_screen_builder.dart';

class AudioCallScreen extends StatelessWidget {
  final dynamic data;

  const AudioCallScreen({super.key, this.data});
  @override
  Widget build(BuildContext context) {
    return AudioCallScreenBuilder(data: data);
  }
}
