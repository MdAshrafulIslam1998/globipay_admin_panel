import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text.dart';
import 'package:globipay_admin_panel/core/widgets/text_filed/input_field.dart';

/**
 * Created by Abdullah on 13/12/24.
 */

class ChatCloseDialog extends StatelessWidget {

  const ChatCloseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppText("Close Chat",),
                InputField(
                  hintText: "Reason",
                  maxLines: 5,
                ),
      
                InputField(
                  hintText: "Reason",
                  maxLines: 5,
                ),
      
              ],
            ),
          )
      ),
    );
  }
}
