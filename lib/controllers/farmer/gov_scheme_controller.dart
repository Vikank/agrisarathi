import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/gov_scheme_model.dart';
import '../../utils/helper_functions.dart';

class SchemeController extends GetxController {
  final storage = FlutterSecureStorage();
  var allSchemes = <SchemeModel>[].obs;
  var filteredSchemes = <SchemeModel>[].obs;
  var isLoading = true.obs;
  var selectedFilter = 'all'.obs;
  int? userLanguage;

  // final List<String> filters = ['all', 'state', 'central'];

  final List<Map<String, String>> filters = [
    {"name": "All".tr, "image": "assets/images/allnews.png", "filter": "all"},
    {
      "name": "Central".tr,
      "image": "assets/images/central_scheme.png",
      "active_image": "assets/images/active_central_scheme.png",
      "filter": "central"
    },
    {
      "name": "State".tr,
      "image": "assets/images/state_scheme.png",
      "active_image": "assets/images/active_state_scheme.png",
      "filter": "state"
    },
  ];

  @override
  void onInit() {
    super.onInit();
    getUserLanguage().then((userlanguage) {
      fetchSchemes();
    });
  }

  Future<int?> getUserLanguage() async {
    userLanguage = await HelperFunctions.getUserLanguage();
    log("UserRole $userLanguage");
    return userLanguage;
  }

  Future<void> fetchSchemes() async {
    isLoading(true);
    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $accessToken' // Add the access token to the headers
      };
      var response = await http.get(
        Uri.parse(
            '${ApiEndPoints.baseUrlTest}GetallGovtSchemes?filter_type=all'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var schemesJson = jsonResponse['schemes'] as List;
        allSchemes.value = schemesJson
            .map((schemeJson) => SchemeModel.fromJson(schemeJson))
            .toList();
        filteredSchemes.value = allSchemes;
      }
    } catch (e) {
      print('Error fetching schemes: $e');
    } finally {
      isLoading(false);
    }
  }

  void filterSchemes(String filter) {
    selectedFilter.value = filter;
    if (filter == 'all') {
      filteredSchemes.value = allSchemes;
    } else if (filter == 'state') {
      filteredSchemes.value =
          allSchemes.where((scheme) => scheme.state != null).toList();
    } else if (filter == 'central') {
      filteredSchemes.value = allSchemes
          .where((scheme) => scheme.schemeBy == 'Central Schemes')
          .toList();
    }
  }
}
