import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/farmer/vegetable_production_controller.dart';

class VegetableStagesScreen extends StatelessWidget {
  final int landId;
  final int filterId;

  VegetableStagesScreen({required this.landId, required this.filterId});

  @override
  Widget build(BuildContext context) {
    final VegetableStagesController controller = Get.put(VegetableStagesController(landId, filterId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Vegetable Stages'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Ensure stages is not null before accessing it
        final stages = controller.vegetableProduction.value.stages;
        if (stages == null || stages.isEmpty) {
          return Center(child: Text('No stages available'));
        }

        return Column(
          children: [
            LinearProgressIndicator(value: controller.progressValue.value),
            Expanded(
              child: ListView.builder(
                itemCount: stages.length,
                itemBuilder: (context, index) {
                  var stage = stages[index];
                  return ListTile(
                    title: Text(stage.stageName ?? 'No Name'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description: ${stage.description ?? 'No Description'}'),
                        SizedBox(height: 10),
                        Text('Products:'),
                        ...?stage.products?.map((product) => Text(product.productName ?? 'No Product')).toList(),
                      ],
                    ),
                    trailing: Icon(stage.isCompleted == true ? Icons.check_circle : Icons.radio_button_unchecked),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: controller.nextStage,
                child: Obx(() {
                  return Text(controller.currentStageIndex.value ==
                      (stages.length - 1)
                      ? 'Submit'
                      : 'Next');
                }),
              ),
            )
          ],
        );
      }),
    );
  }
}
