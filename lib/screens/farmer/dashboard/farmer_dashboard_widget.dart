import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fpo_assist/controllers/farmer/dashboard_controller.dart';
import 'package:fpo_assist/controllers/fpo/fpo_home_controller.dart';
import 'package:fpo_assist/screens/farmer/detect_disease/select_service_provider.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controllers/farmer/coach_marks_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../../utils/color_constants.dart';
import '../../../widgets/custom_home_card.dart';
import '../crop_suggstion/crop_suggestion.dart';
import '../fertilier_calculator/farm_for_fertilizer.dart';
import '../gov_scheme/gov_scheme.dart';
import '../news/all_news.dart';
import '../news/single_news.dart';
import '../weather/weather_detailed_screen.dart';

class FarmerDashboardWidget extends StatelessWidget {
  FarmerDashboardController controller = Get.put(FarmerDashboardController());
  CoachMarksController coachMarksController = Get.put(CoachMarksController());

  final List<String> imgList = [
    'assets/images/carousel_home.png',
    'assets/images/carousel_home.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: PrimaryScrollController(
        controller: coachMarksController.scrollController,
        child: Scrollable(
          viewportBuilder: (BuildContext context, ViewportOffset position) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 2,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      key: coachMarksController.farmCoachKey,
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Farms".tr,
                        style: const TextStyle(
                            fontFamily: "Bitter",
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Obx(() {
                              return controller.farmerLandLoader.value
                                  ? Shimmer.fromColors(
                                baseColor: const Color(0xffDFF9ED),
                                highlightColor: const Color(0xffF1FBF2),
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 36,
                                      width: 100,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      width: 10,
                                    );
                                  },
                                ),
                              )
                                  : ListView.separated(
                                scrollDirection: Axis.horizontal,
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
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                            '${farmerLands![index].address}',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "NotoSans"),
                                          )),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    width: 10,
                                  );
                                },
                              );
                            }),
                          ),
                          Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: const Color(0xffCBD5E1))),
                              child: const Icon(
                                Icons.add,
                                size: 24,
                              ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 2,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: controller.farmerLandLoader.value
                          ? Shimmer.fromColors(
                        baseColor: const Color(0xffDFF9ED),
                        highlightColor: const Color(0xffF1FBF2),
                        child: Container(
                          width: double.infinity,
                          height: 66,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      )
                          : Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: const Color(0xffBAEDBD))),
                        child: Row(
                          children: [
                            Text(
                              "${controller.cropName}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Bitter"),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Get.to(() =>
                                    WeatherDetailScreen(
                                        districtName: controller.districtName.value));
                              },
                              child: Row(
                                key: coachMarksController.weatherCoachKey,
                                children: [
                                  Text(
                                    controller.temperature.value,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Bitter"),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Image.network(
                                    controller.weatherIcon.value,
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Image.asset("assets/images/farmer_home_banner.png"),
                    // child: controller.userLanguage == 1 ? Image.asset("assets/images/farmer_home_banner.png") : Image.asset("assets/images/farmer_home_banner_hindi.png"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xfdfF1FBF2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Services".tr,
                        style: const TextStyle(
                            fontFamily: "Bitter",
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          key: coachMarksController.productionCoachKey,
                          children: [
                            Image.asset(
                              "assets/images/production.png",
                              height: 40,
                              width: 40,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Production".tr,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "NotoSans"),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(FarmForFertilizer());
                          },
                          child: Column(
                            key: coachMarksController.fertilizerCoachKey,
                            children: [
                              Image.asset(
                                "assets/images/fertilizer_calci.png",
                                height: 40,
                                width: 40,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Fertilizer_Calculator".tr,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "NotoSans"),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => SelectServiceProvider());
                          },
                          child: Column(
                            key: coachMarksController.detectCoachKey,
                            children: [
                              Image.asset(
                                "assets/images/detect_disease.png",
                                height: 40,
                                width: 40,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Detect_Disease".tr,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "NotoSans"),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xfdfF1FBF2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Soil_Test_Today_Harvest_Tomorrow".tr,
                            style: const TextStyle(
                                fontFamily: "Bitter",
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Don't_leave_your_farming_success_to_chance_know_your_soil_grow_your_future"
                                          .tr,
                                      style: const TextStyle(
                                          fontFamily: "NotoSans",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      key: coachMarksController.soilCoachKey,
                                      height: 42,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorConstants.primaryColor,
                                            width: 1),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Book_Now".tr,
                                          style: TextStyle(
                                              color: ColorConstants.primaryColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'NotoSans'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                "assets/images/soil_test_and_harvest.png",
                                width: 48,
                                height: 50,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xfdfF1FBF2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Other_Services".tr,
                        style: const TextStyle(
                            fontFamily: "Bitter",
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/farmer_economics.png",
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Farmer_Economics".tr,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "NotoSans"),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/irrigation_alarm.png",
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Irrigation_Alarm".tr,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "NotoSans"),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/soil_testing.png",
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Soil_Testing".tr,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "NotoSans"),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => SchemeListView());
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/gov_schemes.png",
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "gov_scheme".tr,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "NotoSans"),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(CropSuggestion());
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/crop_suggestion.png",
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "crop_suggestion".tr,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "NotoSans"),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                                child: Container(
                                  height: 40,
                                  width: 40,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xfdfF1FBF2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Helpline".tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Bitter'),
                              ),
                              Text(
                                "Check_number_for_assistance_and_support".tr,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                    color: Colors.black,
                                    fontFamily: 'NanoSans',
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Image.asset(
                            key: coachMarksController.helplineCoachKey,
                            "assets/images/helpline_farmer.png",
                            width: 40,
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: controller.newsLoader.value
                          ? Shimmer.fromColors(
                        baseColor: const Color(0xffDFF9ED),
                        highlightColor: const Color(0xffF1FBF2),
                        child: Container(
                          width: double.infinity,
                          height: 37,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      )
                          : controller.articles.isNotEmpty
                          ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xfdfF1FBF2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "News".tr,
                              style: const TextStyle(
                                  fontFamily: "Bitter",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(NewsListView());
                              },
                              child: Text(
                                "View_All".tr,
                                style: TextStyle(
                                    color: ColorConstants.primaryColor,
                                    fontFamily: "NanoSans",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      )
                          : const SizedBox.shrink(),
                    );
                  }),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      height: 192,
                      child: Obx(() {
                        return controller.newsLoader.value
                            ? Shimmer.fromColors(
                          baseColor: const Color(0xffDFF9ED),
                          highlightColor: const Color(0xffF1FBF2),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    height: 96,
                                    width: 155,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 12,
                                    width: 155,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    height: 12,
                                    width: 155,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 18);
                            },
                          ),
                        )
                            : controller.articles.isNotEmpty
                            ? ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.articles.length,
                            itemBuilder: (context, index) {
                              final article =
                              controller.articles[index];
                              return InkWell(
                                onTap: () {
                                  Get.to(() => SingleNewsScreen(article: article));
                                },
                                child: Container(
                                  width: 155,
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                        "${ApiEndPoints.imageBaseUrl}${article.image ??
                                            ""}",
                                        imageBuilder:
                                            (context, imageProvider) =>
                                            Container(
                                              height: 96,
                                              width: 155,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                color: Colors.black,
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                        placeholder: (context, url) =>
                                        const SizedBox(
                                            height: 10,
                                            width: 10,
                                            child:
                                            CircularProgressIndicator(
                                              strokeAlign: 2,
                                              strokeWidth: 2,
                                            )),
                                        errorWidget: (context, url, error) =>
                                            SizedBox(
                                              height: 96,
                                              width: 155,
                                              child: Image.asset(
                                                  "assets/images/news_placeholder.png"),
                                            ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        article.title ?? "",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: "NotoSans",
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff1C1C1C),
                                        ),
                                        maxLines: 2,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        article.publishDate ?? "",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: "NotoSans",
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff1C1C1C),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 18);
                            })
                            : const SizedBox.shrink();
                      }),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
