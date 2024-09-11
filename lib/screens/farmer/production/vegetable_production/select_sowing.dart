import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/farmer/vegetable_sowing_controller.dart';

class SelectSowing extends StatelessWidget {
  VegetableSowingController controller = Get.put(VegetableSowingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "sowing".tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
        ),
      ),
      body: Center(
        child: Container(
          width: 190,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                  child: Text(
                "sowing_date".tr,
                style: TextStyle(
                    fontFamily: "Bitter",
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              )),
              SizedBox(
                height: 5,
              ),
              Center(
                  child: Text(
                "sowing_date_des".tr,
                style: TextStyle(
                    fontFamily: "NotoSans",
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
              )),
              SizedBox(
                height: 32,
              ),
              Center(
                  child: Image.asset(
                "assets/images/sowing_image.png",
                height: 130,
                width: 130,
              )),
              SizedBox(
                height: 32,
              ),
              Text(
                "sowing_date".tr,
                style: TextStyle(
                    fontFamily: "NotoSans",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.green),
              ),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () =>
                    controller.pickDate(context), // Open date picker on tap
                child: Obx(
                  () => TextFormField(
                    enabled: false, // Disable input to make it tappable only
                    decoration: InputDecoration(
                      hintText: controller.selectedDate.value.isEmpty
                          ? 'DD/MM/YYYY'
                          : controller.selectedDate.value,
                      hintStyle: TextStyle(
                          fontFamily: "NotoSans",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: Color(0xff64748B),
                      ),
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff959CA3))),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
