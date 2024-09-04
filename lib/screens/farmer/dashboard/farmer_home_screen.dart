import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fpo_assist/controllers/farmer/farmer_home_controller.dart';
import 'package:fpo_assist/screens/farmer/diagnosis/disease_detection_history.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../controllers/farmer/coach_marks_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../profile/profile_screen.dart';
import 'farmer_community_widget.dart';
import 'farmer_dashboard_widget.dart';
import 'farmer_mandi_widget.dart';
import 'my_farms_widget.dart';

class FarmerHomeScreen extends StatelessWidget {
  FarmerHomeController controller = Get.put(FarmerHomeController());
  ProfileController profileController = Get.put(ProfileController());
  CoachMarksController coachMarksController = Get.put(CoachMarksController());

  static List<Widget> _widgetOptions = <Widget>[
    FarmerDashboardWidget(),
    MyFarmsWidget(),
    CommunityForumScreen(),
    FarmerMandiWidget(),
  ];

  static List<Widget> _textOptions = <Widget>[
    Text("agrisarthi".tr),
    Text("Farm_land".tr),
    Text("Community".tr),
    Text("Mandi".tr),
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(!controller.userExist){
        log("truee hua user exist${controller.userExist}");
        coachMarksController.showTutorial(context);
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Obx(() {
          return _textOptions.elementAt(controller.selectedIndex.value);
        }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Obx(() {
                  if (controller.farmerDetailsLoader.value) {
                    // Show loader while data is loading
                    return Shimmer.fromColors(
                      baseColor: const Color(0xffDFF9ED),
                      highlightColor: const Color(0xffF1FBF2),
                      child: Container(
                        width: 60,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                      ),
                    );
                  }

                  if (controller.farmerDetails.value == null) {
                    // Show an error message or empty state if there's no data
                    return Center(child: Text('No data available'));
                  }
                  final farmerDetails = controller.farmerDetails.value!.data;
                  return Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/coin.png",
                          height: 24,
                          width: 24,
                        ),
                        Text(
                          "${farmerDetails?.coins ?? ""}",
                          style: const TextStyle(
                              fontFamily: 'NotoSans',
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(
                  width: 15,
                ),
                Image.asset(
                  "assets/icons/announcements.png",
                  height: 24,
                  width: 24,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Obx(() {
        return _widgetOptions.elementAt(controller.selectedIndex.value);
      }),
      drawer: SafeArea(
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      height: 40,
                    ),
                    const Spacer(),
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.close,
                          size: 24,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Image.asset(
                    "assets/images/diagnosis.png",
                    width: 20,
                    height: 20,
                  ),
                  title: Text(
                    'Diagnosis'.tr,
                    style: TextStyle(
                        fontFamily: "Bitter",
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  onTap: () {
                    Get.to(() => DiseaseDetectionHistory());
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Image.asset(
                    "assets/images/leaderboard.png",
                    width: 20,
                    height: 20,
                  ),
                  title: Text(
                    'Rewards'.tr,
                    style: TextStyle(
                        fontFamily: "Bitter",
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  onTap: () {
                    controller.updateSelectedIndex(1);
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Image.asset(
                    "assets/images/crop_suggestion.png",
                    width: 20,
                    height: 20,
                  ),
                  title: Text(
                    'Crop_Suggestion'.tr,
                    style: TextStyle(
                        fontFamily: "Bitter",
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  onTap: () {
                    controller.updateSelectedIndex(2);
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Image.asset(
                    "assets/images/profile.png",
                    width: 20,
                    height: 20,
                  ),
                  title: Text(
                    'Profile'.tr,
                    style: TextStyle(
                        fontFamily: "Bitter",
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  onTap: () {
                    Get.to(() => ProfileScreen());
                  },
                ),
                Spacer(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Image.asset(
                    "assets/images/logout.png",
                    width: 20,
                    height: 20,
                  ),
                  title: Text(
                    'Log out'.tr,
                    style: TextStyle(
                        fontFamily: "Bitter",
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  onTap: () {
                    profileController.logout();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(
                controller.selectedIndex.value == 0
                    ? "assets/icons/home_sel.png"
                    : "assets/icons/home_unsel.png",
                width: 24,
                height: 24,
              ),
              label: 'Home'.tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                controller.selectedIndex.value == 1
                    ? "assets/icons/my_farms_sel.png"
                    : "assets/icons/my_farms_unsel.png",
                width: 24,
                height: 24,
              ),
              label: 'My Farms'.tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                key: coachMarksController.communityCoachKey,
                controller.selectedIndex.value == 2
                    ? "assets/icons/community_sel.png"
                    : "assets/icons/community_unsel.png",
                width: 24,
                height: 24,
              ),
              label: 'Community'.tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                key: coachMarksController.mandiCoachKey,
                controller.selectedIndex.value == 3
                    ? "assets/icons/shop_sel.png"
                    : "assets/icons/shop_unsel.png",
                width: 24,
                height: 24,
              ),
              label: 'Mandi'.tr,
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(
              color: Colors.green,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto'),
          unselectedLabelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto'),
          onTap: controller.updateSelectedIndex,
        );
      }),
    );
  }
}
