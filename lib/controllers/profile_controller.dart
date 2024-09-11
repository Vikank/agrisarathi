import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/initial/role_screen.dart';
import 'farmer/dashboard_controller.dart';


class ProfileController extends GetxController{

  RxString userId = ''.obs;
  final storage = FlutterSecureStorage();

  void logout() async{
    await storage.delete(key: 'access_token');
    Get.find<FarmerDashboardController>().clearData();
    Get.delete<FarmerDashboardController>();
    Get.offAll(()=> RoleScreen());
  }

  @override
  void onInit(){
    super.onInit();
  }

}