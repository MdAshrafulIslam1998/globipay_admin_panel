
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/constants/defaults.dart';
import 'package:globipay_admin_panel/core/constants/ghaps.dart';
import 'package:globipay_admin_panel/core/theme/app_colors.dart';
import 'package:globipay_admin_panel/core/widgets/avatar/customer_rounded_avatar.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({
    super.key,
    required this.name,
    required this.designation,
    required this.imageSrc,
  });

  final String name, designation, imageSrc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding * 0.75),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(
          AppDefaults.borderRadius * 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 2,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Row(
        children: [
          CustomerRoundedAvatar(
            height: 48,
            width: 48,
            imageSrc: imageSrc,
            radius: AppDefaults.borderRadius * 10,
          ),
          gapW16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  designation,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          gapW16,
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}