import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/models/select_crop_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/farmer/dashboard/farmer_home_screen.dart';
import '../../utils/api_constants.dart';
import '../../utils/helper_functions.dart';


class FarmerUpdateProfileController extends GetxController{
  final storage = FlutterSecureStorage();
  RxBool loading = false.obs;
  final fpoName = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  String? farmerId;
  RxBool fpoNameExist = false.obs;
  int? userLanguage;

  @override
  void onInit(){
    super.onInit();
    getUserLanguage();
    fetchFarmerFpoName();
  }

  Future<int?> getUserLanguage() async {
    userLanguage = await HelperFunctions.getUserLanguage();
    log("UserRole $userLanguage");
    return userLanguage;
  }

  List<int> getSelectedCropIds(RxList<Crop> selectedCrops) {
    return selectedCrops.map((crop) => crop.id).toList();
  }

  Future<void> fetchFarmerFpoName() async {
    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
      };
      var response = await http.get(
        Uri.parse('${ApiEndPoints.baseUrlTest}${ApiEndPoints.authEndpoints.getFarmerFpoName}'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if(data['Fpo Name'] != null){
          fpoName.text = data['Fpo Name'];
          fpoNameExist.value = true;
        } else{
          fpoName.text = '';
          fpoNameExist.value = false;
        }
      } else {
        print('Failed to fetch fpo name: ${response.statusCode}');
        fpoNameExist.value = false;
      }
    } catch (e) {
      print('Error fetching fpo name: $e');
      fpoNameExist.value = false;
    }
  }

  Future<void> updateFarmerDetail() async {
    loading.value = true;
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
    };
    var url = Uri.parse(
        ApiEndPoints.baseUrlTest + ApiEndPoints.authEndpoints.updateFarmerDetails);
    Map body = {
      'name': nameController.text,
      'email': emailController.text,
      'fk_language_id': userLanguage,
    };
    print("data: ${jsonEncode(body)} ${url}");
    http.Response response =
    await http.put(url, body: jsonEncode(body), headers: headers);
    final json = jsonDecode(response.body);
    log("status ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.offAll(()=>FarmerHomeScreen());
      Get.snackbar("Success", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
      loading.value = false;
    } else {
      loading.value = false;
      Get.snackbar("Error", json['error'].toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}