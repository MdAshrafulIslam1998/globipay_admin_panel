import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/data/services/message_listener.dart';
import 'package:globipay_admin_panel/data/services/supabase_service.dart';

import 'app.dart';
import 'core/di/di_setup.dart';
import 'flavors/app_properties.dart';
import 'flavors/flavor_config.dart';

/**
 * Created by Abdullah on 10/10/24.
 */

Future<void> main() async {
  AppProperties.appFlavor = Flavor.DEV;

  FlavorConfig.instantiate(
      flavor: Flavor.DEV,
      name: AppProperties.title,
      url: "https://www.projectzerotwofour.cloudns.ch"
  );

  setupDependencies();

  MessagesListener().initialize(SupabaseService().client);

  runApp(const App());
}