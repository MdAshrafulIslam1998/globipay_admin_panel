import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:globipay_admin_panel/core/constants/defaults.dart';
import 'package:globipay_admin_panel/core/constants/ghaps.dart';
import 'package:globipay_admin_panel/core/theme/app_colors.dart';
import 'package:globipay_admin_panel/core/utils/responsive.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';
import 'package:go_router/go_router.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDefaults.padding, vertical: AppDefaults.padding),
      color: AppColors.bgSecondayLight,
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextFormField(
                // style: Theme.of(context).textTheme.labelLarge,
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                        left: AppDefaults.padding,
                        right: AppDefaults.padding / 2),
                    child: SvgPicture.asset("assets/icons/search_light.svg"),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  border: AppDefaults.outlineInputBorder,
                  focusedBorder: AppDefaults.focusedOutlineInputBorder,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!Responsive.isMobile(context))
                    IconButton(
                      onPressed: () {
                        AppRoutes.pushNamed(RoutePath.chatMessageList);
                      },
                      icon: Badge(
                        isLabelVisible: true,
                        child:
                            SvgPicture.asset("assets/icons/message_light.svg"),
                      ),
                    ),
                  if (!Responsive.isMobile(context)) gapW16,
                  if (!Responsive.isMobile(context))
                    IconButton(
                      onPressed: () {
                        AppRoutes.pushNamed(RoutePath.notificationSetter);

                      },
                      icon: Badge(
                        isLabelVisible: true,
                        child: SvgPicture.asset(
                            "assets/icons/notification_light.svg"),
                      ),
                    ),
                  gapW16,

                  IconButton(
                    color: Colors.purple,
                    onPressed: () {
                     onLogout();
                    },
                    icon: const Icon(Icons.logout),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  void onLogout(){
    AppRoutes.pushNamed(RoutePath.login);
   
  }
}
