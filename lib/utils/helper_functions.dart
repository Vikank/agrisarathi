import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HelperFunctions extends GetxController{


Future<String> getUserRole() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  String userRole = pref.get('userRole').toString();
  return userRole;
}

}