/**
 * Created by Abdullah on 15/12/24.
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/entity/response/user_transaction_history/user_transaction_history_item_response.dart';
import 'package:globipay_admin_panel/entity/response/user_transaction_history/user_transaction_history_response.dart';
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
        Row(
          children: [
            Expanded(child: _buildSearchBar()),
            Spacer(),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: (){
                controller.onRefreshTransactions();

              },
            ),

            ElevatedButton.icon(
              icon: Icon(Icons.add),
              onPressed: (){
                controller.onAddTransaction(context);
              },
              label: Text('Add Transaction'),
            ),
          ],
        ),

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

  Widget _buildTransactionCard(UserTransactionHistoryResponseItem transaction) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: _getTransactionIcon(transaction.coin_type ?? ""),
        title: Text(
          transaction.category?.name ?? '',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          transaction.date ?? '',
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
        trailing: Column(
          children: [
            Text(
              transaction.coin_type.toString(),
              style: GoogleFonts.poppins(
                color: isPrimaryTransaction(transaction.coin_type ?? "") ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              transaction.coin.toString(),
              style: GoogleFonts.poppins(
                color: isPrimaryTransaction(transaction.coin_type ?? "") ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTransactionIcon(String type) {
    return CircleAvatar(
      backgroundColor: isPrimaryTransaction(type) ? Colors.green[100] : Colors.red[100],
      child: Icon(
        type == isPrimaryTransaction(type) ? Icons.arrow_upward : Icons.arrow_downward,
        color: isPrimaryTransaction(type) ? Colors.green : Colors.red,
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

  bool isPrimaryTransaction(String coinType) {
    return coinType == 'PRIMARY';
  }
}