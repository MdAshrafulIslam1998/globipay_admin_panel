import 'package:flutter/cupertino.dart';
import 'package:globipay_admin_panel/modules/chat/call/video_call/video_call_screen_builder.dart';

class VideoCallScreen extends StatelessWidget {

  final dynamic data;
  const VideoCallScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return VideoCallScreenBuilder(data: data,);
  }
}
