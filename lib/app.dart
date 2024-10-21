import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/theme/theme.dart';
import 'package:globipay_admin_panel/router/app_router.dart';
import 'flavors/app_properties.dart';
/**
 * Created by Abdullah on 10/10/24.
 */

void main() {
  runApp(const App());
}
class App extends StatelessWidget {

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppProperties.title,
      themeMode: ThemeMode.dark,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}