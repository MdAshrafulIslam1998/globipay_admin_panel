import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/widgets/app_print.dart';

import 'package:globipay_admin_panel/flavors/flavor_config.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_dialog.dart';
/**
 * Created by Abdullah on 15/11/24.
 */


extension StringExtensions on String {
  /// Converts a timestamp string into a human-readable format
  /// - Today: `hh:mm a` (e.g., 01:01 AM)
  /// - Yesterday: `Yesterday`
  /// - Otherwise: `dd-MM-yyyy` (e.g., 15-11-2024)
  String chatMessageTimestamp() {
    try {
      final inputDate = DateTime.parse(this);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(Duration(days: 1));

      if (inputDate.isAfter(today)) {
        return DateFormat('hh:mm a').format(inputDate); // Time with AM/PM
      } else if (inputDate.isAfter(yesterday)) {
        return 'Yesterday'; // Show "Yesterday"
      } else {
        return DateFormat('dd-MM-yyyy').format(inputDate); // Date in dd-MM-yyyy
      }
    } catch (e) {
      appPrint("Chat Message Timestamp Error: ${e.toString()}");
      return ""; // Handle invalid date strings
    }
  }

  String formatDate(String pattern) {
    try {
      // Parse the input date time string into a DateTime object
      DateTime dateTime = DateTime.parse(this).toLocal();

      // Format the DateTime object into the desired format
      String formattedDateTime = DateFormat(pattern,"en_US").format(dateTime);
      return formattedDateTime;
    } catch (e) {
      appPrint("Format Date Error: ${e.toString()}");
      return "";
    }
  }

  void toInAppBrowserView() async {
    Uri url = Uri.parse(this);
    if (url.scheme.isEmpty) {
      url = Uri.parse('https://${url.toString()}');
    }
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      showCustomDialog("Something went wrong");
    }
  }

  String includeBaseUrl() {
    if(this == null || this.isEmpty) return "";
    return FlavorConfig.instance.url + this;
  }

}





