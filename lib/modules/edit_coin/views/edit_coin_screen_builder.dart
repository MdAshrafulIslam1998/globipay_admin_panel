import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/modules/edit_coin/controller/edit_coin_controller.dart';
import 'package:globipay_admin_panel/modules/edit_coin/controller/edit_coin_datasource.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'dart:io';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;

class EditCoinScreenBuilder extends BaseView<EditCoinController> {
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  EditCoinScreenBuilder({Key? key}) : super(key: key) {
    controller.onInit();
  }
  Future<void> exportDataGridToExcel() async {
    // Create a workbook and worksheet
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet worksheet = workbook.worksheets[0];

    // Export the DataGrid to the worksheet
    _key.currentState?.exportToExcelWorksheet(worksheet);

    // Save the workbook as a stream of bytes
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    // Create a Blob and a download link
    final blob = html.Blob([bytes],
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create a temporary anchor element and trigger download
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "DataGrid.xlsx")
      ..click();

    // Cleanup: Revoke the object URL after download
    html.Url.revokeObjectUrl(url);
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(title: Text('Edit Coin'));
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() {
      List<Map<String, dynamic>> coinsList = controller.coins.toList();

      return Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                  width: 150.0,
                  child: MaterialButton(
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        'Export to Excel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: exportDataGridToExcel,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SfDataGridTheme(
              data: SfDataGridThemeData(
                headerHoverColor: Colors.deepPurple.withOpacity(0.2),
                headerColor: Colors.deepPurple,
                gridLineColor: Colors.grey.shade300,
              ),
              child: SfDataGrid(
                key: _key,
                source: EditCoinDataSource(controller, coinsList),
                columns: _buildColumns(),
                columnWidthMode: ColumnWidthMode.fill,
                gridLinesVisibility: GridLinesVisibility.both,
              ),
            ),
          ),
          SfDataPagerTheme(
            data: SfDataPagerThemeData(
              selectedItemColor: Color(0xFF7B61FF),
            ),
            child: SfDataPager(
              controller: controller.dataPagerController,
              delegate: EditCoinDataSource(controller, coinsList),
              pageCount: (coinsList.length / controller.selectedPageSize.value)
                  .ceil()
                  .toDouble(),
              direction: Axis.horizontal,
            ),
          ),
        ],
      );
    });
  }

  List<GridColumn> _buildColumns() {
    const headerStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return [
      GridColumn(
        columnName: 'fullName',
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text('Full Name', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'email',
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text('Email', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'amount',
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text('Amount', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'level',
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text('Level', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'status',
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text('Status', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'edit',
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text('Edit', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'details',
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text('Details', style: headerStyle),
        ),
      ),
    ];
  }
}