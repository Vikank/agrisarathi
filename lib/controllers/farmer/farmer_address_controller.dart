import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/models/select_crop_model.dart';
import 'package:fpo_assist/screens/farmer/dashboard/farmer_home_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../screens/farmer/auth/farmer_update_profile_screen.dart';
import '../../screens/shared/select_crop_screen.dart';
import '../../utils/api_constants.dart';
import '../../utils/helper_functions.dart';


class FarmerAddressController extends GetxController{
  final storage = FlutterSecureStorage();
  RxBool loading = false.obs;
  RxBool isLand = true.obs;
  final addressLine = TextEditingController();
  final pinCode = TextEditingController();
  int? state;
  int? district;
  var crops = [].obs;
  var selectedCropId;
  var selectedCropfilterId;
  var varieties = [].obs;
  var selectedVarietyId;
  final village = TextEditingController();
  String? farmerId;
  int? userLanguage;
  RxList<dynamic> states = <dynamic>[].obs;
  RxList<dynamic> districts = <dynamic>[].obs;
  final landArea = TextEditingController();

  var selectedPropertyType = 'Owned'.obs;

  void setSelectedPropertyType(String value) {
    selectedPropertyType.value = value;
    isLand.value = (value == 'Owned');
    log("value of isLand is ${isLand.value}");
  }

  @override
  void onInit(){
    super.onInit();
    getFarmerId();
    fetchStates();
    fetchCrops();
    getUserLanguage();
  }

  getFarmerId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log("farmer id is ${prefs.getString('farmerId')}");
    farmerId = (prefs.getString('farmerId'));
  }

  void getUserLanguage() async{
    userLanguage = await HelperFunctions.getUserLanguage();
    log("UserLanguage $userLanguage");
  }

// Fetch all states from API
  Future<void> fetchStates() async {
    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
      };
      var response = await http.get(
        Uri.parse(ApiEndPoints.baseUrlTest + ApiEndPoints.authEndpoints.getAllStatesUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // Check if data contains 'data' key and it is a List<dynamic>
        if (data['success'] == 'ok' && data.containsKey('data') && data['data'] is List<dynamic>) {
          states.assignAll(data['data']); // Up// date RxList with the list of states
        } else {
          print('Invalid data format for states');
        }
      } else {
        print('Failed to fetch states: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching states: $e');
    }
  }

  // Fetch districts by state from API
  Future<void> fetchDistricts(int stateId) async {
    log("aayaaa");
    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
      };
      var response = await http.get(
        Uri.parse(ApiEndPoints.baseUrlTest + ApiEndPoints.authEndpoints.getStateWiseDistrictUrl+'?state=$stateId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // Check if data contains 'success' key with value 'Ok' and 'data' key with List<dynamic> value
        if (data['success'] == 'Ok' && data.containsKey('data') && data['data'] is List<dynamic>) {
          districts.assignAll(data['data']); // Update RxList with the list of districts
        } else {
          print('Invalid data format for districts');
        }
      } else {
        print('Failed to fetch districts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching districts: $e');
    }
  }

  void fetchCrops() async {
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
    };
    final response = await http.get(Uri.parse('${ApiEndPoints.baseUrlTest}GetInitialScreenCrops'), headers : headers);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      jsonData.forEach((key, value) {
        value.forEach((crop) {
          crops.add({
            'id': crop['id'].toString(),
            'name': crop['crop_name'],
            'filterId': crop['filter_id'],
          });
        });
      });
    }
  }

  void fetchVarieties(String cropId) async {
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
    };
    final response = await http.get(Uri.parse('${ApiEndPoints.baseUrlTest}GetCropVariety?crop_id=$cropId'), headers : headers);
    log("aaya response me ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      varieties.clear();
      jsonData['data'].forEach((variety) {
        varieties.add({
          'id': variety['id'].toString(),
          'name': variety['name'],
        });
      });
    }
  }

  Future<void> postFarmerAddress({int? selectedCropId, int? selectedVarietyId}) async {
    loading.value = true;
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
    };
    var url = Uri.parse(
        ApiEndPoints.baseUrlTest + ApiEndPoints.authEndpoints.createFarmerAddress);
    var body = {
      "crop_id": selectedCropId,
      "is_land": isLand.value,
      "variety_id": selectedVarietyId,
      "address":addressLine.text,
      "state":state,
      "district":district,
      "village":village.text,
      "land_area" : int.parse(landArea.text),
      "pincode": int.parse(pinCode.text)
    };
    log("data: ${jsonEncode(body)}");
    http.Response response =
    await http.post(url, body: jsonEncode(body), headers: headers);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      addressLine.clear();
      village.clear();
      landArea.clear();
      addressLine.clear();
      Get.snackbar("Success", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
      loading.value = false;
      Get.to(() => FarmerUpdateProfileScreen());
    } else {
      loading.value = false;
      Get.snackbar("Error", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> addNewLand() async {
    loading.value = true;
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
    };
    var url = Uri.parse(
        ApiEndPoints.baseUrlTest + ApiEndPoints.authEndpoints.createFarmerAddress);
    var body = {
      "crop_id": selectedCropId,
      "is_land": isLand.value,
      "filter_id": selectedCropfilterId,
      "variety_id": selectedVarietyId,
      "address":addressLine.text,
      "state":state,
      "district":district,
      "village":village.text,
      "land_area" : int.parse(landArea.text),
      "pincode": int.parse(pinCode.text)
    };
    log("data: ${jsonEncode(body)}");
    http.Response response =
    await http.post(url, body: jsonEncode(body), headers: headers);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      addressLine.clear();
      village.clear();
      landArea.clear();
      addressLine.clear();
      Get.snackbar("Success", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
      loading.value = false;
    } else {
      loading.value = false;
      Get.snackbar("Error", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }


}