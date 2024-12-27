/**
 * Created by Abdullah on 15/12/24.
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/core/utils/inputFilter/input_filter.dart';
import 'package:globipay_admin_panel/core/widgets/text_filed/input_field.dart';
import 'package:globipay_admin_panel/core/widgets/text_filed/input_regex.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/request/chat_close/chat_close_request_entity.dart';
import 'package:globipay_admin_panel/entity/response/chat_close/chat_close_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/notification/notification_response_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_transaction_history/user_transaction_history_item_response.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/activity_log_model.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/transaction_model.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/notification_model.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:intl/intl.dart';

class ProfileController extends BaseController {

  final GlobalKey<FormState> modifyTransactionFormKey = GlobalKey<FormState>();
  final TextEditingController primaryCoinController = TextEditingController();
  final TextEditingController secondaryCoinController = TextEditingController();



  final AppRepository _repository;
  // Existing profile data
  Rx<ProfileData?> profileData = Rx<ProfileData?>(null);

  // Transactions
  RxList<UserTransactionHistoryResponseItem> transactions = RxList<UserTransactionHistoryResponseItem>();
  RxString transactionSearchQuery = RxString('');
  ScrollController transactionScrollController = ScrollController();
  RxBool isTransactionLoading = RxBool(false);

  // Activity Logs
  RxList<ActivityLogModel> activityLogs = RxList<ActivityLogModel>();
  RxString activitySearchQuery = RxString('');
  ScrollController activityScrollController = ScrollController();
  RxBool isActivityLoading = RxBool(false);

  // Notifications
  RxList<NotificationResponseItemEntity> notifications = RxList<NotificationResponseItemEntity>();
  RxString notificationSearchQuery = RxString('');
  ScrollController notificationScrollController = ScrollController();
  RxBool isNotificationLoading = RxBool(false);

  String? uid ;
  ProfileController(this._repository);
  @override
  void onInit() {
    super.onInit();
    setupScrollListeners();
  }

  void fetchInitialData(UserResponseItemEntity? user) {
    uid = user?.userId ?? '';
    // Simulate loading profile data
    profileData.value = ProfileData(
      code: user?.user_code ?? '',
        fullName: user?.name ?? '',
        email: user?.email ?? '',
        dob: DateFormat('dd/MM/yyyy').format(DateTime(2024, 1, 1)),
        gender: user?.gender ?? '',
        phone: user?.phone ?? '',
        address: user?.address ?? '',
        selfiePath:
            "https://www.shutterstock.com/image-vector/man-character-face-avatar-glasses-600nw-542759665.jpg",
        frontIdPath:
            "https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_640.png",
        backIdPath:
            "https://5.imimg.com/data5/UF/GX/GLADMIN-63025529/adhar-card-service-500x500.png"

        // ... other profile details
        );

    // Generate dummy transactions
    requestForUserSpecificTransaction(uid);

    // Generate dummy activity logs
    activityLogs.value = List.generate(
        20,
        (index) => ActivityLogModel(
              id: 'AL$index',
              timestamp: DateTime.now().subtract(Duration(hours: index)),
              type: _getRandomActivityType(index),
            ));

    // Generate dummy notifications
    requestForUserSpecificNotification(uid);
  }

  void setupScrollListeners() {
    transactionScrollController.addListener(_loadMoreTransactions);
    activityScrollController.addListener(_loadMoreActivityLogs);
    notificationScrollController.addListener(_loadMoreNotifications);
  }

  void _loadMoreTransactions() {
    if (transactionScrollController.position.pixels ==
        transactionScrollController.position.maxScrollExtent) {
      _fetchMoreTransactions();
    }
  }

  void _loadMoreActivityLogs() {
    if (activityScrollController.position.pixels ==
        activityScrollController.position.maxScrollExtent) {
      _fetchMoreActivityLogs();
    }
  }

  void _loadMoreNotifications() {
    if (notificationScrollController.position.pixels ==
        notificationScrollController.position.maxScrollExtent) {
     // _fetchMoreNotifications();
    }
  }

  void _fetchMoreTransactions() async {
    if (isTransactionLoading.value) return;

    isTransactionLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));

    // Simulate network delay
    requestForUserSpecificTransaction(uid);

    isTransactionLoading.value = false;
  }

  void _fetchMoreActivityLogs() async {
    if (isActivityLoading.value) return;

    isActivityLoading.value = true;
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Add more dummy activity logs
    activityLogs.addAll(List.generate(
        10,
        (index) => ActivityLogModel(
              id: 'AL${activityLogs.length + index}',
              timestamp: DateTime.now()
                  .subtract(Duration(hours: activityLogs.length + index)),
              type: _getRandomActivityType(index),
            )));

    isActivityLoading.value = false;
  }

  void _fetchMoreNotifications() async {
    if (isNotificationLoading.value) return;

    isNotificationLoading.value = true;
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Add more notifications
    requestForUserSpecificNotification(uid);

    isNotificationLoading.value = false;
  }

  // Helper methods for generating random data
  String _getRandomActivityType(int index) {
    final types = [
      'Login',
      'Chat Created',
      'Profile Pic Changed',
      'Password Updated',
      'Device Login'
    ];
    return types[index % types.length];
  }

  String _getRandomNotificationContent(int index) {
    final contents = [
      'Your profile is under review',
      'New message received',
      'Security update available',
      'Transaction completed',
      'Profile update successful'
    ];
    return contents[index % contents.length];
  }

  // Export methods
  void exportTransactions() {
    // Implement CSV or PDF export logic
    print('Exporting Transactions');
  }

  void exportActivityLogs() {
    // Implement CSV or PDF export logic
    print('Exporting Activity Logs');
  }

  void onApprove() {
  }

  void onPending() {
  }

  void onRemove() {
  }

  PaginationRequest paginationRequest(int page, int limit) => PaginationRequest(
        page: page,
        limit: limit,
      );

  void requestForUserSpecificTransaction(String? uid){
    final req = paginationRequest(1, 10);
    final repo = _repository.requestUserSpecificTransaction(request: req, userId : uid ?? "") ;
    callService(repo, isShowLoader: false, onSuccess: (response) {
      transactions.value.addAll(response.transactions ?? []);
    });
  }

  /*void requestForUserSpecificActivityLog(String? uid){
    final req = paginationRequest(1, 10);
    final repo = _repository.requestUserSpecificActivityLog(request: req, userId : uid ?? "") ;
    callService(repo, isShowLoader: false, onSuccess: (response) {
      activityLogs.value.addAll(response.activityLogs ?? []);
    });
  }*/

  void requestForUserSpecificNotification(String? uid){
    final req = paginationRequest(1, 10);
    final repo = _repository.requestUserSpecificNotification(request: req, userId : uid ?? "") ;
    callService(repo, isShowLoader: false, onSuccess: (response) {
      notifications.value.addAll(response.notifications ?? []);
    });
  }

  void onAddTransaction(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Modify Transactions"),
            content: Form(
              key: modifyTransactionFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Primary Coin Input Field
                  InputField(
                    controller: primaryCoinController,
                    inputFormatters: InputFilter.ONLY_NUMBER,
                    hintText: "Primary Coin",

                  ),
                  SizedBox(height: 10),
                  // Secondary Coin Input Field
                  InputField(
                    controller: secondaryCoinController,
                    maxLength: 10,
                    inputFormatters: InputFilter.ONLY_NUMBER,
                    hintText: "Secondary Coin",

                  ),
                ],
              ),
            ),
            actions: [
              // Cancel Button
              TextButton(
                onPressed: () {
                  AppRoutes.pop();
                },
                child: Text("Cancel"),
              ),
              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (modifyTransactionFormKey.currentState!.validate()) {
                    AppRoutes.pop();
                    requestToCloseChatSession();
                  }
                },
                child: Text("Submit"),
              ),
            ],
          );
        },
      );
  }
  ChatCloseRequestEntity chatCloseRequestEntity(String createdById,String chatId, String chatUID){
    return ChatCloseRequestEntity(
      primaryCoin: primaryCoinController.text.isNotEmpty ? double.tryParse(primaryCoinController.text) : 0.0,
      secondaryCoin: secondaryCoinController.text.isNotEmpty ? double.tryParse(secondaryCoinController.text) : 0.0,
      catId: int.tryParse(chatId ?? "-1"),
      uid: chatUID ?? "",
      createdBy: createdById,
    );
  }

  requestToCloseChatSession() async{
    final cId = await getLoggedInUserId();
    final req = chatCloseRequestEntity(cId, "1", uid ?? "");
    final repo = _repository.requestToCloseChat(req);
    callService(repo,onSuccess: (ChatCloseResponseEntity response){
      parseChatCloseSession(response);
    });
  }

  parseChatCloseSession(ChatCloseResponseEntity response){

  }
}

// Existing ProfileData model (you can expand this)
class ProfileData {
  final String fullName;
  final String email;
  final String dob;
  final String gender;
  final String phone;
  final String address;
  final String selfiePath;
  final String frontIdPath;
  final String backIdPath;
  final String code;

  // Add other profile fields as needed

  ProfileData({
    required this.fullName,
    required this.email,
    required this.dob,
    required this.gender,
    required this.phone,
    required this.address,
    required this.selfiePath,
    required this.frontIdPath,
    required this.backIdPath,
    required this.code,
  });
}
