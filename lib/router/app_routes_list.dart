import 'package:get/get.dart';
import 'package:globipay_admin_panel/data/models/call_model.dart';
import 'package:globipay_admin_panel/modules/amount_section/trans_history/views/trans_history_screen.dart';
import 'package:globipay_admin_panel/modules/authetication/login/views/login_screen.dart';
import 'package:globipay_admin_panel/modules/chat/call/audio_call/views/audio_call_screen.dart';
import 'package:globipay_admin_panel/modules/chat/call/call_waiting/views/call_waiting_screen.dart';
import 'package:globipay_admin_panel/modules/chat/chat_message_list/views/chat_message_list_screen.dart';
import 'package:globipay_admin_panel/modules/chat/chat_screen/views/chat_screen_screen.dart';
import 'package:globipay_admin_panel/modules/dashboard_section/base_panel/views/base_panel_screen.dart';
import 'package:globipay_admin_panel/modules/dashboard_section/dashboard/views/dashboard_screen.dart';
import 'package:globipay_admin_panel/modules/media_section/promo_banner/views/add_promotional_banner_view.dart';
import 'package:globipay_admin_panel/modules/splash/splash_screen.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users/views/active_users_screen.dart';
import 'package:globipay_admin_panel/modules/amount_section/edit_coin/views/edit_coin_screen.dart';
import 'package:globipay_admin_panel/modules/users_section/pending_profile/views/pending_profile_screen.dart';
import 'package:globipay_admin_panel/modules/media_section/notification_setter/views/notification_setter_screen.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users_new/views/active_users_new_screen.dart';
import 'package:globipay_admin_panel/modules/users_section/pending_users/views/pending_users_screen.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/views/blocked_users_screen.dart';
import 'package:globipay_admin_panel/modules/users_section/user_levels/views/user_levels_screen.dart';
import 'package:globipay_admin_panel/modules/amount_section/user_amount/views/user_amount_screen.dart';
import 'package:globipay_admin_panel/modules/amount_section/create_category/views/create_category_screen.dart';
import 'package:globipay_admin_panel/modules/media_section/promo_banner/views/promo_banner_screen.dart';
import 'package:globipay_admin_panel/modules/media_section/automated_reply/views/automated_reply_screen.dart';
import 'package:globipay_admin_panel/modules/media_section/about_us/views/about_us_screen.dart';
import 'package:go_router/go_router.dart';
import '../modules/chat/call/video_call/video_call_screen.dart';
import 'route_path.dart';

abstract class AppRoutesList {
  static List<RouteBase> allRoutes() {
    return [
      GoRoute(
        path: RoutePath.start,
        name: RoutePath.start,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePath.login,
        name: RoutePath.login,
        builder: (context, state) => LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BasePanelScreen(child: child);
        },
        routes: [
          GoRoute(
            path: RoutePath.dashboard,
            name: RoutePath.dashboard,
            builder: (context, state) => DashboardScreen(),
          ),
          GoRoute(
            path: RoutePath.activeUsers,
            name: RoutePath.activeUsers,
            builder: (context, state) => ActiveUsersScreen(),
          ),
          GoRoute(
            path: RoutePath.editCoin,
            name: RoutePath.editCoin,
            builder: (context, state) => EditCoinScreen(),
          ),
          GoRoute(
            path: RoutePath.pendingProfile,
            name: RoutePath.pendingProfile,
            builder: (context, state) => PendingProfileScreen(),
          ),
          GoRoute(
            path: RoutePath.notificationSetter,
            name: RoutePath.notificationSetter,
            builder: (context, state) => NotificationSetterScreen(),
          ),
          GoRoute(
            path: RoutePath.activeUsersNew,
            name: RoutePath.activeUsersNew,
            builder: (context, state) => ActiveUsersNewScreen(),
          ),
          GoRoute(
            path: RoutePath.pendingUsers,
            name: RoutePath.pendingUsers,
            builder: (context, state) => PendingUsersScreen(),
          ),
          GoRoute(
            path: RoutePath.blockedUsers,
            name: RoutePath.blockedUsers,
            builder: (context, state) => BlockedUsersScreen(),
          ),
          GoRoute(
            path: RoutePath.userLevels,
            name: RoutePath.userLevels,
            builder: (context, state) => UserLevelsScreen(),
          ),
          GoRoute(
            path: RoutePath.userAmount,
            name: RoutePath.userAmount,
            builder: (context, state) => UserAmountScreen(),
          ),
          GoRoute(
            path: RoutePath.transHistory,
            name: RoutePath.transHistory,
            builder: (context, state) => TransactionHistoryScreen(),
          ),
          GoRoute(
            path: RoutePath.createCategory,
            name: RoutePath.createCategory,
            builder: (context, state) => CreateCategoryScreen(),
          ),
          GoRoute(
            path: RoutePath.promoBanner,
            name: RoutePath.promoBanner,
            builder: (context, state) => PromoBannerScreen(),
          ),

          GoRoute(
            path: RoutePath.addPromoBanner,
            name: RoutePath.addPromoBanner,
            builder: (context, state) => AddPromotionalBannerView(),
          ),


          GoRoute(
            path: RoutePath.automatedReply,
            name: RoutePath.automatedReply,
            builder: (context, state) => AutomatedReplyScreen(),
          ),
          GoRoute(
            path: RoutePath.aboutUs,
            name: RoutePath.aboutUs,
            builder: (context, state) => AboutUsScreen(),
          ),

          GoRoute(
            path: RoutePath.chatMessageList,
            name: RoutePath.chatMessageList,
            builder: (context, state) => const ChatMessageListScreen(),
          ),

          GoRoute(
            path: RoutePath.chat,
            name: RoutePath.chat,
            builder: (context, state) => ChatScreenScreen(),
          ),

          GoRoute(
            path: RoutePath.audioCall,
            name: RoutePath.audioCall,
            builder: (context, state) => const AudioCallScreen(),
          ),

          GoRoute(
            path: RoutePath.videoCall,
            name: RoutePath.videoCall,
            builder: (context, state) => VideoCallScreen(data: state.extra),
          ),

          GoRoute(
            path: RoutePath.callPickUp,
            name: RoutePath.callPickUp,
            builder: (context, state) => CallWaitingScreen(data: state.extra as CallModel),
          ),



        ],
      ),
    ];
  }
}
