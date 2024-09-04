import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../models/crop_suggestion_model.dart';
import '../../utils/helper_functions.dart';


class CropSuggestionController extends GetxController{
  final storage = FlutterSecureStorage();
  var isLoading = true.obs;
  var cropSuggestions = <SuggestedCrops>[].obs;
  var errorMessage = ''.obs;
  String? farmerId;
  int? userLanguage;

  @override
  void onInit() {
    getUserLanguage();
    fetchCropSuggestions();
    super.onInit();
  }

  void getUserLanguage() async {
    userLanguage = await HelperFunctions.getUserLanguage();
    log("userLanguage $userLanguage");
  }

  void fetchCropSuggestions() async {
    try {
      isLoading(true);
      errorMessage('');
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
      };

      // Make the POST request
      var response = await http.post(
        Uri.parse('${ApiEndPoints.baseUrlTest}CropSuggestion'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        CropSuggestionModel cropSuggestionModel = CropSuggestionModel.fromJson(jsonData);
        if (cropSuggestionModel.suggestedCrops != null && cropSuggestionModel.suggestedCrops!.isNotEmpty) {
          cropSuggestions.assignAll(cropSuggestionModel.suggestedCrops!);
        } else {
          errorMessage('No suggested crops found.');
        }
      } else {
        errorMessage('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage('An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}