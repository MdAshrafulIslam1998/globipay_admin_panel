import 'package:flutter/cupertino.dart';
import 'package:globipay_admin_panel/modules/404_not_found/controller/not_found_controller.dart';
import 'package:globipay_admin_panel/modules/dashboard/controller/dashboard_controller.dart';
import 'package:globipay_admin_panel/modules/settings/controller/settings_controller.dart';
import 'package:globipay_admin_panel/modules/splash/controller/splash_controller.dart';
import 'package:globipay_admin_panel/modules/test_controller.dart';
import 'package:globipay_admin_panel/modules/transaction_history/controller/transaction_history_controller.dart';
import 'package:kiwi/kiwi.dart';
import '../core/di/injector.dart';

/**
 * Created by Abdullah on 10/10/24.
 */

part 'app_injector.g.dart';
abstract class AppInjector extends Injector {

  static configure() {
    Injector.container = KiwiContainer();
    Injector.resolve = Injector.container!.resolve;
    _$AppInjector()._components();
  }

  void _components(){
    _controllerComponents();
    _repositoryComponents();
  }


  @Register.factory(TestController)
  @Register.factory(TransactionHistoryController)
  @Register.factory(NotFoundController)
  @Register.factory(DashboardController)
  @Register.factory(SettingsController)
  @Register.factory(SplashController)
  void _controllerComponents();


  void _repositoryComponents();
}