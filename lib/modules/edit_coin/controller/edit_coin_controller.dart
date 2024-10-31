import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/model/coin_data_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_button_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_column_model.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/controller/enhanced_table_controller.dart';

class EditCoinController extends BaseController {
  final RxList<EditCoinModel> coins = <EditCoinModel>[].obs;
  var tableData = <Map<String, dynamic>>[].obs;


  EnhancedTableController tableController = Get.put(EnhancedTableController(), permanent: false, tag: 'edit_coin');

  @override
  void onInit() {
    super.onInit();
  }


  void generateTableData(List<EditCoinModel> coins) {
    tableData.value = coins.map((coin) {
      return coin.toMap(
        onEditPressed: handleEditProfile,
        onViewPressed: handleViewProfile,
      );
    }).toList();

    tableController.initialize(tableData, 10);

  }

  void requestForCoin() {
    // TODO implement coin request logic
    // TODO For Dummy purpose

    var list = <EditCoinModel>[];
    for (var i = 0; i < 100; i++) {
      list.add(
        EditCoinModel(
          id: 1,
          fullName: 'Alice Johnson $i',
          email: 'alice@example.com',
          amount: {'S': 30.00 + i, 'V': 100.00 + i, '&': 300.00 + i},
          status: 'Active',
        ),
      );
    }
    coins.value = list;
    generateTableData(list);
  }


  // Action handlers for Edit and View profile
  void handleEditProfile(int id) {
    // Implement profile editing logic for a coin with the given id
    print("Edit profile for coin with id: $id");
  }

  void handleViewProfile(int id) {
    // Implement profile viewing logic for a coin with the given id
    print("View profile for coin with id: $id");
  }

  // Filters for All, Dollar, Rupee, Taka
  void filterAll() {
    requestForCoin();
  }

  void filterByDollar() {
    // Filter coins by dollar amount (e.g., check if amount['S'] exists and > 0)
    coins.value = coins.where((coin) => coin.amount.containsKey('S')).toList();
    generateTableData(coins);
  }

  void filterByRupee() {
    coins.value = coins.where((coin) => coin.amount.containsKey('V')).toList();
    generateTableData(coins);

  }

  void filterByTaka() {
    coins.value = coins.where((coin) => coin.amount.containsKey('&')).toList();
    generateTableData(coins);
  }

  // Export functions for Excel and PDF
  void exportToExcel() {
    // Implement Excel export logic here
    print("Exporting data to Excel");
  }

  void exportToPDF() {
    // Implement PDF export logic here
    print("Exporting data to PDF");
  }

  List<TableColumnModel> get columns => [
    TableColumnModel(
      label: 'Full Name',
      key: 'fullName',
      sortable: true,
    ),
    TableColumnModel(
      label: 'Email',
      key: 'email',
      sortable: true,
    ),
    TableColumnModel(
      label: 'Amount',
      key: 'amount',
      sortable: true,
    ),
    TableColumnModel(
      label: 'Status',
      key: 'status',
      sortable: true,
    ),
    TableColumnModel(
      label: 'Edit',
      key: 'edit',
      sortable: false,
    ),
    TableColumnModel(
      label: 'Details',
      key: 'details',
      sortable: false,
    ),
  ];

  List<TableButtonModel> get buttons => [
    // New buttons: All, $, V, &
    TableButtonModel(
      text: 'All',
      icon: SvgPicture.asset(
        'assets/icons/check_all_light.svg',
        height: 15,
        width: 15,
        color: Colors.green,
      ),
      backgroundColor: Colors.grey.shade200,
      textColor: Colors.black,
      onPressed: () => filterAll(),
    ),
    TableButtonModel(
      text: '\$',
      icon: SvgPicture.asset(
        'assets/icons/dollar_light.svg',
        height: 15,
        width: 15,
        color: Colors.green,
      ),
      backgroundColor: Colors.grey.shade200,
      textColor: Colors.black,
      onPressed: () => filterByDollar(),
    ),
    TableButtonModel(
      text: 'V',
      icon: SvgPicture.asset(
        'assets/icons/repee_light.svg',
        height: 15,
        width: 15,
        color: Colors.green,
      ),
      backgroundColor: Colors.grey.shade200,
      textColor: Colors.black,
      onPressed: () => filterByRupee(),
    ),
    TableButtonModel(
      text: '&',
      icon: SvgPicture.asset(
        'assets/icons/tag_light.svg',
        height: 15,
        width: 15,
        color: Colors.green,
      ),
      backgroundColor: Colors.grey.shade200,
      textColor: Colors.black,
      onPressed: () => filterByTaka(),
    ),
    // Export and PDF buttons
    TableButtonModel(
      text: 'Export Excel',
      icon: SvgPicture.asset(
        'assets/icons/excel_light.svg',
        height: 15,
        width: 15,
        color: Colors.green,
      ),
      backgroundColor: Colors.green.shade50,
      textColor: Colors.green,
      onPressed: exportToExcel,
    ),
    TableButtonModel(
      text: 'Export PDF',
      icon: SvgPicture.asset(
        'assets/icons/pdf_light.svg',
        height: 18,
        width: 18,
        color: Colors.red,
      ),
      backgroundColor: Colors.red.shade50,
      textColor: Colors.red,
      onPressed: exportToPDF,
    ),
  ];
}
