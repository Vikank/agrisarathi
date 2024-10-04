import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpo_assist/screens/shared/select_crop_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../utils/api_constants.dart';


class FpoLoginController extends GetxController{
  RxBool passwordVisible = true.obs;
  RxBool loading = false.obs;
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit(){
    super.onInit();
    passwordVisible.value = true;
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    loading.value = true;
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(
        ApiEndPoints.baseUrlTest + ApiEndPoints.authEndpoints.loginEmail);
    Map body = {
      'mobile_no': phoneController.text,
      'password': passwordController.text,
    };
    log("${body.toString()}");
    http.Response response =
    await http.post(url, body: jsonEncode(body), headers: headers);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var fpoId = json['fpo_id'];
      var coins = json['coins'];
      final SharedPreferences prefs = await _prefs;
      await prefs.setString('fpoId', fpoId.toString());
      await prefs.setString('mobile_no', phoneController.text);
      await prefs.setString('coins', coins.toString());
      phoneController.clear();
      passwordController.clear();
      Get.to(SelectCropScreen());
      Get.snackbar("Success", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
      loading.value = false;
    } else {
      loading.value = false;
      Get.snackbar("Error", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

}