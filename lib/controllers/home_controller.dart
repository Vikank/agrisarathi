import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  RxInt currentCarousel = 0.obs;

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}