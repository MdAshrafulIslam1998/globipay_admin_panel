import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/entity/response/messages_templates/message_templates_item_entity.dart';
import 'package:globipay_admin_panel/modules/media_section/message_templates/message_templates_model.dart';
import 'package:globipay_admin_panel/modules/media_section/message_templates/templates_list/controller/message_templates_controller.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';

class MessageTemplatesScreenBuilder extends BaseView<MessageTemplatesController> {

  MessageTemplatesScreenBuilder({super.key}){
    controller.onInit();
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Management',
            style: TextStyle(fontWeight: FontWeight.bold)
        ),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('Create Templates', style: TextStyle(color: Colors.white)),
            onPressed: () {
             controller.navigateToAddTemplated();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              padding: const  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: Obx(() => _buildMessageTemplatesList()),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search messages...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: (value) => controller.searchQuery.value = value,
      ),
    );
  }

  Widget _buildMessageTemplatesList() {
    final filteredTemplates = controller.filteredMessagesTemplates;

    return filteredTemplates.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.messenger_outline, size: 100, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'No Templates Found',
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600]
            ),
          ),
        ],
      ),
    )
        : ListView.builder(
      itemCount: filteredTemplates.length,
      itemBuilder: (context, index) {
        final notification = filteredTemplates[index];
        return _buildMessageCard(notification);
      },
    );
  }

  Widget _buildMessageCard(MessageTemplatesItemEntity templates) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const  EdgeInsets.all(16),
        title: Text(
          templates.title ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              templates.description ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              templates.create_date ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            _buildCategoryBadge(templates)
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => controller.removeMessageTemplate(templates.uid.toString()),
          tooltip: 'Remove Templates',
        ),
      ),
    );
  }

  Widget _buildCategoryBadge(MessageTemplatesItemEntity model) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color:  Colors.green[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        model.category_name ?? '',
        style: TextStyle(
          fontSize: 12,
          color: Colors.blue[800],
        ),
      ),
    );
  }


  Widget _buildUserSelection() {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Search Users',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            // Filtering handled in searchUsers method
          },
        ),
        const SizedBox(height: 10),
        Obx(() => Wrap(
          spacing: 8,
          children: controller.searchUsers('').map((message) =>
              ActionChip(
                label: Text(message.title ?? ""),
                onPressed: () => controller.addSelectedTemplates(message),
              )
          ).toList(),
        )),
        const SizedBox(height: 10),

      ],
    );
  }
}

