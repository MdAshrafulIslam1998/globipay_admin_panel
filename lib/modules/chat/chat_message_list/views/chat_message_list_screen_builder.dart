import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/core/constants/app_images.dart';
import 'package:globipay_admin_panel/core/constants/app_spaces.dart';
import 'package:globipay_admin_panel/core/theme/color_palettes.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text.dart';
import 'package:globipay_admin_panel/entity/response/chat_item/chat_item_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/chat_session_response/chat_session_response.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import '../controller/chat_message_controller.dart';
import 'package:globipay_admin_panel/core/utils/extensions.dart';
/**
 * Created by Abdullah on 16/10/24 08:01 PM.
 */

class ChatMessageListScreenBuilder extends StatefulWidget {
  const ChatMessageListScreenBuilder({super.key});

  @override
  State<ChatMessageListScreenBuilder> createState() =>
      _ChatMessageListScreenBuilderState();
}

class _ChatMessageListScreenBuilderState
    extends BaseViewState<ChatMessageListScreenBuilder, ChatMessageController> {
  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  EdgeInsets setPagePadding() {
    return const EdgeInsets.all(18);
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        AppSpaces.spaceBetweenChild,

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Text(
            'Messages',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () => ListView.builder(
              itemCount: controller.chatList.value.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final chat = controller.chatList[index];
                return AnimatedChatListItem(
                  chat: chat,
                  index: index,
                  onTap: () {
                    controller.onMessageItemClicked(chat);
                  },
                );
              },
            ),
          ),
        )
      ],
    );
  }
}

class AnimatedChatListItem extends StatelessWidget {
  final ChatSessionResponse chat;
  final int index;
  Function onTap;

  AnimatedChatListItem(
      {required this.chat, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: ChatListItem(chat: chat),
      ),
    );
  }
}

class ChatListItem extends StatelessWidget {
  final ChatSessionResponse chat;

  ChatListItem({required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: ColorPalettes.colorPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
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
                  backgroundColor: Colors.grey[200],
                  child: Image.network(
                    chat.avatar_url ?? '',
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
                        getTrailingWidget(chat)
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

  Widget getTrailingWidget(ChatSessionResponse chat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppText(
           chat.last_message_timestamp?.chatMessageTimestamp() ?? '',
          style: const TextStyle(fontSize: 14),
        ),
       /* if (chat.status != null)*/
        StatusBadge(status: "New"),

      ],
    );
  }

  Widget getUserMessage(ChatSessionResponse chat) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(chat.user_name ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        Row(
          children: [
            if (chat.isTyping ?? false)
              AppText(
                "Typing...",
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                  fontSize: 14,
                ),
              )
            else ...[
              if (chat.message_type != null)
                AttachmentIcon(type: chat.message_type!),
              AppText(
                chat.last_message ?? '',
                style: const TextStyle(fontSize: 14),
                maxLength: 30,
                maxLine: 1,
              ),
            ]
          ],
        ),
      ],
    );
  }
}


class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'new':
        backgroundColor = ColorPalettes.colorPrimary;
        textColor = Colors.white;
        break;
      case 'closed':
        backgroundColor = ColorPalettes.colorPrimary;
        textColor = Colors.white;
        break;
      default:
        backgroundColor = Colors.grey.shade200;
        textColor = Colors.black;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: AppText(
        status,
        style: TextStyle(
            color: textColor, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class AttachmentIcon extends StatelessWidget {
  final String type;

  AttachmentIcon({required this.type});

  @override
  Widget build(BuildContext context) {
    IconData? iconData;
    switch (type.toLowerCase()) {
      case 'voice':
        iconData = Icons.mic;
        break;
      case 'video':
        iconData = Icons.videocam;
        break;
      case 'file':
        iconData = Icons.insert_drive_file;
        break;
      case 'image':
        iconData = CupertinoIcons.photo;
        break;
      default:
        iconData = null;
    }

    return iconData == null ? SizedBox() : Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Icon(iconData, size: 16, color: Theme.of(context).hintColor),
    );
  }
}
