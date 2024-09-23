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
        ? Get.offAll(()=>FarmerHomeScreen())
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
        title: Text('Rewards', style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Bitter', color: Colors.white),),
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
                      Image.asset('assets/images/coins.png', height: 100),
                      // Make sure to add this image to your assets
                      SizedBox(height: 20),
                      Text(
                        'Congratulations!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Bitter"
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      Text(
                        'Bravo! You were awarded ${controller.coins} Coins.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, fontFamily: "NotoSans", fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'Get additional coins by finishing the next Stages!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, fontFamily: "NotoSans", fontWeight: FontWeight.w400),
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
                  buttonColor: Colors.white, onPress: () { controller.onContinuePressed(); }, widget: Text('CONTINUE', style: TextStyle(fontSize: 15, fontFamily: "NotoSans", fontWeight: FontWeight.w500, color: Colors.green),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
