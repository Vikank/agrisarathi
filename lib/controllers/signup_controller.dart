import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../screens/shared/auth/login_screen.dart';
import '../utils/api_constants.dart';


class SignupController extends GetxController{
  RxBool passwordVisible = true.obs;
  RxBool confirmPasswordVisible = true.obs;
  RxBool loading = false.obs;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void onInit(){
    super.onInit();
    passwordVisible.value = true;
    confirmPasswordVisible.value = true;
  }

  Future<void> registerWithEmail() async {
    loading.value = true;
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.registerEmail);
      Map body = {
        'name': nameController.text,
        // 'email': emailController.text.trim(),
        'password': passwordController.text,
        'mobile_no': phoneController.text
      };

      http.Response response =
      await http.post(url, body: jsonEncode(body), headers: headers);
    final json = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
          nameController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          phoneController.clear();
          Get.off(LoginScreen());
          Get.snackbar("Success", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
          loading.value = false;
      } else {
        loading.value = false;
        Get.snackbar("Error", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
      }
    }
  }