import 'package:flutter/material.dart';
import 'package:fpo_assist/screens/farmer/production/vegetable_production/vegetable_production_screen.dart';
import 'package:fpo_assist/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';

import '../../dashboard/farmer_home_screen.dart';

class RewardsController extends GetxController {
  final int coins;
  final int landId;
  final int filterId;
  final bool isLast;

  RewardsController(
      {required this.coins,
      required this.landId,
      required this.filterId,
      required this.isLast});

  void onContinuePressed() {
    isLast
        ? Get.offAll(() => FarmerHomeScreen())
        : Get.off(() => VegetableStagesScreen(
              landId: landId,
              filterId: filterId,
            ));
  }
}

class RewardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RewardsController controller = Get.find<RewardsController>();

    return Scaffold(
      backgroundColor: Color(0xFF4CAF50),
      appBar: AppBar(
        backgroundColor: Color(0xFF4CAF50),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Rewards'.tr,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'GoogleSans',
              color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/coins.png', height: 60),
                      // Make sure to add this image to your assets
                      SizedBox(height: 20),
                      Text(
                        'Congratulations'.tr,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: "GoogleSans"),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "GoogleSans",
                            fontWeight: FontWeight.w400,
                            color: Colors
                                .black, // You can set a default color for the text
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Bravo_You_were_awarded'.tr,
                            ),
                            TextSpan(
                              text: '${controller.coins} ',
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold, // Bold for the coins part
                                color: Colors.blue, // Change color as needed
                              ),
                            ),
                            TextSpan(
                              text: 'Coins'.tr,
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold, // Bold for the coins part
                                color: Colors.blue, // Change color as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Get_additional_coins_by_finishing_the_next_Stages'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: "GoogleSans",
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  buttonColor: Colors.white,
                  onPress: () {
                    controller.onContinuePressed();
                  },
                  widget: Text(
                    'continue'.tr,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.w500,
                        color: Colors.green),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
