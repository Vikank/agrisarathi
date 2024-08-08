import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fpo_assist/models/select_crop_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/farmer/dashboard/farmer_home_screen.dart';
import '../../utils/api_constants.dart';
import '../../utils/helper_functions.dart';


class FarmerUpdateProfileController extends GetxController{
  RxBool loading = false.obs;
  final fpoName = TextEditingController();
  final nameController = TextEditingController();
  String? farmerId;
  RxBool fpoNameExist = false.obs;
  int? userLanguage;

  @override
  void onInit(){
    super.onInit();
    getUserLanguage();
    getFarmerId().then((value)=>fetchFarmerFpoName());
  }

  Future<int?> getUserLanguage() async {
    userLanguage = await HelperFunctions.getUserLanguage();
    log("UserRole $userLanguage");
    return userLanguage;
  }

  Future<String?>getFarmerId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log("farmer id is ${prefs.getString('farmerId')}");
    farmerId = (prefs.getString('farmerId'));
    return farmerId;
  }

  List<int> getSelectedCropIds(RxList<Crop> selectedCrops) {
    return selectedCrops.map((crop) => crop.id).toList();
  }

  Future<void> fetchFarmerFpoName() async {
    try {
      var response = await http.post(
        Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getFarmerFpoName),
        body: jsonEncode({"userid": farmerId}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if(data['Fpo Name'] != null){
          fpoName.text = data['Fpo Name'];
          fpoNameExist.value = true;
        } else{
          fpoName.text = '';
          fpoNameExist.value = false;
        }
      } else {
        print('Failed to fetch fpo name: ${response.statusCode}');
        fpoNameExist.value = false;
      }
    } catch (e) {
      print('Error fetching fpo name: $e');
      fpoNameExist.value = false;
    }
  }

  Future<void> updateFarmerDetail(RxList<Crop> selectedCrops, int? pinCode, int? landArea, String? village, int? state, String? addressLine, int? district) async {
    final selectedCropIds = getSelectedCropIds(selectedCrops);
    loading.value = true;
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.updateFarmerDetails);
    Map body = {
      'name': nameController.text,
      'fpo_name': fpoName.text,
      'userid': farmerId,
      'fk_language_id': userLanguage,
      'pincode': pinCode,
      'land_id': null,
      'land_area': landArea,
      'address': addressLine,
      'village': village,
      'fk_state_id': state,
      'fk_district_id': district,
      'fk_crops_id': selectedCropIds.first
    };
    print("data: ${jsonEncode(body)} ${url}");
    http.Response response =
    await http.post(url, body: jsonEncode(body), headers: headers);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.offAll(()=>FarmerHomeScreen());
      Get.snackbar("Success", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
      loading.value = false;
    } else {
      loading.value = false;
      Get.snackbar("Error", json['error'].toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}