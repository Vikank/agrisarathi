import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/models/farmer_lands.dart';
import 'package:fpo_assist/models/vegetable_progress_model.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../models/news_model.dart';
import '../../models/weatherNotificationModel.dart';
import '../../utils/helper_functions.dart';

class FarmerDashboardController extends GetxController {
  final storage = FlutterSecureStorage();
  var articles = <NewsArticle>[].obs;
  var farmerLands = FarmerLands(data: []).obs;
  var vegetableProgress = Rx<VegetableProgressModel?>(null);
  RxString cropName = "".obs;
  String? farmerId;
  RxBool farmerLandLoader = true.obs;
  RxBool newsLoader = true.obs;
  int? userLanguage;
  var temperature = ''.obs;
  var weatherIcon = ''.obs;
  final String apiKey = '4675f25ce2863825d057505230a4cca0';
  final List<TargetFocus> targets = <TargetFocus>[];
  final communityCoachKey = GlobalKey();
  final mandiCoachKey = GlobalKey();
  RxInt currentCarousel = 0.obs;
  var landWeatherData = <String, Map<String, String>>{}.obs;
  var notificationsData = Rx<PopNotificationResponse?>(null);
  var filteredNotifications =
      <Notifications>[].obs; // Observable list for filtered notifications
  var filteredProgress = <CropsProgress>[].obs;
  var selectedLandId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
    fetchFarmerLands();
  }

  Future<void> fetchFarmerLands() async {
    farmerLandLoader.value = true;
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer $accessToken' // Add the access token to the headers
    };
    final url = Uri.parse(
        '${ApiEndPoints.baseUrlTest}${ApiEndPoints.authEndpoints.getFarmerLands}');

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        farmerLands.value = FarmerLands.fromJson(jsonData);
        // Clear previously fetched weather data
        landWeatherData.clear();
        List<Map<String, dynamic>> cropsList = [];

        // Loop through all lands and fetch weather for each
        for (var land in farmerLands.value.data!) {
          String? district = land.engDistrict;
          double? lat = land.lat;
          double? long = land.long;
          if (lat != null && long != null && district != null) {
            await fetchWeatherForLand(lat, long, district);
          }

          if (land.cropId != null && land.filterId != null) {
            cropsList.add({"land_id": land.id, "filter_type": land.filterId});
          }
        }
        // await fetchNotifications(); // Fetch notifications after weather data is loaded
        await fetchCropProgress(cropsList);
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

  Future<void> fetchWeatherForLand(double lat, double long, String district) async {
    try {
      final response = await http.get(
        Uri.parse(
          // 'https://api.openweathermap.org/data/2.5/weather?q=$district&appid=$apiKey&units=metric',
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric'
        ),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        String temp = data['main']['temp'].round().toString();
        String iconCode = data['weather'][0]['icon'];
        String weatherIconUrl =
            'http://openweathermap.org/img/wn/$iconCode@2x.png';
        String weatherCondition = data['weather'][0]['description'];

        // Map the weather data with district
        landWeatherData[district] = {
          'temperature': temp,
          'weatherIcon': weatherIconUrl,
          'weatherCondition': weatherCondition,
        };
        await fetchNotifications(); // Fetch notifications after weather data is loaded
      } else {
        log('Error, Unable to fetch weather data');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Fetch weather notifications based on conditions
  Future<void> fetchNotifications() async {
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer $accessToken' // Add the access token to the headers
    };

    var requestBody = {
      "crops": farmerLands.value.data!.map((land) {
        return {
          "land_id": land.id,
          "filter_type": land.filterId,
          "weather_conditions": [
            landWeatherData[land.district]!['weatherCondition']
          ]
        };
      }).toList(),
    };
    log("request body is ${requestBody}");
    final response = await http.post(
      Uri.parse('${ApiEndPoints.baseUrlTest}GetVegetablePopNotification'),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      notificationsData.value = PopNotificationResponse.fromJson(jsonData);
      // Initialize notifications for the first land if available
      updateSelectedLandForNotification(0); // Set the initial notifications for the first land
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  Future<void> fetchCropProgress(List<Map<String, dynamic>> crops) async {
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
      log("${jsonEncode({'crops': crops})}");
      final response = await http.post(
        Uri.parse('${ApiEndPoints.baseUrlTest}VegetableProgressAPIView'),
        headers: headers,
        body: jsonEncode({'crops': crops}),
      );

      if (response.statusCode == 200) {
        vegetableProgress.value =
            VegetableProgressModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        // Initialize notifications for the first land if available
        updateSelectedLandForProgress(0); // Set the initial notifications for the first land
      } else {
        throw Exception('Failed to load crop progress');
      }
    } catch (e) {
      print('Error fetching crop progress: $e');
    }
  }

  void updateSelectedLandForNotification(int index) {
    // Filter notifications for lands with preference == true
    if (farmerLands.value.data![index].preference == true) {
      filteredNotifications.value =
          getNotificationsForLand(farmerLands.value.data![index].id!);
    } else {
      filteredNotifications.clear(); // No notifications if preference is false
    }
  }

  void updateSelectedLandForProgress(int index) {
    // Filter notifications for lands with preference == true
    if (farmerLands.value.data![index].preference == true) {
      filteredProgress.value = getProgressForLand(farmerLands.value.data![index].id!);
    } else {
      filteredProgress.clear();
    }
  }

  List<Notifications> getNotificationsForLand(int landId) {
    return notificationsData.value!.results
        .firstWhere((landNotification) => landNotification.landId == landId,
        orElse: () => LandNotification(landId: landId, notifications: []))
        .notifications;
  }

  List<CropsProgress> getProgressForLand(int landId) {
    return vegetableProgress.value!.cropsProgress?.where((progress) => progress.landId == landId).toList() ?? [];
  }

  void fetchNews() async {
    newsLoader.value = true;
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer $accessToken' // Add the access token to the headers
    };
    final url = Uri.parse(
        '${ApiEndPoints.baseUrlTest}${ApiEndPoints.authEndpoints.getAllNews}?filter_type=all&limit=5&offset=0');
    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        var articlesJson = jsonData['results'] as List;
        articles.value = articlesJson
            .map((articleJson) => NewsArticle.fromJson(articleJson))
            .toList();
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

  void clearData() {
    farmerLands.value = FarmerLands(data: []);
    vegetableProgress.value = null;
    articles.clear();
    landWeatherData.clear();
    notificationsData.value = null;
    filteredNotifications.clear(); // No notifications if preference is false
    filteredProgress.clear();
    cropName.value = '';
    temperature.value = '';
    weatherIcon.value = '';
    currentCarousel.value = 0;
  }
}
