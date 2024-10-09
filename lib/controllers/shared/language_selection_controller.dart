import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelectionController extends GetxController {
  RxInt langSel = 1.obs;

  void changeLanguage(var param1, var param2) async {
    SharedPreferences prefLang = await SharedPreferences.getInstance();
    var locale = Locale(param1, param2);
    Get.updateLocale(locale);
    await prefLang.setInt('selected_language', langSel.value);
  }
}
