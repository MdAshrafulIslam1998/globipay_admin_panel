import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/model/active_user_model.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/controller/enhanced_table_controller.dart';
import 'package:intl/intl.dart'; // Add this line
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:excel/excel.dart';

class ActiveUsersController extends BaseController {
  var featureName = "Active Users";
  final RxList<ActiveUserModel> users = <ActiveUserModel>[].obs;
  var tableData = <Map<String, dynamic>>[].obs;


  EnhancedTableController tableController = Get.put(EnhancedTableController(), permanent: false, tag: 'active_users');

  ActiveUsersController() ;

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  void generateTableData(List<ActiveUserModel> users) {
    tableData.value = users.map((user) {
      return user.toMap(
        onChatPressed: handleChatPressed,
        onProfilePressed: handleProfilePressed,
      );
    }).toList();
    tableController.initialize(tableData, 10);
  }

  void loadUsers() {
    // TODO implement coin request logic
    // TODO For Dummy purpose

    var list = <ActiveUserModel>[];
    for (var i = 0; i < 100; i++) {
      list.add(
        ActiveUserModel(
          id: 1,
          name: 'Alice Johnson $i',
          email: 'john@example.com',
          status: 'Online',
          lastActive: DateTime.now(),
          role: 'Admin',
          activityCount: 45 + i,
        ),
      );
    }
    users.value = list;
    generateTableData(list);
  }

  void filterAll() {
    loadUsers();
  }

  void handleChatPressed(int id) {
    print("Chat with user with id: $id");
  }

  void handleProfilePressed(int id) {
    print("View profile for user with id: $id");
  }

  void exportToExcel() {
    try {
      // Create a new Excel document
      var excel = Excel.createExcel();
      String sheetName = 'Active Users';
      Sheet sheetObject =
          excel.sheets.values.first; // Work with the default sheet

      // Define styles
      var headerStyle = CellStyle(
        backgroundColorHex: '#1E88E5', // Blue background
        fontColorHex: '#FFFFFF', // White text
        bold: true,
      );

      var dataStyle = CellStyle(
        textWrapping: TextWrapping.WrapText,
      );

      // Add title row
      sheetObject.merge(
          CellIndex.indexByString("A1"), CellIndex.indexByString("G1"));
      var titleCell = sheetObject.cell(CellIndex.indexByString("A1"));
      titleCell.value =
          'Active Users Report - ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())}';
      titleCell.cellStyle = CellStyle(
        bold: true,
        fontSize: 14,
      );

      // Add summary section
      int totalUsers = users.length;
      int activeUsers = users.where((user) => user.status == 'Online').length;
      int offlineUsers = users.where((user) => user.status == 'Offline').length;

      var summaryRows = [
        ['Summary'],
        ['Total Users:', totalUsers],
        ['Active Users:', activeUsers],
        ['Offline Users:', offlineUsers],
        [], // Empty row for spacing
      ];

      int currentRow = 2; // Start after title
      for (var summaryRow in summaryRows) {
        for (var i = 0; i < summaryRow.length; i++) {
          var cell = sheetObject.cell(
              CellIndex.indexByColumnRow(columnIndex: i, rowIndex: currentRow));
          cell.value = summaryRow[i];
          if (i == 0) cell.cellStyle = CellStyle(bold: true);
        }
        currentRow++;
      }

      // Add headers
      var headers = [
        'ID',
        'Name',
        'Email',
        'Status',
        'Last Active',
        'Role',
        'Activity Count'
      ];

      // Add headers row
      for (var i = 0; i < headers.length; i++) {
        var cell = sheetObject.cell(CellIndex.indexByColumnRow(
          columnIndex: i,
          rowIndex: currentRow,
        ));
        cell.value = headers[i];
        cell.cellStyle = headerStyle;
      }
      currentRow++;

      // Add data rows with applied styling
      for (var user in users) {
        var rowData = [
          user.id,
          user.name,
          user.email,
          user.status,
          user.lastActive != null
              ? DateFormat('yyyy-MM-dd HH:mm').format(user.lastActive!)
              : '',
          user.role,
          user.activityCount,
        ];

        for (var i = 0; i < rowData.length; i++) {
          var cell = sheetObject.cell(CellIndex.indexByColumnRow(
            columnIndex: i,
            rowIndex: currentRow,
          ));
          cell.value = rowData[i];

          // Apply specific styling based on column type
          if (i == 3) {
            // Status column styling
            if (rowData[i] == 'Online') {
              cell.cellStyle = CellStyle(
                backgroundColorHex: '#C8E6C9', // Light green
                bold: true,
              );
            } else {
              cell.cellStyle = CellStyle(
                backgroundColorHex: '#FFCDD2', // Light red
                bold: true,
              );
            }
          } else {
            cell.cellStyle = dataStyle;
          }
        }
        currentRow++;
      }

      // Generate the Excel file
      final List<int>? fileBytes = excel.encode();

      if (fileBytes != null) {
        // Create download link for web
        final blob = html.Blob([
          fileBytes
        ], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute("download",
              "ActiveUsersReport_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.xlsx")
          ..click();

        // Clean up
        html.Url.revokeObjectUrl(url);
      }
    } catch (e) {
      print('Error generating Excel file: $e');
    }
  }

  void exportToPDF() async {
    final pdf = pw.Document();

    // Load logo image data
    final ByteData imageData = await rootBundle.load('assets/logo/Logo.png');
    final Uint8List logoBytes = imageData.buffer.asUint8List();

    // Create styles for the document
    final headerStyle =
        pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold);
    final tableHeaderStyle =
        pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold);

    pdf.addPage(
      pw.MultiPage(
        // Enable multiple pages if content overflows
        maxPages: 100,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return [
            // Header section
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(pw.MemoryImage(logoBytes), width: 60, height: 60),
                  pw.Text(DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
                      style: pw.TextStyle(fontSize: 12)),
                ]),
            pw.SizedBox(height: 20),

            // Report title
            pw.Text('Active Users Report', style: headerStyle),
            pw.SizedBox(height: 10),
            pw.Divider(),
            pw.SizedBox(height: 20),

            // Summary section
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey200,
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Report Summary:',
                      style: pw.TextStyle(
                          fontSize: 14, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 5),
                  pw.Text('Total Users: ${users.length}'),
                  pw.Text(
                      'Active Users: ${users.where((user) => user.status == 'Online').length}'),
                  pw.Text(
                      'Offline Users: ${users.where((user) => user.status == 'Offline').length}'),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // Users table
            pw.Table.fromTextArray(
              border: null,
              headerStyle: tableHeaderStyle,
              headerDecoration: const pw.BoxDecoration(
                color: PdfColors.grey300,
              ),
              cellHeight: 30,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerLeft,
                2: pw.Alignment.centerLeft,
                3: pw.Alignment.center,
                4: pw.Alignment.center,
                5: pw.Alignment.center,
                6: pw.Alignment.center,
              },
              headers: [
                'ID',
                'Name',
                'Email',
                'Status',
                'Last Active',
                'Role',
                'Activity'
              ],
              data: users
                  .map((user) => [
                        user.id.toString(),
                        user.name ?? '',
                        user.email ?? '',
                        user.status ?? '',
                        user.lastActive != null
                            ? DateFormat('MM/dd HH:mm').format(user.lastActive!)
                            : '',
                        user.role ?? '',
                        user.activityCount?.toString() ?? '0',
                      ])
                  .toList(),
            ),
          ];
        },
      ),
    );

    // For web, create a download link
    final pdfBytes = await pdf.save();
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download",
          "ActiveUsersReport_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.pdf")
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
