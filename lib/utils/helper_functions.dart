import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HelperFunctions{


static Future<String> getUserRole() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('userRole') ?? "";
}

static Future<int> getUserLanguage() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('selected_language') ?? 1;
}

}