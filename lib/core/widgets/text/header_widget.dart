import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/constants/app_spaces.dart';

/// Created by Abdullah on 25/8/24.

class HeaderWidget extends StatelessWidget {
  String content;

  HeaderWidget(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Column(
        children: [
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpaces.headerSpaceBetweenChild,
        ],
      ),
    );
  }
}
