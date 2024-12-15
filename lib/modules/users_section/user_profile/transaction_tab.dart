/**
 * Created by Abdullah on 15/12/24.
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/profile_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/transaction_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class TransactionsTab extends StatelessWidget {

  ProfileController controller;
  TransactionsTab(this.controller);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(
          child: Obx(() => ListView.builder(
            controller: controller.transactionScrollController,
            itemCount: controller.transactions.length +
                (controller.isTransactionLoading.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.transactions.length) {
                final transaction = controller.transactions[index];
                return _buildTransactionCard(transaction);
              } else {
                return _buildLoadingIndicator();
              }
            },
          )),
        ),
        _buildExportButton(),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search Transactions',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          // Implement search logic
        },
      ),
    );
  }

  Widget _buildTransactionCard(TransactionModel transaction) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: _getTransactionIcon(transaction.type),
        title: Text(
          transaction.categoryName,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          transaction.formattedDate,
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
        trailing: Text(
          transaction.formattedAmount,
          style: GoogleFonts.poppins(
            color: transaction.type == 'Primary' ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _getTransactionIcon(String type) {
    return CircleAvatar(
      backgroundColor: type == 'Primary' ? Colors.green[100] : Colors.red[100],
      child: Icon(
        type == 'Primary' ? Icons.arrow_upward : Icons.arrow_downward,
        color: type == 'Primary' ? Colors.green : Colors.red,
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListTile(
        leading: CircleAvatar(),
        title: Container(color: Colors.white, height: 10),
        subtitle: Container(color: Colors.white, height: 10),
      ),
    );
  }

  Widget _buildExportButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        onPressed: controller.exportTransactions,
        icon: Icon(Icons.download),
        label: Text('Export Transactions'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}