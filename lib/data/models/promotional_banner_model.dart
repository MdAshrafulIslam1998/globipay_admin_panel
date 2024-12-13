/**
 * Created by Abdullah on 13/12/24.
 */

import 'dart:io';
import 'package:get/get.dart';

class PromotionalBannerModel {
  final String id;
  final String title;
  final String description;
  final String backgroundColor;
  final String? imageUrl;
  final File? imageFile;
  final DateTime startDate;
  final DateTime endDate;
  final bool isVisibleToAll;
  final bool isActive;
  final int priority;
  final String? destinationUrl;

  PromotionalBannerModel({
    String? id,
    required this.title,
    required this.description,
    required this.backgroundColor,
    this.imageUrl,
    this.imageFile,
    required this.startDate,
    required this.endDate,
    this.isVisibleToAll = true,
    this.isActive = true,
    this.priority = 0,
    this.destinationUrl,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  // Convert to JSON for storage/transmission
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'backgroundColor': backgroundColor,
    'imageUrl': imageUrl,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'isVisibleToAll': isVisibleToAll,
    'isActive': isActive,
    'priority': priority,
    'destinationUrl': destinationUrl,
  };

  // Create from JSON
  factory PromotionalBannerModel.fromJson(Map<String, dynamic> json) {
    return PromotionalBannerModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      backgroundColor: json['backgroundColor'],
      imageUrl: json['imageUrl'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      isVisibleToAll: json['isVisibleToAll'] ?? true,
      isActive: json['isActive'] ?? true,
      priority: json['priority'] ?? 0,
      destinationUrl: json['destinationUrl'],
    );
  }

  // Validate banner
  bool get isValid {
    return title.isNotEmpty &&
        description.isNotEmpty &&
        startDate.isBefore(endDate) &&
        (imageUrl != null || imageFile != null);
  }

  // Check if banner is currently active
  bool get isCurrentlyActive {
    final now = DateTime.now();
    return isActive &&
        now.isAfter(startDate) &&
        now.isBefore(endDate);
  }
}