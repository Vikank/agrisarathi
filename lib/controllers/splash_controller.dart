import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/screens/shared/language_selection.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/farmer/dashboard/farmer_home_screen.dart';

class SplashController extends GetxController {
  final storage = FlutterSecureStorage();
  String? accessToken;
  void getUserId() async {
    accessToken = await storage.read(key: 'access_token');
  }

  @override
  void onInit() {
    Future.sync(() => getUserId());
    getUserId();
    Future.delayed(const Duration(seconds: 2), () {
      log("user id ${accessToken}");
      Get.offAll(
            () => accessToken != null ? FarmerHomeScreen(): LanguageSelection(),
        transition: Transition.rightToLeft,
        duration: const Duration(seconds: 1),
      );
    });
    super.onInit();
  }


}
