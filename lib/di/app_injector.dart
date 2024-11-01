import 'package:globipay_admin_panel/modules/active_users/controller/active_users_controller.dart';
import 'package:globipay_admin_panel/modules/base_panel/controller/base_panel_controller.dart';
import 'package:globipay_admin_panel/modules/dashboard/controller/dashboard_controller.dart';
import 'package:globipay_admin_panel/modules/test_controller.dart';
import 'package:kiwi/kiwi.dart';
import 'package:globipay_admin_panel/modules/edit_coin/controller/edit_coin_controller.dart';
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
  @Register.factory(DashboardController)
  @Register.factory(BasePanelController)
  @Register.factory(ActiveUsersController)
  @Register.factory(EditCoinController)
  void _controllerComponents();


  void _repositoryComponents();
}