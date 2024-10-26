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
      ..registerFactory((c) => DashboardController())
      ..registerFactory((c) => BasePanelController())
      ..registerFactory((c) => SettingsController())
      ..registerFactory((c) => PendingTransactionsController())
      ..registerFactory((c) => TransactionsController())
      ..registerFactory((c) => InactiveUsersController())
      ..registerFactory((c) => ActiveUsersController());
  }

  @override
  void _repositoryComponents() {}
}
