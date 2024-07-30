import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../models/crop_suggestion_model.dart';
import '../../utils/helper_functions.dart';


class CropSuggestionController extends GetxController{
  var isLoading = true.obs;
  var cropSuggestions = <SuggestedCrops>[].obs;
  var errorMessage = ''.obs;
  String? farmerId;
  int? userLanguage;

  @override
  void onInit() {
    getFarmerId().then((value){
      fetchCropSuggestions();
    });
    super.onInit();
  }

  Future<String?> getFarmerId() async {
    getUserLanguage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    farmerId = (prefs.getString('farmerId'));
    log("farmerId $farmerId");
    return farmerId;
  }

  void getUserLanguage() async {
    userLanguage = await HelperFunctions.getUserLanguage();
    log("userLanguage $userLanguage");
  }

  void fetchCropSuggestions() async {
    try {
      isLoading(true);
      errorMessage('');

      // Prepare the request body
      Map<String, dynamic> body = {
        "user_id": farmerId,
        "user_language": userLanguage
      };

      // Make the POST request
      var response = await http.post(
        Uri.parse('https://api.agrisarathi.com/api/Get_Suggested_Crops'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
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