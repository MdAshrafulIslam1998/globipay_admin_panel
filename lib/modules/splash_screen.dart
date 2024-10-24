import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:globipay_admin_panel/core/constants/app_images.dart';
import 'package:globipay_admin_panel/core/theme/color_palettes.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text_type.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToDashboard();
  }

  void _navigateToDashboard() async {
    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      AppRoutes.pushAndPopAll(RoutePath.dashboard);
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: ColorPalettes.colorBlueDark,  // Ensure this is defined
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.appLogo,  // Using SvgPicture directly
            height: 100,
            width: 100,
          ),
          const SizedBox(height: 20),
          const AppText(
            'Splash Screen',
            type: AppTextType.titleLarge,  // Use valid enum value from AppTextType
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}
}