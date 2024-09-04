import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdvancedFertilizerCalculatorController extends GetxController {
  final storage = FlutterSecureStorage();
  var daep = ''.obs;
  var complexes = ''.obs;
  var urea = ''.obs;
  var ssp = ''.obs;
  var mop = ''.obs;

  var apiResponse = Rxn<Map<String, dynamic>>();
  var isLoading = false.obs;

  Future<void> calculateFertilizer(int? cropId, int? landId) async {
    isLoading.value = true;
    final url = Uri.parse('${ApiEndPoints.baseUrlTest}AdvanceFertilizercalculator');
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
    };
    int parseInt(String value) {
      try {
        return int.parse(value);
      } catch (e) {
        return 0; // Default value for invalid input
      }
    }
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({
          "crop_id": cropId,
          "farm_id": landId,
          "daep": parseInt(daep.value),
          "complexes": parseInt(complexes.value),
          "urea": parseInt(urea.value),
          "ssp": parseInt(ssp.value),
          "mop": parseInt(mop.value),
        }),
      );
      log("data ${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        apiResponse.value = jsonDecode(response.body);
      } else {
        Get.snackbar('Error', 'Failed to calculate. Please try again.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}