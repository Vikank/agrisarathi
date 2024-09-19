import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/farmer/vegetable_production_controller.dart';

class VegetableStagesScreen extends StatelessWidget {
  final int landId;
  final int filterId;

  VegetableStagesScreen({required this.landId, required this.filterId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VegetableStagesController(landId, filterId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Production'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.vegetableProduction.value.stages == null ||
            controller.vegetableProduction.value.stages!.isEmpty) {
          return Center(child: Text('No stages available'));
        }
        return _buildContent(controller);
      }),
    );
  }

  Widget _buildContent(VegetableStagesController controller) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomStageProgressIndicator(
              substageNames: controller.substageNames,
              currentSubstage: controller.currentSubStageIndex.value,
            ),
            SizedBox(height: 20),
            Text(
              controller.currentStage.stageName ?? 'Unknown Stage',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildVideoPlayer(controller),
            SizedBox(height: 10),
            Text(controller.currentStage.description ?? 'No description available'),
            SizedBox(height: 10),
            _buildAudioPlayer(controller),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: controller.onNextPressed,
                child: Text(controller.isLastSubStage.value ? 'Submit' : 'Next'),
              ),
            ),
            SizedBox(height: 20),
            Text('Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildProductsList(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer(VegetableStagesController controller) {
    return Obx(() {
      if (controller.chewieController.value != null) {
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: Chewie(controller: controller.chewieController.value!),
        );
      } else {
        return Container(
          height: 200,
          color: Colors.grey[300],
          child: Center(child: Text('Video not available')),
        );
      }
    });
  }

  Widget _buildAudioPlayer(VegetableStagesController controller) {
    return Obx(() {
      if (controller.audioPlayer.value != null) {
        return Container(
          height: 50,
          color: Colors.grey[200],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(controller.isPlaying.value ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  if (controller.isPlaying.value) {
                    controller.audioPlayer.value!.pause();
                  } else {
                    controller.audioPlayer.value!.resume();
                  }
                  controller.isPlaying.toggle();
                },
              ),
              Text('Audio Player'),
            ],
          ),
        );
      } else {
        return Container(
          height: 50,
          color: Colors.grey[200],
          child: Center(child: Text('Audio not available')),
        );
      }
    });
  }

  Widget _buildProductsList(VegetableStagesController controller) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.currentStage.products?.length ?? 0,
        itemBuilder: (context, index) {
          final product = controller.currentStage.products![index];
          return Card(
            child: Container(
              width: 120,
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Image.network(
                    product.productImage ?? '',
                    height: 80,
                    width: 80,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.error, size: 80),
                  ),
                  Text(product.productName ?? 'Unknown Product'),
                  Text('${product.price ?? 0} INR'),
                ],
              ),
            ),
          );
        },
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
