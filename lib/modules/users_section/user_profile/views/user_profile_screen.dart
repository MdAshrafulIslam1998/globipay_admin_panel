import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/profile_screen.dart';

/**
 * Created by Abdullah on 18/1/25.
 */

class UserProfileScreen extends StatelessWidget {
  final UserResponseItemEntity? user;
  const UserProfileScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(user: user,);
  }
}
