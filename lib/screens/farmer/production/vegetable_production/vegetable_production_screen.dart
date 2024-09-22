import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../controllers/farmer/vegetable_production_controller.dart';

class VegetableStagesScreen extends StatelessWidget {
  final int landId;
  final int filterId;

  VegetableStagesScreen({required this.landId, required this.filterId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VegetableStagesController(landId, filterId ));

    return Scaffold(
      appBar: AppBar(title: Text('Vegetable Production')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.vegetableProduction.value.stages == null ||
            controller.vegetableProduction.value.stages!.isEmpty) {
          return Center(child: Text('No stages available'));
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStageProgress(controller),
                _buildSubStages(controller),
                _buildVideoPlayer(controller),
                _buildDescription(controller),
                _buildProducts(controller),
                _buildNextButton(controller),
              ],
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
            controller.filteredStages[controller.currentStageIndex.value].stages,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '1 Jun to 10 Jun (Mark as completed in 10 days)',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: (controller.currentStageIndex.value + 1) / controller.filteredStages.length,
            backgroundColor: Colors.green.shade100,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildSubStages(VegetableStagesController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: controller.filteredStages.map((stage) {
          return Text(stage.stageName, style: TextStyle(fontSize: 12));
        }).toList(),
      ),
    );
  }

  Widget _buildVideoPlayer(VegetableStagesController controller) {
    return AspectRatio(
      aspectRatio: controller.videoController.value.aspectRatio,
      child: VideoPlayer(controller.videoController),
    );
  }

  Widget _buildDescription(VegetableStagesController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.filteredStages[controller.currentStageIndex.value].stageName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(controller.filteredStages[controller.currentStageIndex.value].description),
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
          Text('Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemCount: controller.filteredStages[controller.currentStageIndex.value].products.length,
            itemBuilder: (context, index) {
              final product = controller.filteredStages[controller.currentStageIndex.value].products[index];
              return Card(
                child: Column(
                  children: [
                    Image.network(product.productImage, height: 100, fit: BoxFit.cover),
                    Text(product.productName),
                    Text('${product.price ?? "1000-10000"} INR'),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton(VegetableStagesController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: controller.nextStage,
        child: Text('Next'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          minimumSize: Size(double.infinity, 50),
        ),
      ),
    );
  }
}

class CustomStageProgressIndicator extends StatelessWidget {
  final List<String> substageNames;
  final int currentSubstage;

  const CustomStageProgressIndicator({
    Key? key,
    required this.substageNames,
    required this.currentSubstage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: CustomPaint(
            painter: StageProgressPainter(
              stageCount: substageNames.length,
              currentStage: currentSubstage,
            ),
            child: Container(),
          ),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            substageNames.length,
                (index) => Text(
              '${index + 1}',
              style: TextStyle(
                color: index <= currentSubstage ? Colors.green : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: substageNames
              .map((name) => Text(
            name,
            style: TextStyle(fontSize: 12),
          ))
              .toList(),
        ),
      ],
    );
  }
}

class StageProgressPainter extends CustomPainter {
  final int stageCount;
  final int currentStage;

  StageProgressPainter({required this.stageCount, required this.currentStage});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final activePaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final double segmentWidth = size.width / (stageCount - 1);

    for (int i = 0; i < stageCount - 1; i++) {
      final start = Offset(i * segmentWidth, size.height / 2);
      final end = Offset((i + 1) * segmentWidth, size.height / 2);
      canvas.drawLine(start, end, i < currentStage ? activePaint : paint);
    }

    for (int i = 0; i < stageCount; i++) {
      final center = Offset(i * segmentWidth, size.height / 2);
      canvas.drawCircle(
        center,
        5,
        i <= currentStage ? activePaint : paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
