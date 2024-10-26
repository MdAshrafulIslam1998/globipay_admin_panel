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
  final tableController = Get.put(EnhancedTableController());

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  void loadUsers() {
    // Simulating API call with more sample data
    users.value = [
      ActiveUserModel(
        id: 1,
        name: 'John Doe',
        email: 'john@example.com',
        status: 'Online',
        lastActive: DateTime.now(),
        role: 'Admin',
        activityCount: 45,
      ),
      ActiveUserModel(
        id: 2,
        name: 'Jane Smith',
        email: 'jane@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 2)),
        role: 'User',
        activityCount: 32,
      ),
      ActiveUserModel(
        id: 3,
        name: 'Alice Johnson',
        email: 'alice@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(minutes: 15)),
        role: 'Moderator',
        activityCount: 57,
      ),
      ActiveUserModel(
        id: 4,
        name: 'Bob Brown',
        email: 'bob@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 4)),
        role: 'User',
        activityCount: 20,
      ),
      ActiveUserModel(
        id: 5,
        name: 'Charlie Wilson',
        email: 'charlie@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(minutes: 5)),
        role: 'Admin',
        activityCount: 75,
      ),
      ActiveUserModel(
        id: 6,
        name: 'Diane Lee',
        email: 'diane@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 6)),
        role: 'User',
        activityCount: 29,
      ),
      ActiveUserModel(
        id: 7,
        name: 'Evelyn King',
        email: 'evelyn@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(hours: 1)),
        role: 'User',
        activityCount: 48,
      ),
      ActiveUserModel(
        id: 8,
        name: 'Frank Martin',
        email: 'frank@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 7)),
        role: 'Admin',
        activityCount: 61,
      ),
      ActiveUserModel(
        id: 9,
        name: 'Grace Young',
        email: 'grace@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(minutes: 25)),
        role: 'Moderator',
        activityCount: 83,
      ),
      ActiveUserModel(
        id: 10,
        name: 'Henry Davis',
        email: 'henry@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 10)),
        role: 'User',
        activityCount: 14,
      ),
      ActiveUserModel(
        id: 11,
        name: 'Ivy Gonzalez',
        email: 'ivy@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(minutes: 30)),
        role: 'User',
        activityCount: 67,
      ),
      ActiveUserModel(
        id: 12,
        name: 'Jack Miller',
        email: 'jack@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 12)),
        role: 'Admin',
        activityCount: 90,
      ),
      ActiveUserModel(
        id: 13,
        name: 'Kathy Anderson',
        email: 'kathy@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(minutes: 10)),
        role: 'User',
        activityCount: 36,
      ),
      ActiveUserModel(
        id: 14,
        name: 'Leo Perez',
        email: 'leo@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 15)),
        role: 'User',
        activityCount: 25,
      ),
      ActiveUserModel(
        id: 15,
        name: 'Mona Hall',
        email: 'mona@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(minutes: 20)),
        role: 'Admin',
        activityCount: 78,
      ),
      ActiveUserModel(
        id: 16,
        name: 'Nina Clark',
        email: 'nina@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 16)),
        role: 'User',
        activityCount: 12,
      ),
      ActiveUserModel(
        id: 17,
        name: 'Oscar Lewis',
        email: 'oscar@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(minutes: 45)),
        role: 'Moderator',
        activityCount: 60,
      ),
      ActiveUserModel(
        id: 18,
        name: 'Paul Walker',
        email: 'paul@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 18)),
        role: 'User',
        activityCount: 11,
      ),
      ActiveUserModel(
        id: 19,
        name: 'Quinn Wright',
        email: 'quinn@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(minutes: 5)),
        role: 'User',
        activityCount: 65,
      ),
      ActiveUserModel(
        id: 20,
        name: 'Rachel Harris',
        email: 'rachel@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 20)),
        role: 'Admin',
        activityCount: 88,
      ),
    ];

    final tableData = users.map((user) {
      String buttonText =
          getButtonText(user); // Get the button text based on user data

      return user.toMap((id) {
        // Action for the button press can be defined here
        viewUserDetails(id);
      }, buttonText: buttonText); // Pass the button text
    }).toList();

    tableController.initialize(tableData, 10);
  }

  String getButtonText(ActiveUserModel user) {
    // Customize button text based on user properties
    if (user.status == 'Online') {
      return 'Disconnect'; // Example text for online users
    } else {
      return 'Reconnect'; // Example text for offline users
    }
  }

  void viewUserDetails(int userId) {
    // Handle viewing user details
    print('Viewing details for user $userId');
  }

  void exportToExcel() {
  try {
    // Create a new Excel document
    var excel = Excel.createExcel();
    String sheetName = 'Active Users';
    Sheet sheetObject = excel.sheets.values.first; // Work with the default sheet

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
