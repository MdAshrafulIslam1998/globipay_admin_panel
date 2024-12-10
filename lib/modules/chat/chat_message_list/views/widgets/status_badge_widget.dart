import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/theme/color_palettes.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text.dart';

/**
 * Created by Abdullah on 18/10/24.
 */


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
    IconData iconData;
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
      default:
        iconData = Icons.attachment;
    }

    return Icon(iconData, size: 16, color: Theme.of(context).hintColor);
  }
}