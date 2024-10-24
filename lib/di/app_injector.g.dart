// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$AppInjector extends AppInjector {
  @override
  void _controllerComponents() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => TestController())
      ..registerFactory((c) => TransactionHistoryController())
      ..registerFactory((c) => NotFoundController())
      ..registerFactory((c) => DashboardController())
      ..registerFactory((c) => SettingsController())
      ..registerFactory((c) => SplashController(c.resolve<BuildContext>()));
  }

  @override
  void _repositoryComponents() {}
}
