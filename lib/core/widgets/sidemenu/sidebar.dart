
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:globipay_admin_panel/core/constants/config.dart';
import 'package:globipay_admin_panel/core/constants/defaults.dart';
import 'package:globipay_admin_panel/core/constants/ghaps.dart';
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
                      activeIconSrc: "assets/icons/home_filled.svg",
                      inactiveIconSrc: "assets/icons/home_light.svg",
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
                        leading:
                          SvgPicture.asset(
                        'assets/icons/profile_circled_filled.svg',
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
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ),
                      children: [
                        MenuTile(
                          isSubmenu: false,
                          isActive: currentRoute == RoutePath.activeUsers,
                          title: "Active Users",
                          activeIconSrc: "assets/icons/person_check_filled.svg",
                          inactiveIconSrc: "assets/icons/person_check_light.svg",
                          count: 16,
                          onPressed: () {
                            context.go(RoutePath.activeUsers);
                          },
                        ),
                        MenuTile(
                          isSubmenu: false,
                          isActive: currentRoute == RoutePath.activeUsersNew,
                          title: "Active Users New",
                          activeIconSrc: "assets/icons/alarm_filled.svg",
                          inactiveIconSrc: "assets/icons/alarm_light.svg",
                          count: 16,
                          onPressed: () {
                            context.go(RoutePath.activeUsersNew);
                          },
                        ),
                        MenuTile(
                          isSubmenu: false,
                          isActive: currentRoute == RoutePath.editCoin,
                          title: "Edit Coins",
                          activeIconSrc: "assets/icons/edit_coin_filled.svg",
                          inactiveIconSrc: "assets/icons/edit_coin_light.svg",
                          count: 16,
                          onPressed: () {
                            context.go(RoutePath.editCoin);
                          },
                        ),
                        MenuTile(
                          isSubmenu: false,
                          isActive: currentRoute == RoutePath.pendingProfile,
                          title: "Pending Profile",
                          activeIconSrc: "assets/icons/android_filled.svg",
                          inactiveIconSrc: "assets/icons/android_light.svg",
                          count: 16,
                          onPressed: () {
                            context.go(RoutePath.pendingProfile);
                          },
                        ),
                         MenuTile(
                          isSubmenu: false,
                          isActive: currentRoute == RoutePath.notificationSetter,
                          title: "Notification Setter",
                          activeIconSrc: "assets/icons/apple_filled.svg",
                          inactiveIconSrc: "assets/icons/apple_light.svg",
                          count: 16,
                          onPressed: () {
                            context.go(RoutePath.notificationSetter);
                          },
                        ),
                      ],
                      )
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
