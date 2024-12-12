import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:globipay_admin_panel/core/constants/config.dart';
import 'package:globipay_admin_panel/core/constants/defaults.dart';
import 'package:globipay_admin_panel/core/constants/ghaps.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import 'package:flutter_svg/svg.dart';
import 'menu_tile.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentRoute = GoRouterState.of(context).location;

    return Drawer(
      // width: Responsive.isMobile(context) ? double.infinity : null,
      // width: MediaQuery.of(context).size.width < 1300 ? 260 : null,
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
                      isActive: currentRoute == RoutePath.dashboard,
                      title: "Dashboard",
                      activeIconSrc: "assets/icons/bulb_filled.svg",
                      inactiveIconSrc: "assets/icons/bulb_light.svg",
                      onPressed: () {
                        context.go(RoutePath.dashboard);
                      },
                    ),
                    // Users Section with ExpansionTile
                    Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        leading: const Icon(
                          CupertinoIcons.person_2,
                          color: AppColors.iconBlack,
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
                            isActive: currentRoute == RoutePath.activeUsersNew,
                            title: "Active Users",
                            activeIconSrc: "assets/icons/fire_filled.svg",
                            inactiveIconSrc: "assets/icons/fire_light.svg",
                            count: 16,
                            onPressed: () {
                              context.go(RoutePath.activeUsersNew);
                            },
                          ),
                          MenuTile(
                            isSubmenu: false,
                            isActive: currentRoute == RoutePath.pendingUsers,
                            title: "Pending Users",
                            activeIconSrc: "assets/icons/fire_filled.svg",
                            inactiveIconSrc: "assets/icons/fire_light.svg",
                            count: 16,
                            onPressed: () {
                              context.go(RoutePath.pendingUsers);
                            },
                          ),

                          MenuTile(
                            isSubmenu: false,
                            isActive: currentRoute == RoutePath.blockedUsers,
                            title: "Blocked Users",
                            activeIconSrc: "assets/icons/fire_filled.svg",
                            inactiveIconSrc: "assets/icons/fire_light.svg",
                            count: 16,
                            onPressed: () {
                              context.go(RoutePath.blockedUsers);
                            },
                          ),
                          MenuTile(
                            isSubmenu: false,
                            isActive: currentRoute == RoutePath.userLevels,
                            title: "Users Levels",
                            activeIconSrc: "assets/icons/fire_filled.svg",
                            inactiveIconSrc: "assets/icons/fire_light.svg",
                            count: 16,
                            onPressed: () {
                              context.go(RoutePath.userLevels);
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
                        leading: const Icon(
                          CupertinoIcons.chat_bubble_text,
                          color: AppColors.iconBlack,
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
                            isActive: currentRoute == RoutePath.activeUsersNew,
                            title: "Chat List",
                            leading: Icon(
                              CupertinoIcons.chat_bubble_2,
                              color: AppColors.iconBlack,
                            ),

                            count: 16,
                            onPressed: () {
                              AppRoutes.pushNamed(RoutePath.chatMessageList);
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
                          'assets/icons/bulb_filled.svg',
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
                            isActive: currentRoute == RoutePath.userAmount,
                            title: "User Amount",
                            activeIconSrc: "assets/icons/fire_filled.svg",
                            inactiveIconSrc: "assets/icons/fire_light.svg",
                            count: 16,
                            onPressed: () {
                              context.go(RoutePath.userAmount);
                            },
                          ),
                          MenuTile(
                            isSubmenu: false,
                            isActive: currentRoute == RoutePath.transHistory,
                            title: "Transaction History",
                            activeIconSrc: "assets/icons/fire_filled.svg",
                            inactiveIconSrc: "assets/icons/fire_light.svg",
                            count: 16,
                            onPressed: () {
                              context.go(RoutePath.transHistory);
                            },
                          ),
                          MenuTile(
                            isSubmenu: false,
                            isActive: currentRoute == RoutePath.createCategory,
                            title: "Create Category",
                            activeIconSrc: "assets/icons/fire_filled.svg",
                            inactiveIconSrc: "assets/icons/fire_light.svg",
                            count: 16,
                            onPressed: () {
                              context.go(RoutePath.createCategory);
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
                          'assets/icons/bulb_filled.svg',
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
                            isActive:
                                currentRoute == RoutePath.notificationSetter,
                            title: "Notification Setter",
                            activeIconSrc: "assets/icons/fire_filled.svg",
                            inactiveIconSrc: "assets/icons/fire_light.svg",
                            count: 16,
                            onPressed: () {
                              context.go(RoutePath.notificationSetter);
                            },
                          ),
                          MenuTile(
                            isSubmenu: false,
                            isActive: currentRoute == RoutePath.promoBanner,
                            title: "Promotional Banner",
                            activeIconSrc: "assets/icons/fire_filled.svg",
                            inactiveIconSrc: "assets/icons/fire_light.svg",
                            count: 16,
                            onPressed: () {
                              context.go(RoutePath.promoBanner);
                            },
                          ),
                          MenuTile(
                            isSubmenu: false,
                            isActive: currentRoute == RoutePath.automatedReply,
                            title: "Automated Reply",
                            activeIconSrc: "assets/icons/fire_filled.svg",
                            inactiveIconSrc: "assets/icons/fire_light.svg",
                            count: 16,
                            onPressed: () {
                              context.go(RoutePath.automatedReply);
                            },
                          ),
                          MenuTile(
                            isSubmenu: false,
                            isActive: currentRoute == RoutePath.aboutUs,
                            title: "About Us",
                            activeIconSrc: "assets/icons/fire_filled.svg",
                            inactiveIconSrc: "assets/icons/fire_light.svg",
                            count: 16,
                            onPressed: () {
                              context.go(RoutePath.aboutUs);
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
                          'assets/icons/bulb_filled.svg',
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
                          // MenuTile(
                          //   isSubmenu: false,
                          //   isActive: currentRoute == RoutePath.editCoin,
                          //   title: "Edit Coin",
                          //   activeIconSrc: "assets/icons/fire_filled.svg",
                          //   inactiveIconSrc: "assets/icons/fire_light.svg",
                          //   count: 16,
                          //   onPressed: () {
                          //     context.go(RoutePath.editCoin);
                          //   },
                          // ),
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
                      SvgPicture.asset(
                        'assets/icons/help_light.svg',
                        height: 24,
                        width: 24,
                        colorFilter: const ColorFilter.mode(
                          AppColors.textLight,
                          BlendMode.srcIn,
                        ),
                      ),
                      gapW8,
                      Text(
                        'Help & getting started',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Chip(
                        backgroundColor: AppColors.secondaryLavender,
                        side: BorderSide.none,
                        padding: const EdgeInsets.symmetric(horizontal: 0.5),
                        label: Text(
                          "8",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  gapH20,
                  //const ThemeTabs(),
                  gapH8,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
