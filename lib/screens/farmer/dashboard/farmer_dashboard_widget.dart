import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpo_assist/controllers/farmer/dashboard_controller.dart';
import 'package:fpo_assist/controllers/fpo/fpo_home_controller.dart';
import 'package:fpo_assist/screens/farmer/detect_disease/select_service_provider.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controllers/farmer/coach_marks_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../../models/weatherNotificationModel.dart';
import '../../../utils/color_constants.dart';
import '../../../widgets/custom_home_card.dart';
import '../crop_suggstion/crop_suggestion.dart';
import '../fertilier_calculator/farm_for_fertilizer.dart';
import '../gov_scheme/gov_scheme.dart';
import '../news/all_news.dart';
import '../news/single_news.dart';
import '../production/choose_farm_production.dart';
import '../weather/weather_detailed_screen.dart';
import 'dashboard_widgets/vegetable_progress_carousel.dart';

class FarmerDashboardWidget extends StatelessWidget {
  // FarmerDashboardController controller = Get.put(FarmerDashboardController());
  CoachMarksController coachMarksController = Get.put(CoachMarksController());
  final CarouselSliderController _controller = CarouselSliderController();

  final List<String> imgList = [
    'assets/images/carousel_home.png',
    'assets/images/carousel_home.png',
  ];

  @override
  Widget build(BuildContext context) {
    FarmerDashboardController controller = Get.put(FarmerDashboardController());
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
                  SizedBox(
                    height: 16,
                  ),
                  Obx(() {
                    return controller.farmerLandLoader.value
                        ? SizedBox(
                            height: 150,
                            child: Column(
                              children: [
                                Container(
                                  height: 56,
                                  child: Shimmer.fromColors(
                                    baseColor: const Color(0xffDFF9ED),
                                    highlightColor: const Color(0xffF1FBF2),
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 56,
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
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 56,
                                  child: Shimmer.fromColors(
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
                                  ),
                                )
                              ],
                            ),
                          )
                        : controller.farmerLands.value.data!.isEmpty
                            ? SizedBox.shrink()
                            : Column(
                                children: [
                                  // Farmland Carousel
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    width: double.infinity,
                                    child: SizedBox(
                                      height:
                                          56, // Adjust the height according to your needs
                                      child: CarouselSlider(
                                        items: controller
                                            .farmerLands.value.data!
                                            .asMap()
                                            .entries
                                            .map(
                                          (entry) {
                                            final item = entry.value;
                                            return Container(
                                              height: 56,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                color: Color(0xffDFF1E6),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Land '.tr +
                                                      '${controller.currentCarousel.value + 1}' +
                                                      ' : ' +
                                                      '${item.district}, ${item.state ?? "State"}',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "NotoSans"),
                                                ),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                        carouselController: _controller,
                                        options: CarouselOptions(
                                          height: double.infinity,
                                          enlargeCenterPage: false,
                                          viewportFraction: 1,
                                          autoPlay: true,
                                          enableInfiniteScroll: false,
                                          onPageChanged: (index, reason) {
                                            controller.currentCarousel.value =
                                                index;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),

                                  // Weather Data Carousel
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    width: double.infinity,
                                    child: SizedBox(
                                      height:
                                          56, // Adjust the height according to your needs
                                      child: CarouselSlider(
                                        items: controller
                                            .farmerLands.value.data!
                                            .asMap()
                                            .entries
                                            .map(
                                          (entry) {
                                            final item = entry.value;
                                            final weatherData = controller
                                                .landWeatherData[item.district];

                                            return weatherData != null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      Get.to(() =>
                                                          WeatherDetailScreen(
                                                              districtName:
                                                                  item.district ??
                                                                      ""));
                                                    },
                                                    child: Container(
                                                      height: 56,
                                                      width: double.infinity,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xffBAEDBD)),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Text(
                                                            item.crop ?? "",
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    "Bitter"),
                                                          ),
                                                          Spacer(),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                weatherData[
                                                                        'temperature'] ??
                                                                    '',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        "Bitter"),
                                                              ),
                                                              const SizedBox(
                                                                  width: 5),
                                                              Image.network(
                                                                weatherData[
                                                                        'weatherIcon'] ??
                                                                    '',
                                                                width: 40,
                                                                height: 40,
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
                                                              const Icon(
                                                                Icons
                                                                    .arrow_forward_ios_rounded,
                                                                size: 15,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox.shrink();
                                          },
                                        ).toList(),
                                        carouselController: _controller,
                                        options: CarouselOptions(
                                          height: double.infinity,
                                          enlargeCenterPage: false,
                                          viewportFraction: 1,
                                          autoPlay: true,
                                          enableInfiniteScroll: false,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),

                                  // Notification Carousel
                                  controller.notificationsData.isNotEmpty
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height:
                                                    94, // Adjust the height according to your needs
                                                width: double.infinity,
                                                child: CarouselSlider(
                                                  items: controller
                                                      .farmerLands.value.data!
                                                      .asMap()
                                                      .entries
                                                      .map(
                                                    (entry) {
                                                      final item = entry.value;
                                                      final relevantResults =
                                                          controller
                                                              .notificationsData
                                                              .firstWhere(
                                                        (result) =>
                                                            result.cropId ==
                                                            item.cropId,
                                                        orElse: () => Results(),
                                                      );
                                                      final notification =
                                                          relevantResults
                                                              .notifications
                                                              ?.firstWhere(
                                                        (notif) =>
                                                            notif.cropId ==
                                                            item.cropId,
                                                        orElse: () =>
                                                            Notifications(),
                                                      );

                                                      return notification
                                                                  ?.gif !=
                                                              null
                                                          ? Image.network(
                                                              '${ApiEndPoints.imageBaseUrl}${notification!.gif}',
                                                              width: double
                                                                  .infinity,
                                                              fit: BoxFit.fill,
                                                            )
                                                          : const SizedBox
                                                              .shrink();
                                                    },
                                                  ).toList(),
                                                  carouselController:
                                                      _controller,
                                                  options: CarouselOptions(
                                                    height: double.infinity,
                                                    enlargeCenterPage: false,
                                                    viewportFraction: 1,
                                                    autoPlay: true,
                                                    enableInfiniteScroll: false,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 16),
                                            ],
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                  // Progress Carousel
                                  controller.vegetableProgress.value
                                              ?.cropsProgress ==
                                          null
                                      ? SizedBox.shrink()
                                      : SizedBox(
                                          height: 56,
                                          child: CropProgressCarousel(),
                                        ),
                                ],
                              );
                  }),
                  SizedBox(height: 16),
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
                        GestureDetector(
                          onTap: () {
                            Get.to(() => ChooseFarmProduction());
                          },
                          child: Column(
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
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => FarmForFertilizer());
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
                                "Fertilizer_Calculator_home".tr,
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
                                "Detect_Disease_home".tr,
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
                                    GestureDetector(
                                      onTap: () {
                                        Fluttertoast.showToast(
                                          msg: "Coming Soon",
                                          toastLength: Toast.LENGTH_SHORT,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                        );
                                      },
                                      child: Container(
                                        key: coachMarksController.soilCoachKey,
                                        height: 42,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  ColorConstants.primaryColor,
                                              width: 1),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(4),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Book_Now".tr,
                                            style: TextStyle(
                                                color:
                                                    ColorConstants.primaryColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'NotoSans'),
                                          ),
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
                            GestureDetector(
                              onTap: () {
                                Fluttertoast.showToast(
                                  msg: "Coming Soon",
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                );
                              },
                              child: Column(
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
                                    "Farmer_Economics_home".tr,
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
                                Fluttertoast.showToast(
                                  msg: "Coming Soon",
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                );
                              },
                              child: Column(
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
                                    "Irrigation_Alarm_home".tr,
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
                                Fluttertoast.showToast(
                                  msg: "Coming Soon",
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                );
                              },
                              child: Column(
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
                                    "Soil_Testing_home".tr,
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
                                    "gov_scheme_home".tr,
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
                                    "Crop_Suggestion_home".tr,
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
                    child: GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                          msg: "Coming Soon",
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                        );
                      },
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
                                  style: Theme.of(context)
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
                                  height: 40,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xfdfF1FBF2),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "News".tr,
                                        style: const TextStyle(
                                            fontFamily: "Bitter",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                      TextButton(
                                        child: Text("view_all".tr,
                                            style: TextStyle(
                                                color:
                                                    ColorConstants.primaryColor,
                                                fontFamily: "NanoSans",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10)),
                                        onPressed: () {
                                          Get.to(NewsListView());
                                        },
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
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          height: 12,
                                          width: 155,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5.0),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0),
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
                                          Get.to(() => SingleNewsScreen(
                                              article: article));
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
                                                    "${ApiEndPoints.imageBaseUrl}${article.image ?? ""}",
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  height: 96,
                                                  width: 155,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
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
                                                errorWidget:
                                                    (context, url, error) =>
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
