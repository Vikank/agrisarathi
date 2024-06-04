import 'package:fpo_assist/screens/initial/role_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/shared/home_screen.dart';

class SplashController extends GetxController {
  RxString userId = ''.obs;
  void getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId.value = pref.get('userId').toString();
  }

  @override
  void onInit() {
    Future.sync(() => getUserId());
    getUserId();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(
            () => userId.isNotEmpty ? HomeScreen(): const RoleScreen(),
        transition: Transition.rightToLeft,
        duration: const Duration(seconds: 1),
      );
    });
    super.onInit();
  }


}
