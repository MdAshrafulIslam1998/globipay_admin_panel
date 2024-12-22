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
      ..registerFactory((c) => ProfileController(c.resolve<AppRepository>()))
      ..registerFactory(
          (c) => AddTemplatesController(c.resolve<AppRepository>()))
      ..registerFactory(
          (c) => MessageTemplatesController(c.resolve<AppRepository>()))
      ..registerFactory((c) => AddMiscController(c.resolve<AppRepository>()))
      ..registerFactory((c) => MiscellaneousController(
          c.resolve<AppRepository>(), c.resolve<TokenRepository>()))
      ..registerFactory(
          (c) => AddNotificationController(c.resolve<AppRepository>()))
      ..registerFactory((c) => CallControllerWidgetController())
      ..registerFactory((c) => VideoCallController())
      ..registerFactory((c) => ChatController(
          c.resolve<TokenRepository>(), c.resolve<AppRepository>()))
      ..registerFactory((c) => ChatMessageController(
          c.resolve<AppRepository>(), c.resolve<TokenRepository>()))
      ..registerFactory((c) => LoginController(
          c.resolve<AppRepository>(), c.resolve<TokenRepository>()))
      ..registerFactory((c) => DashboardController(c.resolve<AppRepository>()))
      ..registerFactory((c) => BasePanelController())
      ..registerFactory((c) => ActiveUsersController())
      ..registerFactory(
          (c) => StaffSectionController(c.resolve<AppRepository>()))
      ..registerFactory((c) => EditLevelController())
      ..registerFactory((c) => AddLevelController(c.resolve<AppRepository>()))
      ..registerFactory((c) => AboutUsController())
      ..registerFactory(
          (c) => PromotionalBannerController(c.resolve<AppRepository>()))
      ..registerFactory((c) => CreateCategoryController(
          c.resolve<AppRepository>(), c.resolve<TokenRepository>()))
      ..registerFactory((c) => TransHistoryController(
          c.resolve<AppRepository>(), c.resolve<TokenRepository>()))
      ..registerFactory((c) => UserAmountController(
          c.resolve<AppRepository>(), c.resolve<TokenRepository>()))
      ..registerFactory((c) => UserLevelsController(
          c.resolve<AppRepository>(), c.resolve<TokenRepository>()))
      ..registerFactory((c) => BlockedUsersController(
          c.resolve<AppRepository>(), c.resolve<TokenRepository>()))
      ..registerFactory((c) => PendingUsersController(
          c.resolve<AppRepository>(), c.resolve<TokenRepository>()))
      ..registerFactory((c) => ActiveUsersNewController(
          c.resolve<AppRepository>(), c.resolve<TokenRepository>()))
      ..registerFactory(
          (c) => NotificationsController(c.resolve<AppRepository>()))
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
