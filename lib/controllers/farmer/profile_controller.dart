import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/profile_model.dart';


class FarmerProfileController extends GetxController {
  final storage = const FlutterSecureStorage();
  var isLoading = true.obs;
  var farmerProfile = FarmerProfile().obs;

  // Fetch Profile API
  Future<void> fetchProfile() async {
    final String apiUrl = "${ApiEndPoints.baseUrlTest}GetFarmProfileDetails";

    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }
      log("token is $accessToken");
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      isLoading(true);
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        farmerProfile.value = FarmerProfile.fromJson(data);
      } else {
        Get.snackbar("Error", "Failed to load profile data");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }
}

