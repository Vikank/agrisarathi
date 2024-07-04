import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/farmer/dashboard_controller.dart';
import 'package:get/get.dart';

import '../../../utils/api_constants.dart';

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
          "Farm land",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Farms",
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
                    Get.to(SelectCropPart(
                        serviceProviderId: serviceProviderId,
                        cropId: farmLand.cropId!,
                        cropName: farmLand.crop!,
                        cropImage: farmLand.cropImages![0],
                        landId: farmLand.id!));
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
                        Image.network(
                          '${ApiEndPoints.baseUrl}${farmLand.cropImages![0] ?? ""}',
                          width: 52,
                          height: 52,
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
                Get.to(SelectCropScreen(serviceProviderId: serviceProviderId));
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
                    "Another crop",
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
