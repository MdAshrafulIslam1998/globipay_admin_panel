// 1. transaction_history_controller.dart
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/amount_section/trans_history/trans_history.dart';
import 'package:globipay_admin_panel/modules/amount_section/trans_history/trans_history_response.dart';


class TransactionHistoryController extends BaseController {
  var transactions = <Transaction>[].obs;
  var totalItems = 0.obs;
  var currentPage = 1.obs;
  var pageSize = 10.obs;
  var isLoading = false.obs;

  Future<void> fetchTransactions(int page, int limit) async {
    try {
      isLoading.value = true;

      // Simulated delay to mimic an API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock response data
      var mockResponse = {
        "responseCode": "S100000",
        "responseMessage": "Transaction history fetched successfully",
        "data": {
          "transactions": [
            {
              "id": 16,
              "cat_id": 3,
              "catagory_name": "Apple pay",
              "uid": "b7746c19-7a61-11ef-8211-80fa5b888c9a",
              "coin": 55,
              "date": "2024-09-25T16:23:56.000Z",
              "name": "John Doe",
              "email": "john@example.com",
              "created_by": "Admin",
              "coin_type": "SECONDARY"
            },
            {
              "id": 17,
              "cat_id": 4,
              "catagory_name": "Google pay",
              "uid": "b7746c19-7a61-11ef-8211-80fa5b888c9a",
              "coin": 55,
              "date": "2024-09-25T16:23:56.000Z",
              "name": "John Doe",
              "email": "john@example.com",
              "created_by": "Admin",
              "coin_type": "PRIMARY"
            }
          ],
          "pagination": {
            "total": 13,
            "total_pages": 2,
            "current_page": 2,
            "limit": 10
          }
        }
      };

      var transactionResponse = TransactionResponse.fromJson(mockResponse);
      if (transactionResponse != null) {
        transactions.assignAll(transactionResponse.transactions);
        totalItems.value = transactionResponse.pagination.total;
        currentPage.value = transactionResponse.pagination.currentPage;
      }
    } catch (e) {
      print("Error fetching transactions: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void updatePageSize(int newSize) {
    pageSize.value = newSize;
    fetchTransactions(1, newSize);
  }

  @override
  void onInit() {
    super.onInit();
    fetchTransactions(currentPage.value, pageSize.value);
  }
}