import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectRoleController extends GetxController{
  setUserRole(String role)async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('userRole', role);
  }
}
