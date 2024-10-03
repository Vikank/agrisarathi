import 'package:flutter/material.dart';
import 'package:fpo_assist/screens/initial/role_screen.dart';
import 'package:get/get.dart';


class ProfileWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: (){
          // profileController.logout();
        },
          child: Text('Profile Logout')),
    );
  }
}