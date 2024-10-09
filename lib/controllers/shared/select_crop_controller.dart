import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/select_crop_model.dart';
import '../../utils/api_constants.dart';
import '../../utils/helper_functions.dart';

class CropController extends GetxController {
  final storage = FlutterSecureStorage();
  var allCrops = <Crop>[].obs;
  var displayedCrops = <Crop>[].obs;
  var selectedCategory = ''.obs;
  var selectedCrops = <Crop>[].obs;
  var varieties = [].obs;
  var searchQuery = ''.obs;
  var categories = <String>[].obs;
  int? userLanguage;

  @override
  void onInit() {
    super.onInit();
    getUserLanguage().then((userlanguage) {
      fetchCrops();
    });
  }

  Future<int?> getUserLanguage() async {
    userLanguage = await HelperFunctions.getUserLanguage();
    log("UserRole $userLanguage");
    return userLanguage;
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
    final response = await http.get(Uri.parse('${ApiEndPoints.baseUrlTest}GetInitialScreenCrops'), headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      var loadedCrops = <Crop>[];
      var categorySet = Set<String>();  // Use a set to store unique categories
      data.forEach((category, crops) {
        categorySet.add(category);
        loadedCrops.addAll((crops as List).map((json) => Crop.fromJson(json, category)).toList());
      });

      allCrops.value = loadedCrops;
      displayedCrops.value = loadedCrops;
      categories.value = categorySet.toList();
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

  void fetchVarieties(String cropId) async {
    final response = await http.get(Uri.parse('https://api.agrisarathi.com/api/GetCropVariety?crop_id=$cropId'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      varieties.clear();
      jsonData['data'].forEach((variety) {
        varieties.add({
          'id': variety['id'].toString(),
          'name': variety['variety'],
        });
      });
    }
  }

}
