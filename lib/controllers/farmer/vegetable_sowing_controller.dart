import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/screens/farmer/production/vegetable_production/vegetable_production_screen.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'dashboard_controller.dart';

class VegetableSowingController extends GetxController {
  final storage = FlutterSecureStorage();
  var selectedDateForUI = ''.obs;  // For UI display in DD/MM/YYYY format
  var selectedDateForAPI = ''.obs;
  var loading = false.obs;

  // Method to pick a date and update the controller's state
  Future<void> pickDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
    );

    if (pickedDate != null) {
      // Update the UI with DD/MM/YYYY format
      selectedDateForUI.value = DateFormat('dd/MM/yyyy').format(pickedDate);

      // Prepare the date for the API request in YYYY-MM-DD format
      selectedDateForAPI.value = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  // Function to call the API and send the selected sowing date
  Future<void> submitSowingDate(int landId, int filterId) async {
    if (selectedDateForAPI.isEmpty) {
      Fluttertoast.showToast(msg: "Please select a sowing date.");
      return;
    }
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
    };
    loading.value = true;
    final url = Uri.parse('${ApiEndPoints.baseUrlTest}FarmerAddGetallLandInfo');
    final body = {
      "land_id": landId,
      "sowing_date": selectedDateForAPI.value,
    };

    try {
      final response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      final jsonResponse = jsonDecode(response.body);
      log("repsonse body me aaya ${jsonResponse}");
      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        Get.off(()=> VegetableStagesScreen(landId: landId, filterId: filterId,));
      } else {
        Fluttertoast.showToast(msg: "Error: ${jsonResponse['message']}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: Unable to submit data.");
    } finally {
      loading.value = false;
    }
  }


}
