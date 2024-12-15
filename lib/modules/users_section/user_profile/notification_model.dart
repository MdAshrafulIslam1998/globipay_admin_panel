import 'package:intl/intl.dart';

/**
 * Created by Abdullah on 15/12/24.
 */

class NotificationModel {
  final String id;
  final String content;
  final DateTime timestamp;

  NotificationModel({
    required this.id,
    required this.content,
    required this.timestamp,
  });

  String get formattedTimestamp => DateFormat('dd MMM yyyy HH:mm').format(timestamp);
}