import 'dart:convert';
import 'dart:developer';
import 'package:fpo_assist/models/farmer_lands.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/all_news.dart';
import '../../models/farmer_details_model.dart';
import '../../utils/helper_functions.dart';
import 'farmer_home_controller.dart';


class FarmerDashboardController extends GetxController{
  var news = AllNews(status: "", articles: []).obs;
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

  @override
  void onInit() {
    super.onInit();
    getUserLanguage().then((value){
      fetchNews();
    });
    getFarmerId().then((value){
    fetchFarmerLands();
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
    final url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.getAllNews}');
    final body = jsonEncode({
      "user_language": userLanguage,
      "filter_type": "all"
    });
    log("log of body${body}");
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        news.value = AllNews.fromJson(jsonData);
        log("log ${news.value}");
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