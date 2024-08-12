import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../models/disease_history_model.dart';
import '../../models/disease_result_model.dart';
import '../../models/single_disease_history_model.dart';
import '../../utils/helper_functions.dart';

class DiseaseDetectionHistoryController extends GetxController{
  var diseaseHistory = Rx<DiseaseHistoryModel?>(null);
  var isLoading = true.obs;
  String? farmerId;
  int? userLanguage;

  @override
  void onInit() {
    getUserLanguage();
    getFarmerId().then((value){
      fetchDiseaseHistory();
    });
    super.onInit();
  }

  Future<String?> getFarmerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    farmerId = (prefs.getString('farmerId'));
    log("user id $farmerId");
    return farmerId;
  }

  void getUserLanguage() async {
    userLanguage = await HelperFunctions.getUserLanguage();
    log("user language $userLanguage");
  }

  void fetchDiseaseHistory() async {
    try {
      isLoading(true);
      var url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.getDiseaseHistory}?user_id=$farmerId&user_language=$userLanguage');
      log("$url");
      var response = await http.get(
          url,
          headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        diseaseHistory.value = DiseaseHistoryModel.fromJson(jsonData);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<SingleDiseaseHistoryModel?> fetchSingleDiseaseHistory(int diagId) async {
    try {
      var url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.getSingleDiseaseHistory}?user_id=$farmerId&diag_id=$diagId&user_language=$userLanguage');
      var response = await http.get(
          url,
          headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        print('Response: ${jsonData}');
        return SingleDiseaseHistoryModel.fromJson(jsonData);
      } else {
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching single disease report: $e');
      return null;
    }
  }

}