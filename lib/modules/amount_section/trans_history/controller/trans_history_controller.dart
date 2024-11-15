import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/amount_section/trans_history/trans_history.dart';
import 'package:globipay_admin_panel/modules/amount_section/trans_history/transaction_history_api_service.dart';

class TransactionHistoryController extends BaseController {
  var transactions = <Transaction>[].obs;
  var totalItems = 0.obs;
  var currentPage = 1.obs;
  var pageSize = 5.obs;
  var isLoading = false.obs;

  final TransactionHistoryApiService _apiService = TransactionHistoryApiService();

  Future<void> fetchTransactions(int page, int limit) async {
    print("\n ▌│█║▌║▌║▌│█║▌║▌║▌│█║▌║▌║");
    print("\n 🔴 Fetching Transaction History 🔴");
    print("🔻 Endpoint: /api/transaction/alltransactions");
    print("🔻 Page: $page, Limit: $limit");

    try {
      isLoading.value = true;
      var transactionResponse = await _apiService.fetchTransactions(page, limit);

      if (transactionResponse != null) {
        print("✅ Transactions fetched successfully.");
        transactions.assignAll(transactionResponse.transactions);
        totalItems.value = transactionResponse.pagination.total;
        currentPage.value = transactionResponse.pagination.currentPage;

        print("🔻 Number of transactions fetched: ${transactionResponse.transactions.length}");
        transactionResponse.transactions.forEach(
            (transaction) => print("- ${transaction.name} (${transaction.coinType} - ${transaction.categoryName})"));
      } else {
        print("API call returned null response.");
      }
    } catch (e) {
      print("Error fetching transactions: ${e.toString()}");
    } finally {
      isLoading.value = false;
      print("Loading state is now ${isLoading.value}");
    }
  }

  void updatePageSize(int newSize) {
    print("Updating page size to $newSize and fetching transactions from page 1");
    pageSize.value = newSize;
    fetchTransactions(1, newSize);
  }

  @override
  void onInit() {
    super.onInit();
    fetchTransactions(currentPage.value, pageSize.value);
  }
}
