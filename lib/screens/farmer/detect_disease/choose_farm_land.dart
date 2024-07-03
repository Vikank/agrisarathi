import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/farmer/dashboard_controller.dart';
import 'package:get/get.dart';

import '../../../utils/api_constants.dart';

class ChooseFarmLand extends StatelessWidget {
  FarmerDashboardController controller = Get.put(FarmerDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
            SizedBox(height: 24,),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    var farmLand = controller.farmerLands.value.data![index];
                    log("image ${farmLand.cropImages![0]}");
                    if(index == controller.farmerLands.value.data!.length - 1){
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(10),),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        child: Row(
                          children: [
                            Image.network('${ApiEndPoints
                                .baseUrl}${farmLand.cropImages![0] ?? ""}', width: 52, height: 52,),
                            SizedBox(width: 30,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${farmLand.crop ?? ""}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, fontFamily: "NotoSans",color: Colors.black),),
                                Text("${farmLand.address ?? ""}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "NotoSans"),),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else{
                      Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                          child: Text("Another crop"),
                        ),
                      );
                    }
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
