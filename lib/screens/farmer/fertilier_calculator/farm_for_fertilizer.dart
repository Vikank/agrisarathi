import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/farmer/dashboard_controller.dart';
import 'package:fpo_assist/screens/farmer/detect_disease/select_crop_part.dart';
import 'package:fpo_assist/utils/color_constants.dart';
import 'package:get/get.dart';

import '../../../controllers/farmer/fertilizer_calci_controller.dart';
import 'another_crop_fetrilizer.dart';
import 'fertilizer_calci.dart';
import 'fertilizer_recommended_screen.dart';

class FarmForFertilizer extends StatelessWidget {
  FarmerDashboardController controller = Get.put(FarmerDashboardController());
  FertilizerCalciController fertilizerCalciController = Get.put(FertilizerCalciController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Farm_land".tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "farms".tr,
              style: TextStyle(
                fontFamily: "Bitter",
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            ListView.separated(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.farmerLands.value.data!.length,
              itemBuilder: (context, index) {
                var farmLand = controller.farmerLands.value.data![index];
                log("image ${farmLand.cropImages![0]}");
                return GestureDetector(
                  onTap: () {
                    log("${farmLand.id!}");
                    Get.dialog(
                      Dialog(
                        child: Container(
                          color: Colors.white,
                          height: 144,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Have you got your soil tested?",
                                style: TextStyle(
                                    fontFamily: "Bitter",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: ElevatedButton(
                                      onPressed: () async{
                                        Get.back(); // Close the dialog
                                        await fertilizerCalciController.fetchRecommendedFertilizerData(); // Fetch data
                                        Get.to(() => FertilizerRecommendedrScreen()); // Navigate to calculator screen
                                      },
                                      child: Text("NO", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: "NotoSans"
                                      ),),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0XFFE0E0E0),
                                        foregroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16,),
                                  SizedBox(
                                    height: 30,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.to(FertilizerCalci(
                                            landId: farmLand.id));
                                      },
                                      child: Text("YES", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          fontFamily: "NotoSans"
                                      ),),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorConstants.primaryColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              "https://api.agrisarathi.com/api/${farmLand.cropImages![0] ?? ""}",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.low,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xff002833d).withOpacity(0.06),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: const Icon(Icons.error)),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${farmLand.crop ?? ""}",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "NotoSans",
                                  color: Colors.black),
                            ),
                            Text(
                              "${farmLand.address ?? ""}",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "NotoSans"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 16,
                );
              },
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                Get.to(AnotherCropFetrilizer());
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Another_crop".tr,
                    style: TextStyle(
                        fontFamily: "NotoSans",
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
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
