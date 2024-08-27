import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../models/farmer_details_model.dart';
import '../../utils/api_constants.dart';


class FarmerHomeController extends GetxController{
  final storage = FlutterSecureStorage();
  var selectedIndex = 0.obs;
  String userRole = '';
  RxInt currentCarousel = 0.obs;
  var farmerDetails = FarmerDetailsModel(data: []).obs;
  RxBool farmerDetailsLoader = true.obs;
  String? accessToken;

  @override
  void onInit() {
    super.onInit();
    getToken().then((value){
      fetchFarmerDetails();
    });
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  Future<String?>getToken() async{
    accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }
    return accessToken;
  }

  void fetchFarmerDetails() async {
    farmerDetailsLoader.value = true;
    final url = Uri.parse('${ApiEndPoints.baseUrlTest}${ApiEndPoints.authEndpoints.getFarmerDetails}');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
    };
    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        farmerDetails.value = FarmerDetailsModel.fromJson(jsonData);
        farmerDetailsLoader.value = false;
      } else {
        farmerDetailsLoader.value = false;
        throw Exception('Failed to load farmer details');
      }
    } catch (e) {
      farmerDetailsLoader.value = false;
      print('Error fetching farmer details: $e');
    }
  }
}