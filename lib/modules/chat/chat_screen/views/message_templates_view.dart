import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/entity/response/messages_templates/message_templates_item_entity.dart';
import 'package:globipay_admin_panel/modules/chat/chat_screen/controller/chat_controller.dart';

/**
 * Created by Abdullah on 21/12/24.
 */
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/modules/chat/chat_screen/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/modules/chat/chat_screen/controller/chat_controller.dart';

class MessageTemplate {
  final String uid;
  final String title;
  final String description;
  final int categoryId;
  final String createDate;
  final String createdBy;
  final String categoryName;

  MessageTemplate({
    required this.uid,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.createDate,
    required this.createdBy,
    required this.categoryName,
  });
}

class MessageTemplatesView extends StatelessWidget {
  final ChatController controller;

  const MessageTemplatesView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Close Button
          _buildHeader(),

          // Search Bar
          _buildSearchBar(),

          // Category Chips
          _buildCategoryChips(),

          // Templates List
          _buildTemplatesList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.chat_bubble_outline, color: Color(0xFF2196F3)),
          const SizedBox(width: 8),
          const Text(
            "Message Templates",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const Spacer(),
          ValueListenableBuilder<List<MessageTemplatesItemEntity>>(
            valueListenable: controller.filteredTemplates,
            builder: (context, templates, _) => Text(
              "${templates.length} templates",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () => controller.showTemplates.value = false,
            icon: const Icon(Icons.close),
            tooltip: 'Close templates',
            color: Colors.grey.shade600,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        onChanged: controller.onSearchChanged,
        decoration: InputDecoration(
          hintText: "Search templates...",
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ValueListenableBuilder<String>(
        valueListenable: controller.selectedCategory,
        builder: (context, selectedCategory, _) {
          final categories = ['All', ...controller.getUniqueCategories()];

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                final isSelected = category == selectedCategory;
                final count = category == 'All'
                    ? controller.templates.length
                    : controller.templates.where((t) => t.category_name == category).length;

                return Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text('$category ($count)'),
                    onSelected: (_) => controller.onCategorySelected(category),
                    backgroundColor: Colors.grey.shade50,
                    selectedColor: const Color(0xFF2196F3).withOpacity(0.1),
                    checkmarkColor: const Color(0xFF2196F3),
                    labelStyle: TextStyle(
                      color: isSelected ? const Color(0xFF2196F3) : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTemplatesList() {
    return Expanded(
      child: ValueListenableBuilder<List<MessageTemplatesItemEntity>>(
        valueListenable: controller.filteredTemplates,
        builder: (context, templates, _) {
          if (templates.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 48, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    "No templates found",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: templates.length,
            itemBuilder: (context, index) {
              final template = templates[index];
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  title: Text(
                    template.title ?? "",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2C2C2C),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        template.description ?? "",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Chip(
                        label: Text(
                          template.category_name ?? "",
                          style: const TextStyle(fontSize: 12),
                        ),
                        backgroundColor: const Color(0xFF2196F3).withOpacity(0.1),
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Color(0xFF2196F3),
                  ),
                  onTap: () {
                    controller.messageController.text = template.description ?? "";
                    controller.messageController.selection =
                        TextSelection.fromPosition(
                          TextPosition(offset: (template.description ?? "").length),
                        );
                    controller.showTemplates.value = false;
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}