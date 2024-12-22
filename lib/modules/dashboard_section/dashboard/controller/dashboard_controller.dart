import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/response/dashboard/dashboard_transaction_balance_entity.dart';
import 'package:globipay_admin_panel/entity/response/dashboard/recent_transaction_response_entity.dart';

class DashboardController extends BaseController {
    var featureName = "Dashboard";

    AppRepository _repository;
    DashboardController(this._repository);

    //Rx Variable
    Rxn<DashboardTransactionBalanceEntity> dashboardBalance = Rxn<DashboardTransactionBalanceEntity>(null);
    RxList<RecentTransactionResponseEntity> recentTransactions = <RecentTransactionResponseEntity>[].obs;


    @override
    void onInit(){
      requestForDashboardTransactions();
      requestForRecentTransactions();
      super.onInit();
    }


    parseDashboardBalance(DashboardTransactionBalanceEntity balance){
      dashboardBalance.value = balance;
    }
    parseRecentTransactionHistory(List<RecentTransactionResponseEntity> response){
      recentTransactions.value = response;
    }


    void requestForDashboardTransactions() {
      final repo = _repository.requestForDashboardBalance();
      callService(repo , onSuccess: (response) {
        parseDashboardBalance(response);
      });
    }

    void requestForRecentTransactions() {
      final repo = _repository.requestForRecentTransactionHistory();
      callService(repo , onSuccess: (response) {
        parseRecentTransactionHistory(response);
      });
    }




}
