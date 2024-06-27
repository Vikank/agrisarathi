import 'dart:developer';
import 'package:fpo_assist/screens/shared/language_selection.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/farmer/dashboard/farmer_home_screen.dart';

class SplashController extends GetxController {
  RxString userId = ''.obs;
  void getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId.value = pref.get('farmerId').toString();
  }

  @override
  void onInit() {
    Future.sync(() => getUserId());
    getUserId();
    Future.delayed(const Duration(seconds: 2), () {
      log("user id ${userId}");
      Get.offAll(
            () => userId.isNotEmpty && userId != "null" ? FarmerHomeScreen(): LanguageSelection(),
        transition: Transition.rightToLeft,
        duration: const Duration(seconds: 1),
      );
    });
    super.onInit();
  }


}
