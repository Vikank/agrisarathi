import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/farmer/dashboard_controller.dart';
import 'package:get/get.dart';

class ChooseFarmLand extends StatelessWidget {
  FarmerDashboardController controller = Get.put(FarmerDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Farm land",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Farms",
              style: TextStyle(
                fontFamily: "Bitter",
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    var farmLand = controller.farmerLands.value.data![index];
                    return Container(
                      child: Text("${farmLand.crop ?? ""}"),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: controller.farmerLands.value.data!.length),
            )
          ],
        ),
      ),
    );
  }
}
