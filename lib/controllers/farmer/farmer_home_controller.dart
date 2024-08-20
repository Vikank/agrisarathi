import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../models/farmer_details_model.dart';
import '../../utils/api_constants.dart';


class FarmerHomeController extends GetxController{
  var selectedIndex = 0.obs;
  String userRole = '';
  RxInt currentCarousel = 0.obs;
  var farmerDetails = FarmerDetailsModel(data: []).obs;
  RxBool farmerDetailsLoader = true.obs;
  String? farmerId;
  final RxList<TargetFocus> targets = <TargetFocus>[].obs;
  final communityCoachKey = GlobalKey().obs;
  final mandiCoachKey = GlobalKey().obs;

  @override
  void onInit() {
    super.onInit();
    // createTargets();
    getFarmerId().then((value){
      fetchFarmerDetails();
    });
  }

  // void createTargets() {
  //   targets.addAll([
  //     TargetFocus(
  //       identify: "Community".tr,
  //       keyTarget: communityCoachKey.value,
  //       contents: [
  //         TargetContent(
  //           align: ContentAlign.bottom,
  //           child: Text(
  //             "Community_forum_to_discuss_problems".tr,
  //             style: TextStyle(color: Colors.white, fontSize: 18),
  //           ),
  //         ),
  //       ],
  //     ),
  //     TargetFocus(
  //       identify: "Mandi".tr,
  //       keyTarget: mandiCoachKey.value,
  //       contents: [
  //         TargetContent(
  //           align: ContentAlign.bottom,
  //           child: Text(
  //             "You_can_get_information_of_shops_products_mandi_prices",
  //             style: TextStyle(color: Colors.white, fontSize: 18),
  //           ),
  //         ),
  //       ],
  //     ),
  //   ]);
  // }
  //
  // void showTutorial() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final context = Get.context;
  //
  //     if (context != null) {
  //       final overlay = Overlay.of(context);
  //       if (overlay != null) {
  //         TutorialCoachMark(
  //           targets: targets,
  //           colorShadow: Colors.green,
  //           textSkip: "SKIP",
  //           paddingFocus: 10,
  //           opacityShadow: 0.8,
  //           onFinish: () {
  //             print("Finish");
  //           },
  //           onClickTarget: (target) {
  //             print('onClickTarget: $target');
  //           },
  //           onClickOverlay: (target) {
  //             print('onClickOverlay: $target');
  //           },
  //           onSkip: () {
  //             print("Skip");
  //             return true;
  //           },
  //         ).show(context: context);
  //       } else {
  //         print("Overlay not available");
  //       }
  //     } else {
  //       print("Context is null");
  //     }
  //   });
  // }


  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  Future<String?>getFarmerId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    farmerId = (prefs.getString('farmerId'));
    log("farmer id ${farmerId}");
    return farmerId;
  }

  void fetchFarmerDetails() async {
    farmerDetailsLoader.value = true;
    final url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.getFarmerDetails}?user_id=$farmerId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
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