import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/farmer/dashboard_controller.dart';
import 'package:fpo_assist/screens/farmer/detect_disease/select_crop_part.dart';
import 'package:get/get.dart';

import '../../../utils/api_constants.dart';
import '../../shared/select_crop_screen.dart';
import 'choose_another_crop.dart';

class ChooseFarmLand extends StatelessWidget {
  final int serviceProviderId;
  ChooseFarmLand(this.serviceProviderId, {super.key});

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
                    Get.to(SelectCropPart(
                        serviceProviderId: serviceProviderId,
                        cropId: farmLand.cropId!,
                        cropName: farmLand.crop!,
                        cropImage: farmLand.cropImages![0],
                        landId: "$farmLand.id!"));
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
                          "http://64.227.166.238:8000${farmLand.cropImages![0] ?? ""}",
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
                          placeholder: (context, url) =>
                          const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),),
                          errorWidget: (context, url, error) =>
                              Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff002833d)
                                        .withOpacity(0.06),
                                    borderRadius:
                                    BorderRadius.circular(3),
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
                Get.to(ChooseAnotherCrop(serviceProviderId: serviceProviderId));
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
