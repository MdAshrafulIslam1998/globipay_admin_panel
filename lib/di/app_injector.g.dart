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
      ..registerFactory((c) => ActiveUsersController())
      ..registerFactory((c) => PromoBannerController())
      ..registerFactory((c) => CreateCategoryController())
      ..registerFactory((c) => TransactionHistoryController())
      ..registerFactory((c) => UserAmountController())
      ..registerFactory((c) => UserLevelsController())
      ..registerFactory((c) => BlockedUsersController())
      ..registerFactory((c) => PendingUsersController())
      ..registerFactory((c) => ActiveUsersNewController())
      ..registerFactory((c) => NotificationSetterController())
      ..registerFactory((c) => PendingProfileController())
      ..registerFactory((c) => EditCoinController());
  }

  @override
  void _repositoryComponents() {}
}
