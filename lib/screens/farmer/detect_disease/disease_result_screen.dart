import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/farmer/disease_detection_video_controller.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';

import '../../../models/disease_result_model.dart';
import '../text_format_treatment.dart';

class DiseaseResultScreen extends StatelessWidget {
  DiseaseDetectionVideoController controller =
      Get.put(DiseaseDetectionVideoController());
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Diagnosis".tr,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, fontFamily: "GoogleSans"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller.diseaseResultModel.diseaseResults!.disease == ""
                ? SizedBox.shrink()
                : Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        // color: Color(0xffEAFAEB)
                      ),
                    child: Text(
                      "${controller.diseaseResultModel.diseaseResults!.disease}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          fontFamily: "GoogleSans"),
                    ),
                  ),
            SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 190,
              width: double.infinity,
              child: CarouselSlider(
                items: controller.diseaseResultModel.diseaseResults!.images!
                    .map((item) => CachedNetworkImage(
                  imageUrl: item.id == null ? "${ApiEndPoints.imageBaseUrl}${item.diseaseFile!}" : "${ApiEndPoints.imageBaseUrl}${item.diseaseFile!}",
                  imageBuilder: (context, imageProvider) =>
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(10),
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
                          width: double.infinity,
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xff002833d)
                                .withOpacity(0.06),
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.error)),
                ),
                    // Image.network(
                    //     ApiEndPoints.imageBaseUrl + item.diseaseFile!,
                    //     fit: BoxFit.cover,
                    //     width: double.infinity),
                )
                    .toList(),
                carouselController: _controller,
                options: CarouselOptions(
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      controller.currentCarousel.value = index;
                    }),
              ),
            ),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller
                    .diseaseResultModel.diseaseResults!.images!
                    .asMap()
                    .entries
                    .map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.currentCarousel.value == entry.key
                              ? Colors.green
                              : Colors.grey[100]),
                    ),
                  );
                }).toList(),
              );
            }),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Shadow color
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: Column(
                children: [
                  controller.diseaseResultModel.diseaseResults!.treatment == "" &&
                      controller
                          .diseaseResultModel.diseaseResults!.treatmentbefore ==
                          "" &&
                      controller.diseaseResultModel.diseaseResults!
                          .treatmentfield ==
                          "" &&
                      controller.diseaseResultModel.diseaseResults!
                          .suggestiveproduct ==
                          "" &&
                      controller.diseaseResultModel.diseaseResults!.symptom ==
                          ""
                      ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        controller
                            .diseaseResultModel.diseaseResults!.message!,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            fontFamily: "GoogleSans"),
                      ),
                    ),
                  )
                      : SizedBox.shrink(),
                  controller.diseaseResultModel.diseaseResults!.symptom == ""
                      ? SizedBox.shrink()
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Image.asset("assets/icons/symptoms_icon.png", width: 20, height: 20,),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Symptoms".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                fontFamily: "GoogleSans"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${controller.diseaseResultModel.diseaseResults!.symptom}", style: TextStyle(fontFamily: "GoogleSans", fontSize: 16, fontWeight: FontWeight.w400),),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: controller.diseaseResultModel.diseaseResults!.cropId !=
                        5 &&
                        controller.diseaseResultModel.diseaseResults!.cropId != 73,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.diseaseResultModel.diseaseResults!
                            .treatmentbefore !=
                            ""
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/icons/treatment_before_sowing_icon.png", width: 20, height: 20,),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Treatments_before_Sowing".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      fontFamily: "GoogleSans"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${controller.diseaseResultModel.diseaseResults!.treatmentbefore}", style: TextStyle(fontFamily: "GoogleSans", fontSize: 16, fontWeight: FontWeight.w400),),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        )
                            : SizedBox.shrink(),
                        controller.diseaseResultModel.diseaseResults!
                            .treatmentfield !=
                            ""
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/icons/treatment_field_icon.png", width: 20, height: 20,),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Treatments_in_field".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      fontFamily: "GoogleSans"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${controller.diseaseResultModel.diseaseResults!.treatmentfield}", style: TextStyle(fontFamily: "GoogleSans", fontSize: 16, fontWeight: FontWeight.w400),),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                  controller.diseaseResultModel.diseaseResults!.treatment != ""
                      ? Visibility(
                    visible: controller
                        .diseaseResultModel.diseaseResults!.cropId ==
                        5 ||
                        controller
                            .diseaseResultModel.diseaseResults!.cropId ==
                            73,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset("assets/icons/treatment_field_icon.png", width: 20, height: 20,),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Treatment",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  fontFamily: "GoogleSans"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FormattedTreatmentText(
                            treatment: controller.diseaseResultModel
                                .diseaseResults!.treatment ??
                                ''),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  )
                      : SizedBox.shrink(),
                  controller.diseaseResultModel.diseaseResults!.suggestiveproduct !=
                      ""
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/icons/suggestive_icon.png", width: 20, height: 20,),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Suggestive_products".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                fontFamily: "GoogleSans"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${controller.diseaseResultModel.diseaseResults!.suggestiveproduct}", style: TextStyle(fontFamily: "GoogleSans", fontSize: 16, fontWeight: FontWeight.w400),),
                    ],
                  )
                      : SizedBox.shrink(),
                  SizedBox(height: 24),
                  if (controller.diseaseResultModel.productDisease != null &&
                      controller.diseaseResultModel.productDisease!.isNotEmpty)
                    _buildProductResultsSection(
                        controller.diseaseResultModel.productDisease!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductResultsSection(List<ProductDisease> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recommended_Products'.tr,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "GoogleSans")),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            var product = products[index];
            return ListTile(
              leading: Image.network(
                '${ApiEndPoints.imageBaseUrl}${product.productimage}',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[300],
                  child: Icon(Icons.error),
                ),
              ),
              title: Text(product.productname ?? 'N/A',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "GoogleSans")),
              subtitle: Text(
                  '${product.category ?? 'N/A'} - ${product.price ?? 'N/A'}',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: "GoogleSans")),
            );
          },
        ),
      ],
    );
  }
}
