import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../utils/helper_functions.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  String userRole = '';
  RxInt currentCarousel = 0.obs;

  @override
  void onInit(){
    super.onInit();
    getUserRole();
  }

  void getUserRole() async{
    userRole = await HelperFunctions.getUserRole();
    log("UserRole $userRole");
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}