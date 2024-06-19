import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fpo_assist/models/select_crop_model.dart';
import 'package:fpo_assist/screens/shared/home_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/api_constants.dart';


class FarmerUpdateProfileController extends GetxController{
  RxBool loading = false.obs;
  final registrationId = TextEditingController();
  final fpoName = TextEditingController();
  final phoneController = TextEditingController();
  RxString selectedDate = ''.obs;
  String fpoId = '';
  String mobileNumber = '';
  void updateDate(String date) {
    selectedDate.value = date;
  }

  @override
  void onInit(){
    super.onInit();
    setFpoId();
    setMobileNumber();
  }

  setFpoId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fpoId = (prefs.getString('fpoId')??'');
    log("fpo id is $fpoId");
  }

  setMobileNumber() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobileNumber = (prefs.getString('mobile_no')??'');
    phoneController.text = mobileNumber ?? "";
    log("mobile is $fpoId");
  }

  List<int> getSelectedCropIds(RxList<Crop> selectedCrops) {
    return selectedCrops.map((crop) => crop.id).toList();
  }

  Future<void> updateFpoDetail(RxList<Crop> selectedCrops, String phoneNumber, String registrationId, String establishedDate) async {
    final selectedCropIds = getSelectedCropIds(selectedCrops);
    log("fpo id $fpoId");
    loading.value = true;
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.updateFpoDetails);
    Map body = {
      'userid': fpoId,
      'mobile_no': int.parse(phoneNumber),
      'registration_id': registrationId,
      'fpo_name': fpoName,
      // 'state': state.text,
      'fk_crops': selectedCropIds
    };
    print("data: ${jsonEncode(body)}");
    http.Response response =
    await http.post(url, body: jsonEncode(body), headers: headers);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      phoneController.clear();
      Get.offAll(HomeScreen());
      Get.snackbar("Success", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
      loading.value = false;
    } else {
      loading.value = false;
      Get.snackbar("Error", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}