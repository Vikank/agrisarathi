import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import '../../models/service_provider_model.dart';
import '../../utils/api_constants.dart';
import 'package:http/http.dart' as http;

import '../../utils/helper_functions.dart';


class ServiceProviderController extends GetxController{
  final storage = FlutterSecureStorage();
  RxBool loading = true.obs;
  var serviceProviderModel = ServiceProviderModel().obs;
  int? userLanguage;

  @override
  void onInit(){
    getUserLanguage().then((value){
      getService();
    });
    super.onInit();
  }


  Future<int?> getUserLanguage() async {
    userLanguage = await HelperFunctions.getUserLanguage();
    return userLanguage;
  }

  void getService() async {
    loading.value = true;
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
    };
    var response = await http.get(
      Uri.parse("${ApiEndPoints.baseUrlTest}${ApiEndPoints.getServiceProviderList}?user_language=$userLanguage"),
      headers: headers,
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