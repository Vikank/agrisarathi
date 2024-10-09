import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/crop_variety_model.dart';

class CropVarietyController extends GetxController {
  final storage = FlutterSecureStorage();
  var isLoading = true.obs;
  var cropVarieties = <CropVariety>[].obs;


  void fetchCropVarieties(int cropId) async {
    log("crop id $cropId");
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
      var response = await http.get(Uri.parse('${ApiEndPoints.baseUrlTest}GetCropVariety?crop_id=$cropId'), headers: headers);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        if (jsonResponse['message'] == 'success') {
          var varietiesJson = jsonResponse['data'] as List;
          cropVarieties.value = varietiesJson.map((variety) => CropVariety.fromJson(variety)).toList();
          log("Data ${cropVarieties}");
        }
      } else {
        print('Failed to load crop varieties');
      }
    } catch (e) {
      print('Error while getting crop varieties: $e');
    } finally {
      isLoading(false);
    }
  }
}