import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/constants/app_edge_insets.dart';
import 'package:globipay_admin_panel/core/constants/app_images.dart';
import 'package:globipay_admin_panel/core/data/model/sidebar_menu_item.dart';
import 'package:globipay_admin_panel/core/theme/color_palettes.dart';
import 'package:globipay_admin_panel/core/widgets/sidebar/menu_item.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text_type.dart';
import 'package:go_router/go_router.dart';

class SidebarWidget extends StatelessWidget {
  final RxInt selectedIndex;
  final VoidCallback? onMenuToggle;
  final bool isExpanded;

  const SidebarWidget({
    Key? key,
    required this.selectedIndex,
    this.onMenuToggle,
    this.isExpanded = true,
  }) : super(key: key);

  static const List<SidebarMenuItem> menuItems = [
        SidebarMenuItem(
          title: 'Dashboard',
          route: '/dashboard',
          icon: Icons.home,  // Just pass Icons.home without 'icons:'
        ),
        SidebarMenuItem(
          title: 'Users',
          route: '/users',
          icon: Icons.person,  // Replace AppImages with a built-in icon if you prefer
        ),
        SidebarMenuItem(
          title: 'Transactions',
          route: '/transactions',
          icon: Icons.attach_money,  // Use another built-in icon for consistency
        ),
        // Add more menu items as needed
      ];


  @override
Widget build(BuildContext context) {
  return Container(
    width: isExpanded ? 250 : 70,
    color: ColorPalettes.blackColor,
    child: Column(
      children: [
        // Brand/Logo section
        Container(
          height: 70,
          padding: AppEdgeInsets.all16,
          child: Row(
            mainAxisAlignment: isExpanded 
              ? MainAxisAlignment.spaceBetween 
              : MainAxisAlignment.center,
            children: [
              if (isExpanded) ...[
                SvgPicture.asset(
                  AppImages.appLogo,  // Using SvgPicture to load SVG image
                  height: 30,
                  width: 30,
                ),
                const AppText(
                  'Admin Panel',
                  color: Colors.white,
                  type: AppTextType.bodyLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: onMenuToggle,
                ),
              ] else
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: onMenuToggle,
                ),
            ],
          ),
        ),

        const Divider(color: Colors.white24),

        // Menu Items
        Expanded(
          child: ListView.builder(
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              final item = menuItems[index];
              return Obx(() {
                final isSelected = selectedIndex.value == index;
                return MenuItem(
                  icon: item.icon,
                  title: item.title,
                  isSelected: isSelected,
                  isExpanded: isExpanded,
                  onTap: () {
                    selectedIndex.value = index;
                    context.go(item.route);
                  },
                );
              });
            },
          ),
        ),
      ],
    ),
  );
}
}