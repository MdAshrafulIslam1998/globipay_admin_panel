import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/constants/app_spaces.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text.dart';
import 'package:globipay_admin_panel/entity/response/chat_item/chat_item_response_entity.dart';
import 'package:globipay_admin_panel/modules/chat/chat_message_list/views/widgets/status_badge_widget.dart';

/**
 * Created by Abdullah on 18/10/24.
 */

class ChatListItem extends StatelessWidget {
  final ChatItemResponseEntity chat;

  ChatListItem({required this.chat});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor:  Colors.grey[200],
                      child: Image.network(
                        chat.avatarUrl ?? '',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: getUserMessage(chat),
                            ),
                            //getTrailingWidget(chat)
                          ],
                        ),
                        AppSpaces.spaceBetweenChild,
                        const Divider(height: 2, color: Colors.black12),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),

    );
  }

  Widget getTrailingWidget(ChatItemResponseEntity chat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppText(
          chat.time ?? '',
          style: const TextStyle(fontSize: 14),
        ),
        if (chat.status != null) StatusBadge(status: chat.status!),
      ],
    );
  }

  Widget getUserMessage(ChatItemResponseEntity chat) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(chat.customerName ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        Row(
          children: [
            if (chat.attachment != null) AttachmentIcon(type: chat.attachment!),
            AppText(
              chat.lastMessage ?? '',
              style: const TextStyle(fontSize: 14),
              maxLength: 30,
              maxLine: 1,
            ),
          ],
        ),
      ],
    );
  }
}
