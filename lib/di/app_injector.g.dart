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
      ..registerFactory((c) => AddMiscController())
      ..registerFactory((c) => MiscellaneousController(
          c.resolve<AppRepository>(), c.resolve<TokenRepository>()))
      ..registerFactory((c) => AddNotificationController())
      ..registerFactory((c) => CallControllerWidgetController())
      ..registerFactory((c) => VideoCallController())
      ..registerFactory((c) => ChatController(
          c.resolve<TokenRepository>(), c.resolve<AppRepository>()))
      ..registerFactory((c) => ChatMessageController(
          c.resolve<AppRepository>(), c.resolve<TokenRepository>()))
      ..registerFactory((c) => LoginController(
          c.resolve<AppRepository>(), c.resolve<TokenRepository>()))
      ..registerFactory((c) => DashboardController())
      ..registerFactory((c) => BasePanelController())
      ..registerFactory((c) => ActiveUsersController())
      ..registerFactory((c) => EditLevelController())
      ..registerFactory((c) => AddLevelController())
      ..registerFactory((c) => AboutUsController())
      ..registerFactory((c) => AutomatedReplyController())
      ..registerFactory(
          (c) => PromotionalBannerController(c.resolve<AppRepository>()))
      ..registerFactory((c) => CreateCategoryController())
      ..registerFactory((c) => TransactionHistoryController())
      ..registerFactory((c) => UserAmountController())
      ..registerFactory((c) => UserLevelsController(
          c.resolve<AppRepository>(), c.resolve<TokenRepository>()))
      ..registerFactory((c) => BlockedUsersController(
          c.resolve<AppRepository>(), c.resolve<TokenRepository>()))
      ..registerFactory((c) => PendingUsersController(
          c.resolve<AppRepository>(), c.resolve<TokenRepository>()))
      ..registerFactory((c) => ActiveUsersNewController(
          c.resolve<AppRepository>(), c.resolve<TokenRepository>()))
      ..registerFactory((c) => NotificationsController())
      ..registerFactory((c) => PendingProfileController())
      ..registerFactory((c) => EditCoinController())
      ..registerSingleton((c) => ChatSharedController())
      ..registerSingleton((c) => AppSecureStorage());
  }

  @override
  void _repositoryComponents() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton<AppRepository>(
          (c) => AppRepositoryImpl(c.resolve<AppRemoteDataSource>()))
      ..registerSingleton<AppRemoteDataSource>((c) => AppRemoteDataSourceImpl())
      ..registerSingleton<TokenRepository>(
          (c) => TokenRepositoryImpl(c.resolve<AppSecureStorage>()));
  }
}
