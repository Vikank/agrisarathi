// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../screens/shared/auth/login_screen.dart';
// import '../screens/shared/auth/otp_screen.dart';
// import '../utils/api_constants.dart';
//
//
// class ForgotPasswordController extends GetxController{
//   RxBool passwordVisible = true.obs;
//   RxBool confirmPasswordVisible = true.obs;
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   RxBool loading = false.obs;
//
//   @override
//   void onInit(){
//     super.onInit();
//     passwordVisible.value = true;
//     confirmPasswordVisible.value = true;
//   }
//
//   Future<void> forgotPasswordGetOtp() async {
//     loading.value = true;
//     var headers = {'Content-Type': 'application/json'};
//     var url = Uri.parse(
//         ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.forgotPasswordGetOtp);
//     Map body = {
//       'email': emailController.text.trim(),
//     };
//
//     http.Response response =
//     await http.post(url, body: jsonEncode(body), headers: headers);
//     final json = jsonDecode(response.body);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       Get.to(OtpScreen(email: emailController.text));
//       emailController.clear();
//       Get.snackbar("Success", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
//       loading.value = false;
//     } else {
//       loading.value = false;
//       Get.snackbar("Error", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   Future<void> changePassword(String email) async {
//     loading.value = true;
//     var headers = {'Content-Type': 'application/json'};
//     var url = Uri.parse(
//         ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.changePassword);
//     Map body = {
//       "email": email,
//       "password": passwordController.text
//     };
//
//     http.Response response =
//     await http.post(url, body: jsonEncode(body), headers: headers);
//     final json = jsonDecode(response.body);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       Get.to(LoginScreen());
//       emailController.clear();
//       Get.snackbar("Success", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
//       loading.value = false;
//     } else {
//       loading.value = false;
//       Get.snackbar("Error", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
// }