import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/farmer/dashboard_controller.dart';

class CropProgressCarousel extends StatelessWidget {
  final FarmerDashboardController controller = Get.put(FarmerDashboardController());

  CropProgressCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
      ),
      items: controller.vegetableProgress.value!.cropsProgress!.map((crop) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Crop ID: ${crop.cropId}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  CircularProgressIndicator(
                    value: crop.overallProgress! / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                  const SizedBox(height: 10),
                  Text('Progress: ${crop.overallProgress!.toStringAsFixed(1)}%'),
                  Text('Completed: ${crop.completedPreferences} / ${crop.totalPreferences}'),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}