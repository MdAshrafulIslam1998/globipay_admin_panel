/**
 * Created by Abdullah on 13/10/24.
 */

abstract class AppApi {
  static const String prefix = 'api';
  static const String login = '$prefix/staffauth/login';
  static const String userVerifiedProfile = '$prefix/user/verifiedusersweb';
  static const String blockedUserPath = '$prefix/user/blockedusersweb';
  static const String pendingUserPath = '$prefix/user/pendingusersweb';
  static const String chatClose = '$prefix/transaction/add';
  static const String addSlider = '$prefix/sliders';
  static const String allSlider = '$prefix/sliders';
  static const String deleteSlide = '$prefix/sliders/delete';
  static const String fileUpload = '$prefix/upload-document';
  static const String miscs = '$prefix/meta-service';
  static const String categories = '$prefix/categories';
  static const String addMessageTemplates = '$prefix/templates/add';
  static const String messageTemplatesList = '$prefix/templates';
  static const String removeMessageTemplates = '$prefix/templates';
  static const String addCategory = '$prefix/categories/add';
  static const String deleteCategory = '$prefix/categories';
  static const String addMisc = '$prefix/meta-service/add';
  static const String removeMisc = '$prefix/meta-service';
  static const String removeLevel = '$prefix/levels';
  static const String allLevel = '$prefix/levels';
  static const String addLevel = '$prefix/levels/addLevel';
  static const String staffList = '$prefix/staffpanel/staffs';
  static const String addStaff = '$prefix/staffpanel/staffs';
  static const String USER_WISE_TRANSACTIONS =
      '$prefix/alltransactions/userwise';
  static const String CAT_WISE_TRANSACTIONS =
      '$prefix/alltransactions/categorywise';
  static const String allTransactions = '$prefix/alltransactions';
  static const String userwiseTransactions =
      '$prefix/users/userwise/transactions';
  static const String notifications = '$prefix/notifications';
  static const String searchUser = '$prefix/users/search';
  static const String createNotifications = '$prefix/notifications/send';
  static const String userSpecificTransactionHistory = '$prefix/users';
  static const String agoraToken = '$prefix/agora/generateToken';
  static const String callSend = '$prefix/send-call-notification';
  static const String userSpecificNotifications =
      '$prefix/notifications/fetch-by-target';
  static const String userStatus = '$prefix/users/changestatus';
  static const String deleteNotification = '$prefix/notifications/delete';
  static const String userAmountDetails = '$prefix/amountdetailsweb';
  static const String totalTransactions = '$prefix/transactions/totals';
  static const String recentTransaction = '$prefix/transactions/recent';
  static const String updateCategory = '$prefix/categories';
  static const String userProfileDetails = '$prefix/users/profileweb';
  static const String updateUserStatus = '$prefix/user/update_columns';
  static const String activityLogs = '$prefix/activity-logs';
}
