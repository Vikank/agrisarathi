import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpo_assist/screens/farmer/production/vegetable_production/select_sowing.dart';
import 'package:fpo_assist/screens/farmer/production/vegetable_production/vegetable_production_screen.dart';
import 'package:get/get.dart';

import '../../../controllers/farmer/dashboard_controller.dart';
import '../../../utils/api_constants.dart';
import 'choose_crop_category.dart';

class ChooseFarmProduction extends StatelessWidget {
  FarmerDashboardController controller = Get.put(FarmerDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Farm_land".tr,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: "GoogleSans"),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: controller.fetchFarmerLands,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                "farms".tr,
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Obx(() {
                return ListView.separated(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.farmerLands.value.data!.length,
                  itemBuilder: (context, index) {
                    var farmLand = controller.farmerLands.value.data![index];
                    log("image ${farmLand.cropImages![0]}");
                    return GestureDetector(
                      onTap: () {
                        if (farmLand.isCompleted == true) {
                          Fluttertoast.showToast(msg: "Already completed");
                        } else {
                          if (farmLand.preference == true) {
                            Get.to(() => VegetableStagesScreen(
                                  landId: farmLand.id!,
                                  filterId: farmLand.filterId!,
                                ));
                          } else {
                            Get.to(() => SelectSowing(
                                  landId: farmLand.id!,
                                  filterId: farmLand.filterId!,
                                ));
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  "${ApiEndPoints.imageBaseUrl}${farmLand.cropImages![0] ?? ""}",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                                    color: const Color(0xff002833d)
                                        .withOpacity(0.06),
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
                                      fontFamily: "GoogleSans",
                                      color: Colors.black),
                                ),
                                Text(
                                  "${farmLand.address ?? ""}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "GoogleSans"),
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
                );
              }),
              SizedBox(
                height: 16,
              ),
              // GestureDetector(
              //   onTap: () {
              //     Get.to(AnotherCropFetrilizer());
              //   },
              //   child: Container(
              //     padding: EdgeInsets.symmetric(vertical: 25, horizontal: 12),
              //     decoration: BoxDecoration(
              //       border: Border.all(width: 1, color: Colors.grey),
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(10),
              //       ),
              //     ),
              //     child: Center(
              //       child: Text(
              //         "Another_crop".tr,
              //         style: TextStyle(
              //             fontFamily: "GoogleSans",
              //             fontSize: 12,
              //             fontWeight: FontWeight.w500),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
