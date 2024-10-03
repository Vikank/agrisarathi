import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../models/profile_model.dart';
import '../../screens/initial/role_screen.dart';
import 'dashboard_controller.dart';

class FarmerProfileController extends GetxController {
  final storage = const FlutterSecureStorage();
  var isLoading = true.obs;
  var farmerProfile = FarmerProfile().obs;
  Rx<File?> image = Rx<File?>(null);
  RxBool isSubmitting = false.obs;
  RxString error = ''.obs;
  RxBool success = false.obs;
  final nameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      submitTask();
    }
  }

  // Fetch Profile API
  Future<void> fetchProfile() async {
    final String apiUrl = "${ApiEndPoints.baseUrlTest}GetFarmProfileDetails";

    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }
      log("token is $accessToken");
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      isLoading(true);
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        farmerProfile.value = FarmerProfile.fromJson(data);
      } else {
        Get.snackbar("Error", "Failed to load profile data");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> submitTask() async {
    if (image.value == null) {
      error.value = 'Please select an image';
      return;
    }

    isSubmitting.value = true;
    error.value = '';
    success.value = false;

    try {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('${ApiEndPoints.baseUrlTest}UpdateFarmerProfilePicture'),
      );
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }
      request.headers['Authorization'] = 'Bearer $accessToken';

      var pic = await http.MultipartFile.fromPath('profile', image.value!.path);
      request.files.add(pic);

      var response = await request.send();
      log("heyyyyy${response.statusCode.toString()}");
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var decodedResponse = json.decode(responseBody);
        log("heyyyyy data aaya${decodedResponse.toString()}");
        success.value = true;
        fetchProfile();
        update();
      } else {
        error.value = 'Failed to update profile. Please try again.';
      }
    } catch (e) {
      error.value = 'An error occurred. Please try again.';
    } finally {
      isSubmitting.value = false;
    }
  }

  // Function to update the name
  Future<void> updateName() async {
    final url = Uri.parse('${ApiEndPoints.baseUrlTest}FarmerDetailsGetUpdate');

    // Request body
    Map<String, dynamic> requestBody = {
      "name": nameController.text, // User's updated name
    };

    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken'
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        fetchProfile();
        Get.back();
      } else {
        Get.snackbar("Error", "Failed to update name",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      // Handle exception
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  // Function to update the language
  Future<void> updateLanguage(int fkLanguageId) async {
    final url = Uri.parse('${ApiEndPoints.baseUrlTest}FarmerDetailsGetUpdate');
    log("language updating $fkLanguageId");
    // Request body
    Map<String, dynamic> requestBody = {
      "fk_language_id": fkLanguageId, // Pass the selected language ID
    };

    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken'
        },
        body: json.encode(requestBody),
      );
      log("response ${response.body.toString()}");
      if (response.statusCode == 200) {
        fetchProfile();
      } else {
        Fluttertoast.showToast(
                  msg: "Failed to update language",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to update language $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void logout() async {
    await storage.delete(key: 'access_token');
    Get.find<FarmerDashboardController>().clearData();
    Get.delete<FarmerDashboardController>();
    Get.offAll(() => RoleScreen());
  }
}
