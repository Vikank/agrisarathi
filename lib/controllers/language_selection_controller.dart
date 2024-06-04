import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LanguageSelectionController extends GetxController{

  List data = [
    "English अंग्रेजी",
    "Hindi हिंदी",
    "Marathi मराठी",
    "Bhojpuri भोजपुरी",
    "Malyalam മലയാളം",
    "Punjabi ਪੰਜਾਬੀ",
    "Gujarati ગુજરાતી",
    "Bangla বাংলা",
    "Odia ଓଡିଆ",
    "Tamil தமிழ்",
    "Telgu తెలుగు",
  ];

  RxInt select = 0.obs;

  RxString langSel = ''.obs;

}