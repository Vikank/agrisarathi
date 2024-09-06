import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/farmer/dashboard_controller.dart';
import 'package:fpo_assist/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';

import '../../../utils/api_constants.dart';
import '../add_farm/add_farm_land.dart';

class MyFarmsWidget extends StatelessWidget {
  FarmerDashboardController controller = Get.put(FarmerDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Obx(() {
            return Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount:
                controller.farmerLands.value.data!.length,
                itemBuilder: (context, index) {
                  final farmerLands =
                      controller.farmerLands.value.data;
                  return GestureDetector(
                    onTap: () {
                      controller.cropName.value =
                          farmerLands[index].crop ?? "";
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, bottom: 16, left: 24, right: 45),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                            farmerLands![index].cropImages!.isNotEmpty
                                ? "${ApiEndPoints.imageBaseUrl}${farmerLands[index]
                                .cropImages?.first ?? ""}"
                                : "",
                            imageBuilder:
                                (context, imageProvider) =>
                                Container(
                                  height: 92,
                                  width: 89,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(4),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                            placeholder: (context, url) =>
                            const SizedBox(
                                height: 46,
                                width: 46,
                                child:
                                CircularProgressIndicator(
                                  strokeAlign: 1,
                                  strokeWidth: 1,
                                )),
                            errorWidget: (context, url, error) =>
                                SizedBox(
                                  height: 92,
                                  width: 89,
                                  child: Image.asset(
                                      "assets/images/news_placeholder.png"),
                                ),
                          ),
                          SizedBox(width: 22,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${farmerLands![index].crop}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Bitter"),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  '${farmerLands![index].address ??
                                      ""},${farmerLands![index].village ??
                                      ""},${farmerLands![index].district ??
                                      ""},${farmerLands![index].state ?? ""}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NotoSans"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder:
                    (BuildContext context, int index) {
                  return const Divider(
                    thickness: 2,
                    height: 2,
                    color: Color(0xff959CA3),
                  );
                },
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomElevatedButton(
                buttonColor: Color(0xff00B251), onPress: () {
              Get.to(() => AddFarmLand());
            }, widget: Text("ADD FARM LAND")),
          )
        ],
      ),
    );
  }
}
