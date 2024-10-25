import 'package:flutter/cupertino.dart';
import 'transactions_screen_builder.dart';

class TransactionsScreen extends StatelessWidget {
    const TransactionsScreen({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return TransactionsScreenBuilder();
    }
}
