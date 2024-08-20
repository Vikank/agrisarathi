import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fpo_assist/models/farmer_lands.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../models/news_model.dart';
import '../../utils/helper_functions.dart';


class FarmerDashboardController extends GetxController{
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
  final RxList<TargetFocus> targets = <TargetFocus>[].obs;
  final communityCoachKey = GlobalKey();
  final mandiCoachKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    createTargets();
    getUserLanguage().then((value){
      fetchNews();
    });
    getFarmerId().then((value){
    fetchFarmerLands();
    });
  }

  void createTargets() {
    targets.addAll([
      TargetFocus(
        identify: "communityCoachKey",
        keyTarget: communityCoachKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Text(
              "Community_forum_to_discuss_problems".tr,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "mandiCoachKey",
        keyTarget: mandiCoachKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Text(
              "You_can_get_information_of_shops_products_mandi_prices",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    ]);
  }

  void showTutorial() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = Get.context;

      if (context != null) {
        final overlay = Overlay.of(context);
        if (overlay != null) {
          TutorialCoachMark(
            targets: targets,
            colorShadow: Colors.green,
            textSkip: "SKIP",
            paddingFocus: 10,
            opacityShadow: 0.8,
            onFinish: () {
              print("Finish");
            },
            onClickTarget: (target) {
              print('onClickTarget: $target');
            },
            onClickOverlay: (target) {
              print('onClickOverlay: $target');
            },
            onSkip: () {
              print("Skip");
              return true;
            },
          ).show(context: context);
        } else {
          print("Overlay not available");
        }
      } else {
        print("Context is null");
      }
    });
  }

  Future<int?> getUserLanguage() async {
    userLanguage = await HelperFunctions.getUserLanguage();
    log("UserRole $userLanguage");
    return userLanguage;
  }

  Future<String?>getFarmerId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    farmerId = (prefs.getString('farmerId'));
    return farmerId;
  }


  void fetchFarmerLands() async {
    farmerLandLoader.value = true;
    final url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.getFarmerLands}?user_id=$farmerId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
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
    final url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.getAllNews}?user_language=1&filter_type=all&limit=5&offset=0');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        var articlesJson = jsonData['results'] as List;
        articles.value = articlesJson.map((articleJson) => NewsArticle.fromJson(articleJson)).toList();
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