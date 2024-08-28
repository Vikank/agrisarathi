import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/models/farmer_lands.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../models/news_model.dart';
import '../../utils/helper_functions.dart';

class FarmerDashboardController extends GetxController {
  final storage = FlutterSecureStorage();
  var articles = <NewsArticle>[].obs;
  var farmerLands = FarmerLands(data: []).obs;
  RxString cropName = "".obs;
  String? farmerId;
  RxString districtName = "".obs;
  RxBool farmerLandLoader = true.obs;
  RxBool newsLoader = true.obs;
  int? userLanguage;
  var temperature = ''.obs;
  var weatherIcon = ''.obs;
  final String apiKey = '4675f25ce2863825d057505230a4cca0';
  final List<TargetFocus> targets = <TargetFocus>[];
  final communityCoachKey = GlobalKey();
  final mandiCoachKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    getUserLanguage().then((value) {
      fetchNews();
    });
      fetchFarmerLands();
  }

  Future<int?> getUserLanguage() async {
    userLanguage = await HelperFunctions.getUserLanguage();
    log("User language $userLanguage");
    return userLanguage;
  }

  void fetchFarmerLands() async {
    farmerLandLoader.value = true;
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
    };
    final url = Uri.parse(
        '${ApiEndPoints.baseUrlTest}${ApiEndPoints.authEndpoints.getFarmerLands}');

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        farmerLands.value = FarmerLands.fromJson(jsonData);
        log("farmer land ${farmerLands.value.data}");
        cropName.value = farmerLands.value.data![0].crop ?? "";
        districtName.value = farmerLands.value.data![0].district ?? "";
        await fetchWeather();
        farmerLandLoader.value = false;
      } else {
        farmerLandLoader.value = false;
        throw Exception('Failed to load farmer lands');
      }
    } catch (e) {
      farmerLandLoader.value = false;
      print('Error fetching farmer lands: $e');
    }
  }

  fetchWeather() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=${districtName.value}&appid=$apiKey&units=metric',
        ),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        temperature.value = data['main']['temp'].round().toString();
        String iconCode = data['weather'][0]['icon'];
        weatherIcon.value = 'http://openweathermap.org/img/wn/$iconCode@2x.png';
      } else {
        Get.snackbar('Error', 'Unable to fetch weather data');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void fetchNews() async {
    newsLoader.value = true;
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
    };
    final url = Uri.parse(
        '${ApiEndPoints.baseUrlTest}${ApiEndPoints.authEndpoints.getAllNews}?user_language=1&filter_type=all&limit=5&offset=0');
    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        var articlesJson = jsonData['results'] as List;
        articles.value = articlesJson
            .map((articleJson) => NewsArticle.fromJson(articleJson))
            .toList();
        log("log ${articles.value}");
        newsLoader.value = false;
      } else {
        newsLoader.value = false;
        throw Exception('Failed to load news');
      }
    } catch (e) {
      newsLoader.value = false;
      print('Error fetching news: $e');
    }
  }
}
