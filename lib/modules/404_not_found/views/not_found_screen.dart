import 'package:flutter/cupertino.dart';
import 'package:globipay_admin_panel/modules/404_not_found/views/not_found_screen_builder.dart';
import 'package:globipay_admin_panel/modules/transaction_history/views/transaction_history_screen_builder.dart';
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NotFoundScreenBuilder();
  }
}
