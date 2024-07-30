import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/farmer/single_crop_suggestion_controller.dart';
import '../../../models/single_crop_suggestion_model.dart';

class SingleCropSuggestion extends StatelessWidget {
  int? cropId;
  final SingleCropSuggestionController controller = Get.put(SingleCropSuggestionController());
  SingleCropSuggestion({required this.cropId}){
    controller.fetchSingleCropSuggestion(cropId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Suggestion'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
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
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  crop.cropName ?? '',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: crop.cropImage ?? '',
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.volume_up),
                      onPressed: controller.playAudio,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(crop.description ?? '', style: TextStyle(fontSize: 16)),
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
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Text(item),
        )).toList(),
      ],
    );
  }
}
