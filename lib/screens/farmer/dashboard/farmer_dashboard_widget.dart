import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/farmer/dashboard_controller.dart';
import 'package:fpo_assist/controllers/fpo/fpo_home_controller.dart';
import 'package:fpo_assist/screens/farmer/detect_disease/select_service_provider.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/color_constants.dart';
import '../../../widgets/custom_home_card.dart';

class FarmerDashboardWidget extends StatelessWidget {
  FarmerDashboardController controller = Get.put(
      FarmerDashboardController());
  final List<String> imgList = [
    'assets/images/carousel_home.png',
    'assets/images/carousel_home.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 2,
              decoration: BoxDecoration(color: Colors.grey[200]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Text(
                  "Farms",
                  style: TextStyle(
                      fontFamily: "Bitter",
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 36,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Obx(() {
                        return controller.farmerLandLoader.value ? Shimmer
                            .fromColors(
                          baseColor: Color(0xffDFF9ED),
                          highlightColor: Color(0xffF1FBF2),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 36,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context,
                                int index) {
                              return SizedBox(
                                width: 10,
                              );
                            },
                          ),
                        ) : ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: controller.farmerLands.value
                              .data!
                              .length,
                          itemBuilder: (context, index) {
                            final farmerLands = controller
                                .farmerLands.value.data;
                            return GestureDetector(
                              onTap: () {
                                controller.cropName.value =
                                    farmerLands[index].crop ?? "";
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                      '${farmerLands![index].address}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NotoSans"),
                                    )),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 10,
                            );
                          },
                        );
                      }),
                    ),
                    Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Color(0xffCBD5E1))),
                        child: Icon(
                          Icons.add,
                          size: 24,
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 2,
              decoration: BoxDecoration(color: Colors.grey[200]),
            ),
            SizedBox(
              height: 16,
            ),
            Obx(() {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: controller.farmerLandLoader.value ? Shimmer.fromColors(
                  baseColor: Color(0xffDFF9ED),
                  highlightColor: Color(0xffF1FBF2),
                  child: Container(
                    width: double.infinity,
                    height: 66,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5),),
                    ),
                  ),
                ) : Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xffBAEDBD))),
                  child: Row(
                    children: [
                      Text(
                        "${controller.cropName}",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Bitter"),
                      ),
                      Spacer(),
                      Text(
                        "32\u2103",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Bitter"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        "assets/icons/weather_icon.png",
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                      )
                    ],
                  ),
                ),
              );
            }),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Image.asset("assets/images/farmer_home_banner.png"),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xfdfF1FBF2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "Services".tr,
                  style: TextStyle(
                      fontFamily: "Bitter",
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/production.png",
                        height: 40,
                        width: 40,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Production",
                        style: TextStyle(
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
                        "assets/images/fertilizer_calci.png",
                        height: 40,
                        width: 40,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Fertilizer\nCalculator",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: "NotoSans"),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(()=> SelectServiceProvider());
                        },
                        child: Image.asset(
                          "assets/images/detect_disease.png",
                          height: 40,
                          width: 40,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Disease",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: "NotoSans"),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xfdfF1FBF2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Soil Test Today, Harvest Tomorrow!",
                      style: TextStyle(
                          fontFamily: "Bitter",
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Don't leave your farming success to chance – know your soil, grow your future!",
                                style: TextStyle(
                                    fontFamily: "NotoSans",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 42,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorConstants.primaryColor,
                                      width: 1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "BOOK NOW",
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
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xfdfF1FBF2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "Other Services",
                  style: TextStyle(
                      fontFamily: "Bitter",
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              height: 8,
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
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Farmer\nEconomics",
                            style: TextStyle(
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
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Irrigation\nAlarm",
                            style: TextStyle(
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
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Soil\nTesting",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: "NotoSans"),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            "assets/images/gov_schemes.png",
                            height: 40,
                            width: 40,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Govt.\nSchemes",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: "NotoSans"),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xfdfF1FBF2),
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
                          "Helpline",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'Bitter'),
                        ),
                        Text(
                          "Check number for assistance and support",
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
                      "assets/images/helpline_farmer.png",
                      width: 40,
                      height: 40,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: controller.newsLoader.value ? Shimmer.fromColors(
                  baseColor: Color(0xffDFF9ED),
                  highlightColor: Color(0xffF1FBF2),
                  child: Container(
                    width: double.infinity,
                    height: 37,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5),),
                    ),
                  ),
                ) : controller.news.value.articles.isNotEmpty ? Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xfdfF1FBF2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "News",
                        style: TextStyle(
                            fontFamily: "Bitter",
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                      Text(
                        "View All",
                        style: TextStyle(
                            color: ColorConstants.primaryColor,
                            fontFamily: "NanoSans",
                            fontWeight: FontWeight.w400,
                            fontSize: 10),
                      ),
                    ],
                  ),
                ) : SizedBox.shrink(),
              );
            }),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 192,
                child: Obx(() {
                  return controller.newsLoader.value ? Shimmer.fromColors(
                    baseColor: Color(0xffDFF9ED),
                    highlightColor: Color(0xffF1FBF2),
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
                            SizedBox(height: 10),
                            Container(
                              height: 12,
                              width: 155,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            SizedBox(
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
                      }, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 18); },
                    ),
                  ) : controller.news.value.articles.isNotEmpty ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.news.value.articles
                          .length,
                      itemBuilder: (context, index) {
                        final article = controller.news.value
                            .articles[index];
                        return Container(
                          width: 155,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Image.network(
                                    "${ApiEndPoints.baseUrl}${article.image}",
                                    width: 155,
                                    height: 96,
                                    fit: BoxFit.cover,)),
                              SizedBox(height: 10),
                              Text(article.title, style: TextStyle(
                                fontSize: 12,
                                fontFamily: "NotoSans",
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1C1C1C),
                              ), maxLines: 2,
                              ),
                              SizedBox(height: 4,),
                              Text("${article.publishDate}", style: TextStyle(
                                fontSize: 12,
                                fontFamily: "NotoSans",
                                fontWeight: FontWeight.w400,
                                color: Color(0xff1C1C1C),
                              ),)
                            ],
                          ),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 18);
                  }) : SizedBox.shrink();
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
