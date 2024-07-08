import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

String formatDate(String? dateString) {
  if (dateString == null) return 'Unknown Date';
  try {
    final DateTime date = DateTime.parse(dateString);
    return DateFormat('d MMM').format(date);
  } catch (e) {
    print('Error parsing date: $e');
    return 'Invalid Date';
  }
}

}