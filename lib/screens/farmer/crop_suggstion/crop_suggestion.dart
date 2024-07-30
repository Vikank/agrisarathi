import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';

import '../../../controllers/farmer/crop_suggestion_controller.dart';


class CropSuggestion extends StatelessWidget {
  final CropSuggestionController controller = Get.put(CropSuggestionController());

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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 50, color: Colors.red),
                SizedBox(height: 16),
                Text(
                  controller.errorMessage.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.fetchCropSuggestions,
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        } else if (controller.cropSuggestions.isEmpty) {
          return Center(
            child: Text(
              'No suggested crops available.',
              style: TextStyle(fontSize: 16),
            ),
          );
        } else {
          return Expanded(
            child: ListView.separated(
              itemCount: controller.cropSuggestions.length,
              itemBuilder: (context, index) {
                var crop = controller.cropSuggestions[index];
                return ListTile(
                  onTap: (){

                  },
                  horizontalTitleGap: 24,
                  leading: CachedNetworkImage(
                    imageUrl: '${ApiEndPoints.baseUrl}${crop.cropImage}',
                    imageBuilder: (context, imageProvider) => Container(
                      height: 62,
                      width: 65,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fitHeight,
                          filterQuality: FilterQuality.low,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xff002833d).withOpacity(0.06),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Icon(Icons.error)),
                  ),
                  title: Text(crop.cropName ?? '', style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: "NotoSans"
                  ),),
                );
              }, separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10,
                );
            },
            ),
          );
        }
      }),
    );
  }
}
