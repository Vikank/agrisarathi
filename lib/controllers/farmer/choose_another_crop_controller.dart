import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/select_crop_model.dart';

class ChooseAnotherCropController extends GetxController {
  final storage = FlutterSecureStorage();
  var allCrops = <Crop>[].obs;
  var displayedCrops = <Crop>[].obs;
  var selectedCategory = ''.obs;
  var selectedCrops = <Crop>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCrops();
  }

  Future<void> fetchCrops() async {
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
    };
    final response = await http.get(Uri.parse('${ApiEndPoints.baseUrlTest}GetInitialScreenCrops'), headers : headers);
    log(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      var loadedCrops = <Crop>[];
      data.forEach((category, crops) {
        loadedCrops.addAll((crops as List).map((json) => Crop.fromJson(json, category)).toList());
      });

      allCrops.value = loadedCrops;
      displayedCrops.value = loadedCrops;
    } else {
      throw Exception('Failed to load crops');
    }
  }

  void filterCrops(String category) {
    if (category.isEmpty) {
      displayedCrops.value = allCrops;
    } else {
      displayedCrops.value = allCrops.where((crop) => crop.category == category).toList();
    }
    selectedCategory.value = category;
  }

  void filterBySearchQuery() {
    if (searchQuery.value.isNotEmpty) {
      displayedCrops.value = displayedCrops.where((crop) => crop.cropName!.toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
    } else {
      displayedCrops.value = selectedCategory.isEmpty ? allCrops : allCrops.where((crop) => crop.category == selectedCategory.value).toList();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterBySearchQuery();
  }

  void addSelectedCrop(Crop crop) {
    if (selectedCrops.length < 1 && !selectedCrops.contains(crop)) {
      selectedCrops.add(crop);
    }
  }

  void removeSelectedCrop(Crop crop) {
    selectedCrops.remove(crop);
  }

}
