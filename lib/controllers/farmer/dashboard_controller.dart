import 'dart:convert';
import 'package:fpo_assist/models/farmer_lands.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/all_news.dart';


class FarmerDashboardController extends GetxController{
  var news = AllNews(status: "", articles: []).obs;
  var farmerLands = FarmerLands(data: []).obs;
  RxString cropName = "".obs;
  String? farmerId;
  RxBool farmerLandLoader = true.obs;
  RxBool newsLoader = true.obs;

  @override
  void onInit() {
    super.onInit();
    getFarmerId().then((value){
    fetchFarmerLands();
    });
    fetchNews();
  }

  Future<String?>getFarmerId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    farmerId = (prefs.getString('farmerId'));
    return farmerId;
  }


  void fetchFarmerLands() async {
    farmerLandLoader.value = true;
    final url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.getFarmerLands}');
    final body = jsonEncode({
      "user_id": int.parse(farmerId!)
    });

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
        farmerLands.value = FarmerLands.fromJson(jsonData);
        cropName.value = farmerLands.value.data![0].crop ?? "";
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


  void fetchNews() async {
    newsLoader.value = true;
    final url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.getAllNews}');
    final body = jsonEncode({
      "user_language": 1,
      "filter_type": "all"
    });

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