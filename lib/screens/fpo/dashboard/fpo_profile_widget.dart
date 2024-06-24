import 'package:flutter/material.dart';
import 'package:fpo_assist/screens/initial/role_screen.dart';
import 'package:get/get.dart';

import '../../../controllers/profile_controller.dart';

class ProfileWidget extends StatelessWidget {

  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: (){
          profileController.logout();
        },
          child: Text('Profile Logout')),
    );
  }
}