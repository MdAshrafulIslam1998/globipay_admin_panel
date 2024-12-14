import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/modules/media_section/message_templates/message_templates_model.dart';
import 'package:globipay_admin_panel/modules/media_section/message_templates/templates_list/controller/message_templates_controller.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';

class MessageTemplatesScreenBuilder extends BaseView<MessageTemplatesController> {

  MessageTemplatesScreenBuilder(){
    controller.onInit();
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message Management',
            style: TextStyle(fontWeight: FontWeight.bold)
        ),
        actions: [
          ElevatedButton.icon(
            icon: Icon(Icons.add, color: Colors.white),
            label: Text('Create Templates', style: TextStyle(color: Colors.white)),
            onPressed: () {
             controller.navigateToAddTemplated();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
          prefixIcon: Icon(Icons.search),
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
          Icon(Icons.messenger_outline, size: 100, color: Colors.grey),
          SizedBox(height: 16),
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

  Widget _buildMessageCard(MessageTemplatesModel templates) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          templates.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              templates.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            _buildCategoryBadge(templates)
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => controller.removeMessageTemplate(templates.id),
          tooltip: 'Remove Templates',
        ),
      ),
    );
  }

  Widget _buildCategoryBadge(MessageTemplatesModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color:  Colors.green[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        model.category.name ?? '',
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
          decoration: InputDecoration(
            labelText: 'Search Users',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            // Filtering handled in searchUsers method
          },
        ),
        SizedBox(height: 10),
        Obx(() => Wrap(
          spacing: 8,
          children: controller.searchUsers('').map((message) =>
              ActionChip(
                label: Text(message.title),
                onPressed: () => controller.addSelectedTemplates(message),
              )
          ).toList(),
        )),
        SizedBox(height: 10),
        /*Obx(() => Wrap(
          spacing: 8,
          children: controller.selectedUsers.map((user) =>
              Chip(
                label: Text(user.name),
                deleteIcon: Icon(Icons.close),
                onDeleted: () => controller.removeSelectedUser(user),
              )
          ).toList(),
        )),*/
      ],
    );
  }
}

