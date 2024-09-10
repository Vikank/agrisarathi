import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/farmer/dashboard_controller.dart';
import '../../../../utils/api_constants.dart';

class CropProgressCarousel extends StatelessWidget {
  final FarmerDashboardController controller =
      Get.put(FarmerDashboardController());

  CropProgressCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if vegetableProgress or cropsProgress is null or empty
    if (controller.vegetableProgress.value?.cropsProgress == null ||
        controller.vegetableProgress.value!.cropsProgress!.isEmpty) {
      return const SizedBox.shrink(); // Or display a message like "No progress available"
    }
    return CarouselSlider(
      options: CarouselOptions(
        height: double.infinity,
        enlargeCenterPage: false,
        viewportFraction: 1,
        autoPlay: true,
        enableInfiniteScroll: false,
      ),
      items: controller.vegetableProgress.value!.cropsProgress!.map((crop) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffDFF1E6),
                ),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: "${ApiEndPoints.imageBaseUrl}${crop.cropImage}",
                      imageBuilder: (context, imageProvider) => Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => SizedBox(
                          height: 10,
                          width: 10,
                          child: const CircularProgressIndicator(
                            strokeAlign: 2,
                            strokeWidth: 2,
                          )),
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
                    SizedBox(width: 10,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${crop.cropName ?? ""}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "NotoSans")),
                            Text(
                              '${crop.overallProgress!.toStringAsFixed(1)}%',
                              style: TextStyle(
                                  fontFamily: "NotoSans",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: LinearProgressIndicator(
                                minHeight: 8,
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                value: crop.overallProgress! / 100,
                                backgroundColor: Colors.white,
                                valueColor:
                                    const AlwaysStoppedAnimation<Color>(Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
