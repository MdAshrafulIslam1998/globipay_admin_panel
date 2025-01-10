
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/core/constants/app_spaces.dart';
import 'package:globipay_admin_panel/core/theme/color_palettes.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text.dart';
import 'package:globipay_admin_panel/entity/response/chat_session_response/chat_session_response.dart';
import '../controller/chat_message_controller.dart';
import 'package:globipay_admin_panel/core/utils/extensions.dart';

/**
 * Created by Abdullah on 16/10/24 08:01 PM.
 */

/*
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
                return ChatListItem(chat, controller);
              },
            ),
          ),
        )
      ],
    );
  }
}

class ChatListItem extends StatelessWidget {
  final ChatSessionResponse chat;
  ChatMessageController controller;
  ChatListItem(this.chat, this.controller);

  bool isChatActive (ChatSessionResponse chat){
    return chat.status == 'closed' ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !isChatActive(chat) ? null : (){
        controller.onMessageItemClicked(chat);
      } ,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: getBackgroundColor(chat),
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
      ),
    );
  }


  Color getBackgroundColor(ChatSessionResponse chat) {
    return chat.status == 'closed'
        ? ColorPalettes.colorError.withOpacity(0.1)
        : ColorPalettes.colorPrimary.withOpacity(0.1);
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
       */
/* if (chat.status != null)*//*

        StatusBadge(status: chat.status ?? ""),

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


*/

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ChatMessageListScreenBuilder extends StatefulWidget {
  const ChatMessageListScreenBuilder({super.key});

  @override
  State<ChatMessageListScreenBuilder> createState() =>
      _ChatMessageListScreenBuilderState();
}

class _ChatMessageListScreenBuilderState
    extends BaseViewState<ChatMessageListScreenBuilder, ChatMessageController> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  EdgeInsets setPagePadding() {
    return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        AppSpaces.spaceBetweenChild,
        Expanded(
          child: Obx(
                () => ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.chatList.value.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final chat = controller.chatList[index];
                return controller.chatList.value.length == 0
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 48,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No messages found',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ) : _buildAnimatedChatItem(chat, index);

              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.8),
            Theme.of(context).primaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.chat_bubble_outline,
              color: Colors.white,
              size: 28
          ),
          const SizedBox(width: 12),
          Text(
            'Messages',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          //_buildUnreadBadge(),
        ],
      ),
    );
  }

  Widget _buildUnreadBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '${controller.chatList.where((chat) => chat.status == 'new').length} new',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAnimatedChatItem(ChatSessionResponse chat, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100)),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: ChatListItem(chat, controller),
          ),
        );
      },
    );
  }
}

class ChatListItem extends StatelessWidget {
  final ChatSessionResponse chat;
  final ChatMessageController controller;

  ChatListItem(this.chat, this.controller);

  bool isChatActive(ChatSessionResponse chat) {
    return chat.status != 'closed';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap:(){
          controller.onMessageItemClicked(chat);
        } ,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _getItemGradient(chat),
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _getItemShadowColor(chat),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: chat.isTyping ?? false
                  ? ImageFilter.blur(sigmaX: 0, sigmaY: 0)
                  : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAvatar(),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildUserInfo(),
                          const SizedBox(height: 8),
                          _buildMessagePreview(),
                        ],
                      ),
                    ),
                    _buildTimeAndStatus(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey[200],
          child: chat.avatar_url != null && chat.avatar_url!.isNotEmpty
              ? ClipOval(
            child: Image.network(
              chat.avatar_url!,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return _buildAvatarShimmer();
              },
              errorBuilder: (context, error, stackTrace) =>
                  _buildInitialsAvatar(),
            ),
          )
              : _buildInitialsAvatar(),
        ),
        if (isChatActive(chat))
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAvatarShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 56,
        height: 56,
        color: Colors.white,
      ),
    );
  }

  Widget _buildInitialsAvatar() {
    final initials = (chat.user_name != null && chat.user_name!.isNotEmpty)
        ? chat.user_name!
        .split(' ')
        .where((e) => e.isNotEmpty) // Ensure non-empty parts
        .map((e) => e[0]) // Get the first character of each part
        .take(2) // Take up to 2 initials
        .join()
        : '';

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue[400]!,
            Colors.blue[600]!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Row(
      children: [
        Expanded(
          child: Text(
            chat.user_name ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (chat.status == 'new')
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }

  Widget _buildMessagePreview() {
    if (chat.isTyping ?? false) {
      return _buildTypingIndicator();
    }

    return Row(
      children: [
        if (chat.message_type != null) ...[
          AttachmentIcon(type: chat.message_type!),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            chat.last_message ?? '',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      children: [
        Text(
          'Typing',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 4),
        _buildTypingDots(),
      ],
    );
  }

  Widget _buildTypingDots() {
    return Row(
      children: List.generate(
        3,
            (index) => TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 600),
          builder: (context, value, child) {
            return Container(
              width: 4,
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.grey[600]!.withOpacity(
                    (value + index / 3) % 1.0),
                borderRadius: BorderRadius.circular(2),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTimeAndStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          chat.last_message_timestamp?.chatMessageTimestamp() ?? '',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        StatusBadge(status: chat.status ?? ''),
      ],
    );
  }

  List<Color> _getItemGradient(ChatSessionResponse chat) {
    if (chat.status == 'closed') {
      return [
        Colors.red[100]!,
        Colors.red[50]!,
      ];
    }
    else if (chat.status == 'pending') {
      return [
        Colors.blue[900]!,
        Colors.blueAccent,
      ];
    }
    return [
      Colors.blue[50]!,
      Colors.white,
    ];
  }

  Color _getItemShadowColor(ChatSessionResponse chat) {
    return chat.status == 'closed'
        ? Colors.red[100]!.withOpacity(0.3)
        : Colors.blue[100]!.withOpacity(0.3);
  }
}

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _getStatusColors(),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _getStatusColors().first.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        _getStatusText(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  List<Color> _getStatusColors() {
    switch (status.toLowerCase()) {
      case 'new':
        return [Colors.green[400]!, Colors.green[600]!];
      case 'closed':
        return [Colors.red[400]!, Colors.red[600]!];
      case 'pending':
        return [Colors.green[400]!, Colors.green[600]!];
      default:
        return [Colors.blue[400]!, Colors.blue[600]!];
    }
  }

  String _getStatusText() {
    return status.toLowerCase().capitalize ?? '';
  }
}

class AttachmentIcon extends StatelessWidget {
  final String type;

  const AttachmentIcon({required this.type});

  @override
  Widget build(BuildContext context) {
    IconData? iconData;
    Color iconColor;

    switch (type.toLowerCase()) {
      case 'voice':
        iconData = Icons.mic;
        iconColor = Colors.orange;
        break;
      case 'video':
        iconData = Icons.videocam;
        iconColor = Colors.red;
        break;
      case 'file':
        iconData = Icons.insert_drive_file;
        iconColor = Colors.blue;
        break;
      case 'image':
        iconData = CupertinoIcons.photo;
        iconColor = Colors.green;
        break;
      default:
        return const SizedBox();
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        iconData,
        size: 16,
        color: iconColor,
      ),
    );
  }
}
