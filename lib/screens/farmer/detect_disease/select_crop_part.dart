import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/api_constants.dart';
import 'how_to_click.dart';

class SelectCropPart extends StatelessWidget {
  int serviceProviderId;
  int cropId;
  String? landId;
  String cropName;
  String cropImage;
  SelectCropPart(
      {required this.serviceProviderId,
      required this.cropId,
      this.landId,
      required this.cropName,
      required this.cropImage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Crop_part".tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "GoogleSans"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                log("land id ${landId}");
                Get.to(()=> HowToClick(
                    serviceProviderId: serviceProviderId,
                    cropId: cropId,
                    landId: landId!,
                  filterType: "crop",
                ));
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
                      "${ApiEndPoints.imageBaseUrl}${cropImage ?? ""}",
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
                    Text(
                      "${cropName ?? ""}",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: "GoogleSans",
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: (){
                Get.to(()=> HowToClick(
                  serviceProviderId: serviceProviderId,
                  cropId: cropId,
                  landId: "",
                  filterType: "leaf",
                ));
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
                    Image.asset(
                      "assets/images/leaf.png",
                      width: 52,
                      height: 52,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Leaf's",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: "GoogleSans",
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
