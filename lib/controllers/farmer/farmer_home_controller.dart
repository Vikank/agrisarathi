import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/farmer_details_model.dart';
import '../../utils/api_constants.dart';


class FarmerHomeController extends GetxController{
  final storage = const FlutterSecureStorage();
  var selectedIndex = 0.obs;
  String userRole = '';
  RxInt currentCarousel = 0.obs;
  var farmerDetails = Rxn<FarmerDetailsModel>();
  RxBool farmerDetailsLoader = true.obs;
  String? accessToken;
  bool userExist = false;

  @override
  void onInit() {
    super.onInit();
    getUserExist();
    getToken().then((value){
      fetchFarmerDetails();
    });
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  void getUserExist() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userExist = prefs.getBool('userExist') ?? false;
  }
  Future<String?>getToken() async{
    accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }
    return accessToken;
  }

  Future<void> fetchFarmerDetails() async {
    farmerDetailsLoader.value = true;
    final url = Uri.parse('${ApiEndPoints.baseUrlTest}${ApiEndPoints.authEndpoints.getFarmerDetails}');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
    };
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        log("coin data is ${jsonResponse}");
        farmerDetails.value = FarmerDetailsModel.fromJson(jsonResponse);
      } else {
        print('Error: ${response.statusCode}');
        farmerDetails.value = null; // Set to null if response is not OK
      }
    } catch (e) {
      print('Error fetching farmer details: $e');
      farmerDetails.value = null;
    } finally {
      farmerDetailsLoader.value = false;
    }
  }
}