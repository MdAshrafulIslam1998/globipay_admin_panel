import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/profile_screen.dart';
import 'pending_profile_screen_builder.dart';

class PendingProfileScreen extends StatelessWidget {
     UserResponseItemEntity? user;
     PendingProfileScreen({Key? key, this.user}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return ProfileScreen(user: user);
    }
}
