import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/service_provider_model.dart';
import '../models/user_crop_model.dart';

class ServiceProviderController extends GetxController{


  ServiceProviderModel serviceProviderModel = ServiceProviderModel();
  UserCropModel userCropModel = UserCropModel();

  void userCropData(serId) async {
    Map<String, dynamic> request = {
      'user_id': "11",
    };
    print("data request filter ka $request");
    var response = await http.post(
      Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.getUserCrops),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(request),
    );
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      userCropModel = UserCropModel.fromJson(data);
      print('user crop data $data');
    } else {
      Fluttertoast.showToast(
          msg: "Failed to fetch data. Please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }


  void getService() async {
    var response = await http.get(
      Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.getServiceProviderList),
    );
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
        serviceProviderModel = ServiceProviderModel.fromJson(data);
    } else {
      Fluttertoast.showToast(
          msg: "Failed to fetch data. Please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

}