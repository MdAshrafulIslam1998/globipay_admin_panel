/// Created by Abdullah on 20/8/24.
library;
import 'package:get_it/get_it.dart';

import '../../di/app_injector.dart';
import 'injector.dart';

void setupDependencies() {
  AppInjector.configure();
}
