import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/core/constants/app_constant.dart';
import 'package:globipay_admin_panel/core/constants/config.dart';
import 'package:globipay_admin_panel/core/constants/defaults.dart';
import 'package:globipay_admin_panel/core/constants/ghaps.dart';
import 'package:globipay_admin_panel/core/di/injector.dart';
import 'package:globipay_admin_panel/core/services/navigator/app_navigator_service.dart';
import 'package:globipay_admin_panel/core/widgets/app_print.dart';
import 'package:globipay_admin_panel/core/widgets/sidemenu/side_menu_controller.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import 'package:flutter_svg/svg.dart';
import 'menu_tile.dart';

class Sidebar extends StatelessWidget {
  late BuildContext cx;
  @override
  Widget build(BuildContext context) {
    cx = context;

    return Drawer(
      // width: Responsive.isMobile(context) ? double.infinity : null,
      // width: MediaQuery.of(context).size.width < 1300 ? 260 : null,
      backgroundColor: Color(0xFFF4F7FF),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDefaults.padding,
                    vertical: AppDefaults.padding * 1.5,
                  ),
                  child: SvgPicture.asset(AppConfig.logo),
                ),
                const Spacer(),
              ],
            ),
            const Divider(),
            gapH16,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDefaults.padding,
                ),
                child: ListView(
                  children: [
                    MenuTile(
                      isActive: AppConstants.currentPath == RoutePath.dashboard,
                      title: "Dashboard",
                      // activeIconSrc: "assets/icons/bulb_filled.svg",
                      activeIconSrc: "assets/icons/ash_home_filled.svg",
                      inactiveIconSrc: "assets/icons/ash_home_light.svg",
                      onPressed: () {
                        navigate(RoutePath.dashboard);
                      },
                    ),
                    // Users Section with ExpansionTile
                    Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        leading: SvgPicture.asset(
                          'assets/icons/ash_usermain_filled.svg',
                          height: 24,
                          width: 24,
                          colorFilter: const ColorFilter.mode(
                            AppColors.iconBlack,
                            BlendMode.srcIn,
                          ),
                        ),

                        title: Text(
                          "Users",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                        children: [
                          MenuTile(
                            isSubmenu: false,
                            isActive: AppConstants.currentPath ==
                                RoutePath.activeUsersNew,
                            title: "Active Users",
                            activeIconSrc:
                                "assets/icons/ash_activeuser_filled.svg",
                            inactiveIconSrc:
                                "assets/icons/ash_activeuser_light.svg",
                            onPressed: () {
                              navigate(RoutePath.activeUsersNew);
                            },
                          ),
                          MenuTile(
                            isSubmenu: false,
                            isActive: AppConstants.currentPath ==
                                RoutePath.pendingUsers,
                            title: "Pending Users",
                            activeIconSrc:
                                "assets/icons/ash_pendinguser_filled.svg",
                            inactiveIconSrc:
                                "assets/icons/ash_pendinguser_light.svg",
                            onPressed: () {
                              navigate(RoutePath.pendingUsers);
                            },
                          ),
                          MenuTile(
                            isSubmenu: false,
                            isActive: AppConstants.currentPath ==
                                RoutePath.blockedUsers,
                            title: "Inactive Users",
                            activeIconSrc:
                                "assets/icons/ash_inactiveuser_filled.svg",
                            inactiveIconSrc:
                                "assets/icons/ash_inactiveuser_light.svg",
                            onPressed: () {
                              navigate(RoutePath.blockedUsers);
                            },
                          ),
                          MenuTile(
                            isSubmenu: false,
                            isActive: AppConstants.currentPath ==
                                RoutePath.userLevels,
                            title: "User Levels",
                            activeIconSrc:
                                "assets/icons/ash_userlevel_filled.svg",
                            inactiveIconSrc:
                                "assets/icons/ash_userlevel_light.svg",
                            onPressed: () {
                              navigate(RoutePath.userLevels);
                            },
                          ),
                        ],
                      ),
                    ),

                    // Chat Sections
                    Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        leading: SvgPicture.asset(
                          'assets/icons/ash_chatmain_filled.svg',
                          height: 24,
                          width: 24,
                          colorFilter: const ColorFilter.mode(
                            AppColors.iconBlack,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: Text(
                          "Chat",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                        children: [
                          MenuTile(
                            isSubmenu: false,
                            isActive: AppConstants.currentPath ==
                                RoutePath.chatMessageList,
                            title: "Chat List",
                            activeIconSrc:
                                "assets/icons/ash_chatlist_filled.svg", // Add icons if needed
                            inactiveIconSrc:
                                "assets/icons/ash_chatlist_light.svg",
                            onPressed: () {
                              navigate(RoutePath.chatMessageList);
                            },
                          ),
                        ],
                      ),
                    ),

                    // Amount Section with ExpansionTile
                    Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        leading: SvgPicture.asset(
                          'assets/icons/ash_amountmain_filled.svg',
                          height: 24,
                          width: 24,
                          colorFilter: const ColorFilter.mode(
                            AppColors.iconBlack,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: Text(
                          "Amount",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                        children: [
                          MenuTile(
                            isSubmenu: false,
                            isActive: AppConstants.currentPath ==
                                RoutePath.userAmount,
                            title: "User Amount",
                            activeIconSrc:
                                "assets/icons/ash_useramount_filled.svg",
                            inactiveIconSrc:
                                "assets/icons/ash_useramount_light.svg",
                            onPressed: () {
                              navigate(RoutePath.userAmount);
                            },
                          ),
                          MenuTile(
                            isSubmenu: false,
                            isActive: AppConstants.currentPath ==
                                RoutePath.transHistory,
                            title: "Transaction History",
                            activeIconSrc:
                                "assets/icons/ash_transaction_filled.svg",
                            inactiveIconSrc:
                                "assets/icons/ash_transaction_light.svg",
                            onPressed: () {
                              navigate(RoutePath.transHistory);
                            },
                          ),
                          MenuTile(
                            isSubmenu: false,
                            isActive: AppConstants.currentPath ==
                                RoutePath.createCategory,
                            title: "Create Category",
                            activeIconSrc:
                                "assets/icons/ash_addcategory_filled.svg",
                            inactiveIconSrc:
                                "assets/icons/ash_addcategory_light.svg",
                            onPressed: () {
                              navigate(RoutePath.createCategory);
                            },
                          ),
                        ],
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        leading: SvgPicture.asset(
                          'assets/icons/ash_media_filled.svg',
                          height: 24,
                          width: 24,
                          colorFilter: const ColorFilter.mode(
                            AppColors.iconBlack,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: Text(
                          "Media",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                        children: [
                          MenuTile(
                            isSubmenu: false,
                            isActive: AppConstants.currentPath ==
                                RoutePath.notificationSetter,
                            title: "Notification Setter",
                            activeIconSrc:
                                "assets/icons/ash_notification_filled.svg",
                            inactiveIconSrc:
                                "assets/icons/ash_notification_light.svg",
                            onPressed: () {
                              navigate(RoutePath.notificationSetter);
                            },
                          ),
                          MenuTile(
                            isSubmenu: false,
                            isActive: AppConstants.currentPath ==
                                RoutePath.promoBanner,
                            title: "Promotional Banner",
                            activeIconSrc: "assets/icons/ash_ad_filled.svg",
                            inactiveIconSrc: "assets/icons/ash_ad_light.svg",
                            onPressed: () {
                              navigate(RoutePath.promoBanner);
                            },
                          ),
                          MenuTile(
                            isSubmenu: false,
                            isActive: AppConstants.currentPath ==
                                RoutePath.messageTemplates,
                            title: "Message Templates",
                            activeIconSrc:
                                "assets/icons/ash_textadd_filled.svg",
                            inactiveIconSrc:
                                "assets/icons/ash_textadd_light.svg",
                            count: 6,
                            onPressed: () {
                              navigate(RoutePath.messageTemplates);
                            },
                          ),
                          MenuTile(
                            isSubmenu: false,
                            isActive:
                                AppConstants.currentPath == RoutePath.misc,
                            title: "Miscellaneous",
                            activeIconSrc: "assets/icons/ash_other_filled.svg",
                            inactiveIconSrc: "assets/icons/ash_other_light.svg",
                            onPressed: () {
                              navigate(RoutePath.misc);
                            },
                          ),
                        ],
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        leading: SvgPicture.asset(
                          'assets/icons/ash_admin_filled.svg',
                          height: 24,
                          width: 24,
                          colorFilter: const ColorFilter.mode(
                            AppColors.iconBlack,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: Text(
                          "Staff",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                        children: [
                          MenuTile(
                            isSubmenu: false,
                            isActive: AppConstants.currentPath ==
                                RoutePath.staffSection,
                            title: "Staff Section",
                            activeIconSrc: "assets/icons/ash_staff_filled.svg",
                            inactiveIconSrc: "assets/icons/ash_staff_light.svg",
                            onPressed: () {
                              navigate(RoutePath.staffSection);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Column(
                children: [
                  gapH8,
                  const Divider(),
                  gapH8,
                  Row(
                    children: [
                      Icon(
                        Icons.bolt,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                      gapW8,
                      Text(
                        'Globi Pay Admin',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                    ],
                  ),
                  gapH8,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigate(String routePath) {
    if (AppConstants.currentPath != routePath) {
      AppConstants.currentPath = routePath;
      cx.go(routePath);
    }
  }
}
