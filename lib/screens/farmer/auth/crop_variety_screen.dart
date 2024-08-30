import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/farmer/farmer_address_controller.dart';
import 'package:fpo_assist/screens/farmer/auth/farmer_address_detail.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';

import '../../../controllers/farmer/crop_variety_controller.dart';
import '../../../models/select_crop_model.dart';
import '../../../widgets/custom_elevated_button.dart';

class CropVarietyScreen extends StatelessWidget {
  RxList<Crop> selectedCrops;
  CropVarietyScreen({super.key, required this.selectedCrops});

  final CropVarietyController controller = Get.put(CropVarietyController());

  @override
  Widget build(BuildContext context) {
    if (selectedCrops.isNotEmpty) {
      controller.fetchCropVarieties(selectedCrops[0].id);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Crop_variety'.tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Bitter'),
        ),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.separated(
                    itemCount: controller.cropVarieties.length,
                    itemBuilder: (context, index) {
                      var variety = controller.cropVarieties[index];
                      return
                        ListTile(
                        onTap: () {
                          Get.to(FarmerAddressDetail(
                              selectedCrops: selectedCrops,
                              cropVariety: variety.varietyId));
                        },
                        title: Text(
                          variety.variety,
                          style: TextStyle(
                              fontFamily: "Bitter",
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 20,
                      );
                    },
                  );
                }
              }),
            ),
            SizedBox(
              height: 24,
            ),
            CustomElevatedButton(
              buttonColor: Color(0xff00B251),
              onPress: () {
                Get.to(FarmerAddressDetail(selectedCrops: selectedCrops));
              },
              widget: Text(
                "Skip".tr,
                style: TextStyle(
                    fontFamily: 'NotoSans',
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
