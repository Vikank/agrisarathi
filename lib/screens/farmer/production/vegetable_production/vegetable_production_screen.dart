import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/farmer/vegetable_production_controller.dart';

class VegetableStagesScreen extends StatelessWidget {
  final int landId;
  final int cropId;

  VegetableStagesScreen({required this.landId, required this.cropId});

  @override
  Widget build(BuildContext context) {
    final VegetableStagesController controller = Get.put(VegetableStagesController(landId, cropId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Vegetable Stages'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            LinearProgressIndicator(value: controller.progressValue.value),
            Expanded(
              child: ListView.builder(
                itemCount: controller.vegetableProduction.value.stages?.length ?? 0,
                itemBuilder: (context, index) {
                  var stage = controller.vegetableProduction.value.stages![index];
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
                      (controller.vegetableProduction.value.stages?.length ?? 0) - 1
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
