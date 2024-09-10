import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import '../../../controllers/farmer/single_crop_suggestion_controller.dart';
import '../../../models/single_crop_suggestion_model.dart';

class SingleCropSuggestion extends StatelessWidget {
  int? cropId;
  final SingleCropSuggestionController controller = Get.put(SingleCropSuggestionController());
  SingleCropSuggestion({required this.cropId}){
    controller.fetchSingleCropSuggestion(cropId!);
  }

  String formatDescription(String description) {
    // Split the description into lines
    List<String> lines = description.split('\n');

    // Process each line
    List<String> formattedLines = lines.map((line) {
      // Trim the line and add a bullet point if it's not empty
      line = line.trim();
      return line.isNotEmpty ? '• $line' : line;
    }).toList();

    // Join the lines back together
    return formattedLines.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Crop Suggestion".tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else if (controller.cropDetails.value == null) {
          return Center(child: Text('No crop details available'));
        } else {
          CropDetails crop = controller.cropDetails.value!;
          log("crop details ${crop.cropName}");
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: Color(0xffBAEDBD),
                  child: Row(
                    children: [
                      Text(
                        crop.cropName ?? '',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "Bitter"),
                      ),
                      Spacer(),
                      Obx(() => IconButton(
                        icon: Icon(controller.isPlaying.value ? Icons.stop : Icons.volume_up_outlined, color: Colors.green       ,),
                        onPressed: controller.toggleAudio,
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 190,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: '${ApiEndPoints.imageBaseUrl}${crop.cropImage}' ?? '',
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(height: 16),
                Text(formatDescription(crop.description ?? ''), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "NotoSans")),
                SizedBox(height: 16),
                _buildInfoSection('Requirement', [
                  'Weather: ${crop.weatherTemperature ?? ''}',
                  'Temperature: ${crop.weatherTemperature ?? ''}',
                ]),
                SizedBox(height: 16),
                _buildInfoSection('Cost and Price (Estimate)', [
                  'Cost: ${crop.costOfCultivation ?? ''}',
                  'Price: ${crop.marketPrice ?? ''}',
                ]),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildInfoSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "Bitter")),
        SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Text(item, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "NotoSans"),),
        )).toList(),
      ],
    );
  }
}
