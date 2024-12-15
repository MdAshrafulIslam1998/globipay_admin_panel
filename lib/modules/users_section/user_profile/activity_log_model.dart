import 'package:intl/intl.dart';

/**
 * Created by Abdullah on 15/12/24.
 */

class ActivityLogModel {
  final String id;
  final DateTime timestamp;
  final String type; // Login, Chat Created, Profile Pic Changed, etc.

  ActivityLogModel({
    required this.id,
    required this.timestamp,
    required this.type,
  });

  String get formattedTimestamp => DateFormat('dd MMM yyyy HH:mm').format(timestamp);
}