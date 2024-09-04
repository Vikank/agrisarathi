import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/fertilizer_calci_response.dart';
import '../../utils/helper_functions.dart';


class FertilizerCalciController extends GetxController{
  final storage = FlutterSecureStorage();
  var isLoading = false.obs;
  var fertilizerData = Rxn<Map<String, dynamic>>();
  final nitrogenValue = TextEditingController();
  final phosphorousValue = TextEditingController();
  final potassiumValue = TextEditingController();
  int? userLanguage;
  @override
  void onInit(){
    super.onInit();
    getUserLanguage();
  }

  void getUserLanguage() async{
    userLanguage = await HelperFunctions.getUserLanguage();
  }

  Future<FertilizerResponse> fetchFertilizerData(int? cropId, int? landId) async {
    final url = Uri.parse('${ApiEndPoints.baseUrlTest}Fertilizerswithtest');
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        "crop_id": cropId,
        "farm_id": landId,
        "nitrogen": int.parse(nitrogenValue.text),
        "phosphorous": int.parse(phosphorousValue.text),
        "potassium": int.parse(potassiumValue.text)
      }),
    );

    if (response.statusCode == 200) {
      log("fertilizer data ${jsonDecode(response.body)}");
      return FertilizerResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load fertilizer data');
    }
  }

  Future<void> fetchRecommendedFertilizerData(int? cropId) async {
    isLoading.value = true;
    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
      };
      final response = await http.get(
        Uri.parse('${ApiEndPoints.baseUrlTest}Fertilizerswithtest?crop_id=$cropId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        fertilizerData.value = data['results'][0];
      } else {
        Get.snackbar('Error', 'Failed to fetch data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}