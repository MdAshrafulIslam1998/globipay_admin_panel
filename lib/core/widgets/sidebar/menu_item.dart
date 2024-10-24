import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:globipay_admin_panel/core/constants/app_edge_insets.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text_type.dart';

class MenuItem extends StatelessWidget {
  final dynamic icon;  // Can be IconData or image path
  final String title;
  final bool isSelected;
  final bool isExpanded;
  final VoidCallback onTap;

  const MenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.isExpanded,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        color: isSelected ? Colors.white.withOpacity(0.1) : null,
        padding: AppEdgeInsets.horizontal16,
        child: Row(
          children: [
            _buildMenuIcon(icon),
            if (isExpanded) ...[
              const SizedBox(width: 12),
              Expanded(
                child: AppText(
                  title,
                  color: Colors.white,
                  type: AppTextType.bodySmall,
                ),
              ),
              if (isSelected)
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMenuIcon(dynamic icon) {
    if (icon is IconData) {
      return Icon(icon, color: Colors.white);  // Handle Flutter icons
    } else if (icon is String) {
      return SvgPicture.asset(
        icon,  // Assuming it's an SVG asset path
        height: 24,
        width: 24,
      );
    } else {
      return const SizedBox.shrink();  // Fallback in case the icon is neither
    }
  }
}
