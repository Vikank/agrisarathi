import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/vegetable_production_model.dart';

class VegetableStagesController extends GetxController {
  final storage = FlutterSecureStorage();
  var vegetableProduction = VegetableProductionModel().obs;
  var isLoading = true.obs;
  var currentStageIndex = 0.obs;
  var progressValue = 0.0.obs;

  final int landId;
  final int cropId; // This is the filter_type passed from the previous screen

  VegetableStagesController(this.landId, this.cropId);

  @override
  void onInit() {
    super.onInit();
    fetchVegetableStages();
  }

  void fetchVegetableStages() async {
    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
      };
      isLoading(true);
      var url = Uri.parse('http://64.227.166.238:8090/farmer/VegetableStagesAPIView');
      var response = await http.post(url, body: {
        'land_id': landId.toString(),
        'filter_type': cropId.toString(),
      }, headers: headers);
      log("ids send ${landId} ${cropId}");
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        vegetableProduction.value = VegetableProductionModel.fromJson(jsonResponse);
      } else {
        Get.snackbar('Error', 'Failed to load data');
      }
    } catch (e) {
      log("error is $e");
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading(false);
    }
  }

  void nextStage() {
    if (currentStageIndex.value < vegetableProduction.value.stages!.length - 1) {
      currentStageIndex.value++;
      updateProgress();
    } else {
      submitStages();
    }
  }

  void updateProgress() {
    var totalStages = vegetableProduction.value.stages!.length;
    var completedStages = currentStageIndex.value + 1;
    progressValue.value = completedStages / totalStages;
    vegetableProduction.value.stages![currentStageIndex.value].isCompleted = true;
  }

  void submitStages() {
    Get.snackbar('Submitted', 'All stages completed and submitted successfully.');
  }
}
