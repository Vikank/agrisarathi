import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/crop_variety_model.dart';

class CropVarietyController extends GetxController {
  var isLoading = true.obs;
  var cropVarieties = <CropVariety>[].obs;


  void fetchCropVarieties(int cropId) async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('https://api.agrisarathi.com/api/GetCropVariety?crop_id=4'));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['message'] == 'success') {
          var varietiesJson = jsonResponse['data'] as List;
          cropVarieties.value = varietiesJson.map((variety) => CropVariety.fromJson(variety)).toList();
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