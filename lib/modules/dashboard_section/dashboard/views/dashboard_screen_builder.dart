import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardScreenBuilder extends StatelessWidget {
    const DashboardScreenBuilder({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        // Add your screen builder logic here
        return Scaffold(
            appBar: AppBar(title: Text('Dashboard')),
            body: Center(child: Text('This is Dashboard Page')),
        );
    }
}
