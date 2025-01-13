import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/utils/app_utils.dart';

const double BUBBLE_RADIUS_IMAGE = 16;

class BubbleNormalImage extends StatelessWidget {
  static const loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  final String id;
  final Widget image;
  final double bubbleRadius;
  final bool isSender;
  final Color color;
  final bool tail;
  final bool sent;
  final bool delivered;
  final bool seen;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String? time;

  const BubbleNormalImage({
    super.key,
    required this.id,
    required this.image,
    this.bubbleRadius = BUBBLE_RADIUS_IMAGE,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.fromLTRB(16, 8, 16, 8),
    this.leading,
    this.trailing,
    this.isSender = true,
    this.color = Colors.white70,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
    this.onTap,
    this.onLongPress,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    bool stateTick = false;
    Icon? stateIcon;
    if (sent) {
      stateTick = true;
      stateIcon = const Icon(Icons.done, size: 18, color: Color(0xFF97AD8E));
    }
    if (delivered) {
      stateTick = true;
      stateIcon = const Icon(Icons.done_all, size: 18, color: Color(0xFF97AD8E));
    }
    if (seen) {
      stateTick = true;
      stateIcon = const Icon(Icons.done_all, size: 18, color: Color(0xFF92DEDA));
    }

    return Container(
      padding: padding,
      margin: margin,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .5,
        ),
        child: GestureDetector(
          onLongPress: onLongPress,
          onTap: (){
            if (onTap != null) {
              onTap!();
            } else {
              _showDetailScreen(context);
            }
          },
          child:  Hero(
            tag: id,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.width * .4,
                      ),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(bubbleRadius),
                          topRight: Radius.circular(bubbleRadius),
                          bottomLeft: Radius.circular(
                              tail ? (isSender ? bubbleRadius : 0) : BUBBLE_RADIUS_IMAGE),
                          bottomRight: Radius.circular(
                              tail ? (isSender ? 0 : bubbleRadius) : BUBBLE_RADIUS_IMAGE),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(bubbleRadius),
                          child: image,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, right: 8),
                      child: Text(
                        AppUtils.getChatTime(time ?? DateTime.now().toString()),
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ),
                  ],
                ),
                if (stateIcon != null && stateTick)
                  Positioned(
                    bottom: 10,
                    right: 6,
                    child: stateIcon,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDetailScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(
          tag: id,
          image: image,
        ),
      ),
    );
  }

// ... [Previous helper methods remain the same]
}

class DetailScreen extends StatelessWidget {
  final String tag;
  final Widget image;

  const DetailScreen({
    super.key,
    required this.tag,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.9),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        /*actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black87),
            onPressed: () {*//* Add share functionality *//*},
          ),
          IconButton(
            icon: const Icon(Icons.download, color: Colors.black87),
            onPressed: () {*//* Add download functionality *//*},
          ),
        ],*/
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          fit: StackFit.expand,
          children: [
            InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Hero(
                tag: tag,
                child: Center(child: image),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white.withOpacity(0.9),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    /*IconButton(
                      icon: const Icon(Icons.edit, color: Colors.black87),
                      onPressed: () {*//* Add edit functionality *//*},
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {*//* Add delete functionality *//*},
                    ),
                    IconButton(
                      icon: const Icon(Icons.info_outline, color: Colors.black87),
                      onPressed: () {*//* Add info functionality *//*},
                    ),*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}