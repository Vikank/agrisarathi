import 'package:flutter/material.dart';
import 'package:fpo_assist/utils/color_constants.dart';
import 'package:fpo_assist/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';

import '../../../controllers/farmer/fertilizer_calci_controller.dart';
import 'fertilizer_calci_result.dart';

class FertilizerCalci extends StatelessWidget {
  int? cropId;
  int? landId;
  FertilizerCalci({this.cropId, this.landId, super.key});

  FertilizerCalciController controller = Get.put(FertilizerCalciController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Fertilizer_calculator".tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("N"),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: controller.nitrogenValue,
                  decoration: InputDecoration(
                    hintText: "Value",
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text("P"),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: controller.phosphorousValue,
                  decoration: InputDecoration(
                    hintText: "Value",
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text("K"),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: controller.potassiumValue,
                  decoration: InputDecoration(
                    hintText: "Value",
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomElevatedButton(
              buttonColor: ColorConstants.primaryColor,
              onPress: () async {
                try {
                  final fertilizerData = await controller.fetchFertilizerData();
                  Get.to(FertilizerResultScreen(fertilizerData: fertilizerData));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              },
              widget: Text(
                "NEXT",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: "NotoSans"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
