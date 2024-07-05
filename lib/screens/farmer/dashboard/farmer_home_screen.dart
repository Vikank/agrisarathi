import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fpo_assist/controllers/farmer/farmer_home_controller.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'farmer_community_widget.dart';
import 'farmer_dashboard_widget.dart';
import 'farmer_mandi_widget.dart';
import 'my_farms_widget.dart';

class FarmerHomeScreen extends StatelessWidget {
  FarmerHomeController controller = Get.put(FarmerHomeController());

  static List<Widget> _widgetOptions = <Widget>[
    FarmerDashboardWidget(),
    const MyFarmsWidget(),
    FarmerCommunityWidget(),
    FarmerMandiWidget(),
  ];

  static List<Widget> _textOptions = <Widget>[
    const Text("Agri Sarthi"),
    const Text("Community"),
    const Text("Mandi"),
    const Text("Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Obx(() {
          return _textOptions.elementAt(controller.selectedIndex.value);
        }),
        actions: [
          Obx(() {
            final farmerDetails = controller
                .farmerDetails.value.data;
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: [
                  controller.farmerDetailsLoader.value ? Shimmer.fromColors(
                    baseColor: const Color(0xffDFF9ED),
                    highlightColor: const Color(0xffF1FBF2),
                child: Container(
                  width: 60,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(100),),
                  ),
                ),
              ) : farmerDetails.isNotEmpty ? Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(100),),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/coin.png",
                          height: 24,
                          width: 24,
                        ),
                        Text(
                          "${farmerDetails[0].coins}",
                          style: const TextStyle(
                              fontFamily: 'NotoSans',
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ) : const SizedBox.shrink(),
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
            );
          })
        ],
      ),
      body: Obx(() {
        return _widgetOptions.elementAt(controller.selectedIndex.value);
      }),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Row(
                children: [
                  Image.asset("assets/images/logo.png", height: 40,),
                  const Spacer(),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                      child: const Icon(Icons.close, size: 24,))
                ],
              ),
              const SizedBox(height: 24,),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Image.asset("assets/images/diagnosis.png", width: 20, height: 20,),
                title: Text('Home'.tr),
                onTap: () {
                  controller.updateSelectedIndex(0);
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.group),
                title: Text('Community'.tr),
                onTap: () {
                  controller.updateSelectedIndex(1);
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.store),
                title: Text('Mandi'.tr),
                onTap: () {
                  controller.updateSelectedIndex(2);
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.person),
                title: Text('Profile'.tr),
                onTap: () {
                  controller.updateSelectedIndex(3);
                  Navigator.pop(context); // Close the drawer
                },
              ),
            ],
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
                    ? "assets/icons/profile_sel.png"
                    : "assets/icons/profile_unsel.png",
                width: 24,
                height: 24,
              ),
              label: 'Profile'.tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
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
