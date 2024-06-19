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
  final fpoName = TextEditingController();
  final nameController = TextEditingController();
  String? farmerId;

  @override
  void onInit(){
    super.onInit();
    getFarmerId();
    // setMobileNumber();
  }

  getFarmerId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log("fpo id is ${prefs.getString('farmerId')}");
    farmerId = (prefs.getString('farmerId'));
  }
  // setMobileNumber() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   mobileNumber = (prefs.getString('mobile_no')??'');
  //   phoneController.text = mobileNumber ?? "";
  // }

  List<int> getSelectedCropIds(RxList<Crop> selectedCrops) {
    return selectedCrops.map((crop) => crop.id).toList();
  }

  Future<void> updateFarmerDetail(RxList<Crop> selectedCrops) async {
    final selectedCropIds = getSelectedCropIds(selectedCrops);
    loading.value = true;
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.updateFpoDetails);
    Map body = {
      'name': nameController.text,
      'fpo_name': fpoName,
      'fk_crops': selectedCropIds,
      'userid': farmerId
    };
    print("data: ${jsonEncode(body)}");
    http.Response response =
    await http.post(url, body: jsonEncode(body), headers: headers);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.offAll(HomeScreen());
      Get.snackbar("Success", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
      loading.value = false;
    } else {
      loading.value = false;
      Get.snackbar("Error", json['message'].toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}