import 'package:flutter/material.dart';
import 'package:fpo_assist/screens/farmer/fertilier_calculator/advance_result_screen.dart';
import 'package:get/get.dart';
import '../../../controllers/farmer/advance_fertilizer_calci.dart';
import '../../../utils/color_constants.dart';
import '../../../widgets/custom_elevated_button.dart';

class AdvancedFertilizerCalculatorScreen extends StatelessWidget {
  int? cropId;
  int? landId;
  final controller = Get.put(AdvancedFertilizerCalculatorController());

  AdvancedFertilizerCalculatorScreen({required this.cropId, this.landId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Fertilizer_Calculator".tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "GoogleSans"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInputSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.green[50], borderRadius: BorderRadius.circular(5)),
          child: Text(
            'Fertilizer_in_kg'.tr,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: "GoogleSans"),
          ),
        ),
        SizedBox(height: 10),
        _buildInputField('DAP'.tr, controller.daep),
        _buildInputField('Complex_17'.tr, controller.complexes),
        _buildInputField('Urea'.tr, controller.urea),
        _buildInputField('SSP'.tr, controller.ssp),
        _buildInputField('MOP'.tr, controller.mop),
        SizedBox(height: 20),
        Obx(
          () => CustomElevatedButton(
            buttonColor: ColorConstants.primaryColor,
            onPress: controller.isLoading.value
                ? null
                : () => controller.calculateFertilizer(cropId, landId).then((ele){
                  Get.to(AdvanceResultScreen(controller: controller));
            }),
            widget: Text(
              "Calculate".tr,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: "GoogleSans"),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(String label, RxString value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        onChanged: (newValue) => value.value = newValue,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: label,
            hintText: "0",
            labelStyle: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "GoogleSans")
            // border: OutlineInputBorder(),
            ),
      ),
    );
  }

}
