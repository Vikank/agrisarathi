import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import '../../models/service_provider_model.dart';
import '../../utils/api_constants.dart';
import 'package:http/http.dart' as http;

import '../../utils/helper_functions.dart';


class ServiceProviderController extends GetxController{

  RxBool loading = true.obs;
  var serviceProviderModel = ServiceProviderModel().obs;
  int? userLanguage;

  @override
  void onInit(){
    getUserLanguage().then((value){
      getService();
    });
    // getService();
    super.onInit();
  }


  Future<int?> getUserLanguage() async {
    userLanguage = await HelperFunctions.getUserLanguage();
    return userLanguage;
  }

  void getService() async {
    loading.value = true;
    var response = await http.get(
      Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.getServiceProviderList+'?user_language=1'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      log("heyyyyyy${response.body}");
      var data = json.decode(response.body);
      serviceProviderModel.value = ServiceProviderModel.fromJson(data);
      loading.value = false;
    } else {
      Fluttertoast.showToast(
          msg: "Failed to fetch data. Please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      loading.value = false;
    }
  }


}