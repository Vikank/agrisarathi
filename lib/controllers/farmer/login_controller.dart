import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/screens/shared/select_crop_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../screens/farmer/dashboard/farmer_home_screen.dart';
import '../../screens/fpo/auth/login_screen.dart';
import '../../utils/api_constants.dart';
import '../../utils/helper_functions.dart';

class AuthController extends GetxController {
  final storage = FlutterSecureStorage();
  final RxBool isLoggedIn = false.obs;
  final RxBool isLoading = false.obs;
  final RxInt resendDelay = 60.obs;
  final RxBool userExist = false.obs;
  final RxBool isLand = false.obs;
  int? userLanguage;

  @override
  void onInit(){
    getUserLanguage();
    super.onInit();
  }

  void startResendTimer() {
    resendDelay.value = 60;
    ever(resendDelay, (_) {
      if (resendDelay.value <= 0) {
        resendDelay.value = 0;
      } else {
        Future.delayed(const Duration(seconds: 1), () => resendDelay.value--);
      }
    });
  }

  void getUserLanguage() async {
    userLanguage = await HelperFunctions.getUserLanguage();
    log("userLanguage $userLanguage");
  }

  void resetResendTimer() {
    resendDelay.value = 60;
    startResendTimer();
  }

  Future<Map<String, dynamic>> sendLoginOTP({required String phone}) async {
    isLoading.value = true;
    try {
      final Map<String, dynamic> body = {
        "user_type": "farmer",
        "login_type": "mobile",
        "mobile": phone,
      };
      log("log aaya ${body}");
      final response = await http.post(
        Uri.parse(
            ApiEndPoints.baseUrlTest + ApiEndPoints.authEndpoints.farmerLogin),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      log("log aaya ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return {
          'success': true,
          'message': responseData['message'],
          'otp': responseData['otp'],
        };
      } else {
        throw Exception('Failed to send OTP');
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error occurred: ${e.toString()}',
      };
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOTP({required String phone, required String otp}) async {
    isLoading.value = true;
    try {
      final Map<String, dynamic> body = {
        "user_type": "farmer",
        "login_type": "mobile",
        "mobile": int.parse(phone),
        "otp": int.parse(otp),
        "user_language": userLanguage,
      };
      log("otp entered ${body}");
      final response = await http.post(
        Uri.parse(
            ApiEndPoints.baseUrlTest + ApiEndPoints.authEndpoints.verifyOTP),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      log("response status ${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        log("response data is ${responseData}");
        if (responseData['is_authenticated']) {
          await _saveTokens(responseData['tokens']['access'],
              responseData['tokens']['refresh']);
          isLoggedIn.value = true;
          userExist.value = responseData['is_existing_user'];
          isLand.value = responseData['is_land'];
          log("user exist ki value ${userExist.value}");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (userExist.value && isLand.value) {
            await prefs.setBool('userExist', true);
            Get.offAll(() => FarmerHomeScreen());
          } else {
            Get.to(() => SelectCropScreen());
          }
        } else {
          Get.snackbar("Error", "OTP verification failed");
        }
      } else {
        throw Exception('Failed to verify OTP');
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    await storage.write(key: 'access_token', value: accessToken);
    await storage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<void> logout() async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');
    isLoggedIn.value = false;
    Get.offAll(() => LoginScreen());
  }
}
