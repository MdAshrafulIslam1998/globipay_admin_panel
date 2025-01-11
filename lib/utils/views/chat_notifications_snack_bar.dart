import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatNotification {
  final String userName;
  final String message;
  String? imageUrl;
  final DateTime timestamp;
  final VoidCallback? onTap;

  ChatNotification({
    required this.userName,
    required this.message,
    this.imageUrl,
    required this.timestamp,
    this.onTap,
  });
}

class ChatNotificationManager {
  static final ChatNotificationManager _instance =
      ChatNotificationManager._internal();

  factory ChatNotificationManager() => _instance;

  ChatNotificationManager._internal();

  static const int maxNotifications = 15;
  static const double notificationHeight = 90.0;
  static const double notificationSpacing = 10.0;

  OverlayEntry? _overlayEntry;
  final _notifications = <ChatNotification>[];
  final _notificationStateKey = GlobalKey<_NotificationsStateKey>();

  void show(
    BuildContext context, {
    required String userName,
    required String message,
    required String imageUrl,
    required DateTime timestamp,
    VoidCallback? onTap,
  }) {
    final notification = ChatNotification(
      userName: userName,
      message: message,
      imageUrl: imageUrl,
      timestamp: timestamp,
      onTap: onTap,
    );

    if (_notifications.length >= maxNotifications) return;

    _notifications.add(notification);

    if (_overlayEntry == null) {
      _createOverlay(context);
    } else {
      _notificationStateKey.currentState?.updateNotifications();
    }

    Future.delayed(const Duration(seconds: 4), () {
      _removeNotification(notification);
    });
  }

  void _createOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => _NotificationsOverlay(
        key: _notificationStateKey,
        notifications: _notifications,
        onDismiss: _removeNotification,
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  void _removeNotification(ChatNotification notification) {
    final index = _notifications.indexOf(notification);
    if (index != -1) {
      _notifications.removeAt(index);
      if (_notifications.isEmpty) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      } else {
        _notificationStateKey.currentState?.updateNotifications();
      }
    }
  }
}

class _NotificationsOverlay extends StatefulWidget {
  final List<ChatNotification> notifications;
  final Function(ChatNotification) onDismiss;

  const _NotificationsOverlay({
    Key? key,
    required this.notifications,
    required this.onDismiss,
  }) : super(key: key);

  @override
  _NotificationsStateKey createState() => _NotificationsStateKey();
}

class _NotificationsStateKey extends State<_NotificationsOverlay> {
  void updateNotifications() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.notifications.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == 0
                          ? 20
                          : ChatNotificationManager.notificationSpacing,
                      right: 20,
                      left: MediaQuery.of(context).size.width * 0.65,
                    ),
                    child: _NotificationCard(
                      notification: widget.notifications[index],
                      onDismiss: () =>
                          widget.onDismiss(widget.notifications[index]),
                    ),
                  );
                }).reversed.toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatefulWidget {
  final ChatNotification notification;
  final VoidCallback onDismiss;

  const _NotificationCard({
    Key? key,
    required this.notification,
    required this.onDismiss,
  }) : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<_NotificationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      axisAlignment: -1,
      child: FadeTransition(
        opacity: _animation,
        child: Dismissible(
          key: ObjectKey(widget.notification),
          onDismissed: (_) => widget.onDismiss(),
          child: GestureDetector(
            onTap: widget.notification.onTap,
            child: Container(
              height: ChatNotificationManager.notificationHeight,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.green.withOpacity(0.95),
                    Colors.lightGreenAccent.withOpacity(0.90),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: -5,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.2),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: isImageNullOrEmpty(widget.notification.imageUrl)
                            ? const Icon(
                                Icons.messenger_outline,
                                size: 20,
                              )
                            : CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    NetworkImage(widget.notification.imageUrl!),
                              ),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.notification.userName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.verified,
                                  size: 14,
                                  color: Colors.blue.shade400,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isImageNullOrEmpty(widget.notification.imageUrl)
                                  ? widget.notification.message
                                  : 'Sent an image',
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 13,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat('h:mm a')
                            .format(widget.notification.timestamp),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isImageNullOrEmpty(String? imageUrl) {
    try {
      return imageUrl == null || imageUrl.isEmpty;
    } catch (e) {
      return true;
    }

  }
}
