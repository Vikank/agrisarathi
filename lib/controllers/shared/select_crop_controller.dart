import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/select_crop_model.dart';
import '../../utils/api_constants.dart';
import '../../utils/helper_functions.dart';

class CropController extends GetxController {
  var allCrops = <Crop>[].obs;
  var displayedCrops = <Crop>[].obs;
  var selectedCategory = ''.obs;
  var selectedCrops = <Crop>[].obs;
  var varieties = [].obs;
  var searchQuery = ''.obs;
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
    final response = await http.get(Uri.parse('${ApiEndPoints.baseUrl}GetInitialScreenCrops?user_language=1'));
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

  void fetchVarieties(String cropId) async {
    log("aaya variety me ${cropId}");
    final response = await http.get(Uri.parse('https://api.agrisarathi.com/api/GetCropVariety?crop_id=$cropId'));
    log("aaya response me ${response.body}");
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
