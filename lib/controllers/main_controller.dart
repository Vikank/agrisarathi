import 'dart:developer';

import 'package:get/get.dart';

import '../utils/helper_functions.dart';

class MainController extends GetxController{
  int? userLanguage;

  @override
  void onInit() {
    super.onInit();
    getUserLanguage();
  }

  Future<int?> getUserLanguage() async {
    userLanguage = await HelperFunctions.getUserLanguage();
    log("UserRole $userLanguage");
    return userLanguage;
  }
}