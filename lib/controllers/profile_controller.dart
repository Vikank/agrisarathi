import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/initial/role_screen.dart';


class ProfileController extends GetxController{

  RxString userId = ''.obs;
  void getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId.value = pref.get('userId').toString();
  }

  void logout() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('userId', "");
    Get.offAll(()=> RoleScreen());
  }

  @override
  void onInit(){
    super.onInit();
    getUserId();
  }

}