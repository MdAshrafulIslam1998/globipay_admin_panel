// 5. transaction_history_screen.dart
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/modules/amount_section/trans_history/views/trans_history_screen_builder.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TransactionHistoryScreenBuilder();
  }
}