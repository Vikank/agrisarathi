import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../controllers/farmer/vegetable_production_controller.dart';

class VegetableStagesScreen extends StatelessWidget {
  final int landId;
  final int filterId;

  VegetableStagesScreen({required this.landId, required this.filterId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VegetableStagesController(landId, filterId));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Vegetable_Production'.tr,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'GoogleSans'),
        ),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.vegetableProduction.value.stages == null ||
            controller.vegetableProduction.value.stages!.isEmpty) {
          return const Center(child: Text('No stages available'));
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStageProgress(controller),
                  // _buildSubStages(controller),
                  _buildVideoPlayer(controller),
                  _buildDescription(controller),
                  _buildProducts(controller),
                  // _buildNextButton(controller),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildStageProgress(VegetableStagesController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller
                .filteredStages[controller.currentStageIndex.value].stages,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: "GoogleSans"),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            minHeight: 7,
            borderRadius: const BorderRadius.all(Radius.circular(32)),
            value: (controller.currentStageIndex.value + 1) /
                controller.filteredStages.length,
            backgroundColor: Colors.green.shade100,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ],
      ),
    );
  }

  // Widget _buildSubStages(VegetableStagesController controller) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: controller.filteredStages.map((stage) {
  //         return Text(stage.stageName, style: TextStyle(fontSize: 12));
  //       }).toList(),
  //     ),
  //   );
  // }

  Widget _buildVideoPlayer(VegetableStagesController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller
                .filteredStages[controller.currentStageIndex.value].stageName,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: "GoogleSans"),
          ),
          Obx(() {
            if (controller.chewieController.value == null) {
              return Center(child: Text('Failed_to_load_video'.tr));
            } else {
              return Container(
                height: 180,
                child: Chewie(controller: controller.chewieController.value!) // Show loading until video initializes
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _buildDescription(VegetableStagesController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  controller.filteredStages[controller.currentStageIndex.value]
                      .description,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: "GoogleSans"),
                ),
              ),
              Column(
                children: [
                  Obx(() =>
                      IconButton(
                          icon: Icon(
                            controller.isPlaying.value
                                ? Icons.stop
                                : Icons.volume_up_outlined,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            controller.toggleAudio(controller
                                .filteredStages[controller.currentStageIndex
                                .value]
                                .stageAudio);
                          })),
                  _buildNextButton(controller)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProducts(VegetableStagesController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xfdfF1FBF2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text('Products',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: "GoogleSans")),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 257,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller
                  .filteredStages[controller.currentStageIndex.value]
                  .products
                  .length,
              itemBuilder: (context, index) {
                final product = controller
                    .filteredStages[controller.currentStageIndex.value]
                    .products[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.1), // Shadow color with opacity
                        spreadRadius: 1, // How much the shadow should spread
                        blurRadius: 1, // Softness of the shadow
                        offset: const Offset(
                            2, 1), // Position of the shadow (x, y)
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                          "${ApiEndPoints.imageBaseUrl}${product.productImage}",
                          height: 123,
                          width: 130,
                          fit: BoxFit.cover),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(product.productName ?? "Unknown",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: "GoogleSans")),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(product.category ?? "Category",
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "GoogleSans")),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('${product.price ?? "Nil"} INR',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: "GoogleSans",
                              color: Colors.green)),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 20),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNextButton(VegetableStagesController controller) {
    return TextButton(
      onPressed: controller.nextStage,
      child: const Text('Next',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontFamily: "GoogleSans",
              color: Colors.green)),
    );
  }
}
