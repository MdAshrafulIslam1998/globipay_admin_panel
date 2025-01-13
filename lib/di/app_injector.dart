import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/core/data/local/repository_impl/token_repository_impl.dart';
import 'package:globipay_admin_panel/core/utils/storage/app_secure_storage.dart';
import 'package:globipay_admin_panel/core/widgets/sidemenu/side_menu_controller.dart';
import 'package:globipay_admin_panel/data/remote/app_remote_data_source.dart';
import 'package:globipay_admin_panel/data/remote/app_remote_data_source_impl.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/data/repository_impl/app_repository_impl.dart';
import 'package:globipay_admin_panel/modules/amount_section/trans_history/controller/trans_history_controller.dart';
import 'package:globipay_admin_panel/modules/authetication/login/controller/login_controller.dart';
import 'package:globipay_admin_panel/modules/chat/call/video_call/controller/video_cal_controller.dart';
import 'package:globipay_admin_panel/modules/chat/call/video_call/widgets/controller/call_controller_widget_controller.dart';
import 'package:globipay_admin_panel/modules/chat/chat_message_list/controller/chat_message_controller.dart';
import 'package:globipay_admin_panel/modules/chat/chat_screen/controller/chat_controller.dart';
import 'package:globipay_admin_panel/modules/chat/controller/chat_shared_controller.dart';
import 'package:globipay_admin_panel/modules/media_section/message_templates/add_templates/controller/add_templates_controller.dart';
import 'package:globipay_admin_panel/modules/media_section/message_templates/templates_list/controller/message_templates_controller.dart';
import 'package:globipay_admin_panel/modules/media_section/miscellaneous/add_misc/controller/add_misc_controller.dart';
import 'package:globipay_admin_panel/modules/media_section/miscellaneous/controller/miscellaneous_controller.dart';
import 'package:globipay_admin_panel/modules/media_section/notification_setter/add_notifications/controller/add_notification_controller.dart';
import 'package:globipay_admin_panel/modules/media_section/promo_banner/controller/promotional_banner_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users/controller/active_users_controller.dart';
import 'package:globipay_admin_panel/modules/dashboard_section/base_panel/controller/base_panel_controller.dart';
import 'package:globipay_admin_panel/modules/dashboard_section/dashboard/controller/dashboard_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/profile_controller.dart';
import 'package:kiwi/kiwi.dart';
import 'package:globipay_admin_panel/modules/staff_section/controller/staff_section_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/edit_level/controller/edit_level_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/add_level/controller/add_level_controller.dart';
import 'package:globipay_admin_panel/modules/media_section/about_us/controller/about_us_controller.dart';
import 'package:globipay_admin_panel/modules/amount_section/create_category/controller/create_category_controller.dart';
import 'package:globipay_admin_panel/modules/amount_section/user_amount/controller/user_amount_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/user_levels/controller/user_levels_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/controller/blocked_users_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/pending_users/controller/pending_users_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users_new/controller/active_users_new_controller.dart';
import 'package:globipay_admin_panel/modules/media_section/notification_setter/notification_list/controller/notification_list_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/pending_profile/controller/pending_profile_controller.dart';
import 'package:globipay_admin_panel/modules/amount_section/edit_coin/controller/edit_coin_controller.dart';
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

  @Register.factory(SideMenuController)
  @Register.factory(ProfileController)
  @Register.factory(AddTemplatesController)
  @Register.factory(MessageTemplatesController)
  @Register.factory(AddMiscController)
  @Register.factory(MiscellaneousController)
  @Register.factory(AddNotificationController)
  @Register.factory(CallControllerWidgetController)
  @Register.factory(VideoCallController)
  @Register.factory(ChatController)
  @Register.factory(ChatMessageController)
  @Register.factory(LoginController)
  @Register.factory(DashboardController)
  @Register.factory(BasePanelController)
  @Register.factory(ActiveUsersController)
  @Register.factory(StaffSectionController)
  @Register.factory(EditLevelController)
  @Register.factory(AddLevelController)
  @Register.factory(AboutUsController)
  @Register.factory(PromotionalBannerController)
  @Register.factory(CreateCategoryController)
  @Register.factory(TransHistoryController)
  @Register.factory(UserAmountController)
  @Register.factory(UserLevelsController)
  @Register.factory(BlockedUsersController)
  @Register.factory(PendingUsersController)
  @Register.factory(ActiveUsersNewController)
  @Register.factory(NotificationsController)
  @Register.factory(PendingProfileController)
  @Register.factory(EditCoinController)

  //Singleton
  @Register.singleton(ChatSharedController)
  @Register.singleton(AppSecureStorage)
  void _controllerComponents();


  @Register.singleton(AppRepository, from: AppRepositoryImpl)
  @Register.singleton(AppRemoteDataSource, from: AppRemoteDataSourceImpl)
  @Register.singleton(TokenRepository, from: TokenRepositoryImpl)
  void _repositoryComponents();
}