import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import '../../models/service_provider_model.dart';
import '../../utils/api_constants.dart';
import 'package:http/http.dart' as http;


class ServiceProviderController extends GetxController{

  RxInt serviceId = 0.obs;
  RxBool loading = true.obs;
  var serviceProviderModel = ServiceProviderModel().obs;

  @override
  void onInit(){
    getService();
    super.onInit();
  }

  void getService() async {
    loading.value = true;
    var response = await http.post(
      Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.getServiceProviderList),
      body: jsonEncode({"user_language": "1"}),
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