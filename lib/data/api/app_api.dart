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




}