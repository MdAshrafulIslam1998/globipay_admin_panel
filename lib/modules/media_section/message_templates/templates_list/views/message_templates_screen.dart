import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'message_templates_screen_builder.dart';

class MessageTemplatesScreen extends StatelessWidget {
  const MessageTemplatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MessageTemplatesScreenBuilder();
  }
}
