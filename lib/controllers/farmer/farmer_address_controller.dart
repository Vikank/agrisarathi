import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/helper_functions.dart';


class FarmerAddressController extends GetxController{

  final addressLine = TextEditingController();
  final pinCode = TextEditingController();
  final state = TextEditingController();
  final district = TextEditingController();
  final subDistrict = TextEditingController();
  final village = TextEditingController();


  @override
  void onInit(){
    super.onInit();
    getFarmerId();
    getUserLanguage();
  }

  getFarmerId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    farmerId = (prefs.getString('farmerId')??'');
    log("fpo id is $farmerId");
  }

  void getUserLanguage() async{
    userLanguage = await HelperFunctions.getUserLanguage();
    log("UserRole $userLanguage");
  }


}