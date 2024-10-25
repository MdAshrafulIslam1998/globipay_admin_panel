import 'package:flutter/cupertino.dart';
import 'pending_transactions_screen_builder.dart';

class PendingTransactionsScreen extends StatelessWidget {
    const PendingTransactionsScreen({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return PendingTransactionsScreenBuilder();
    }
}
