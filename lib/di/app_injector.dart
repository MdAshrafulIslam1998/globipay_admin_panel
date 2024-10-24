import 'package:globipay_admin_panel/modules/dashbaord/controller/dashbaord_controller.dart';
import 'package:globipay_admin_panel/modules/test_controller.dart';
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
  @Register.factory(DashboardController)
  void _controllerComponents();


  void _repositoryComponents();
}