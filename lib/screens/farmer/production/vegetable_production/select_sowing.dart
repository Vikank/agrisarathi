import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/farmer/vegetable_sowing_controller.dart';
import '../../../../widgets/custom_elevated_button.dart';

class SelectSowing extends StatelessWidget {
  int landId;
  SelectSowing({required this.landId});
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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32.0),
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
                child: Container(
                  height: 250,
                  width: 280,
                  child: Image.asset(
                                  "assets/images/sowing_image.png",
                    fit: BoxFit.cover,
                                ),
                ),
              ),
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
                      hintText: controller.selectedDateForUI.value.isEmpty
                          ? 'DD/MM/YYYY'
                          : controller.selectedDateForUI.value,
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
      bottomNavigationBar: Obx(() {
        return BottomAppBar(
          color: Colors.white,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
            child: CustomElevatedButton(buttonColor: Colors.green, onPress: () {
              controller.submitSowingDate(landId);
            }, widget: controller.loading.value ? progressIndicator() : Text(
              "NEXT",
              style: TextStyle(fontFamily: 'Roboto',
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),),
          ),
        );
      }),
    );
  }
}
