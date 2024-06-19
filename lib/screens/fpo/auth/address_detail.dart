import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/fpo/fpo_update_profile_controller.dart';
import 'package:fpo_assist/models/select_crop_model.dart';
import 'package:fpo_assist/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddressDetail extends StatelessWidget {

  RxList<Crop> selectedCrops;
  String phoneNumber;
  String registrationId;
  String establishedDate;

  AddressDetail(this.selectedCrops, this.phoneNumber, this.registrationId, this.establishedDate);
  UpdateProfileController controller = Get.put(UpdateProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Office Address", style: Theme
            .of(context)
            .textTheme
            .labelLarge),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_outlined)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Please enter your address", style: Theme
                .of(context)
                .textTheme
                .labelMedium),
            SizedBox(height: 8,),
            TextFormField(
              controller: controller.addressLine,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(color: Color(0xff959CA3), width: 1),
                ),
                hintStyle:
                const TextStyle(fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 16),
                hintText: "Address Line 1",
              ),
            ),
            SizedBox(height: 24,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.pinCode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                            color: Color(0xff959CA3), width: 1),
                      ),
                      hintStyle:
                      const TextStyle(fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 16),
                      hintText: "Pin Code",
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    controller: controller.state,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                            color: Color(0xff959CA3), width: 1),
                      ),
                      hintStyle:
                      const TextStyle(fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 16),
                      hintText: "State",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.district,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                            color: Color(0xff959CA3), width: 1),
                      ),
                      hintStyle:
                      const TextStyle(fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 16),
                      hintText: "District",
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    controller: controller.subDistrict,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                            color: Color(0xff959CA3), width: 1),
                      ),
                      hintStyle:
                      const TextStyle(fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 16),
                      hintText: "Sub District",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24,),
            TextFormField(
              controller: controller.village,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(color: Color(0xff959CA3), width: 1),
                ),
                hintStyle:
                const TextStyle(fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 16),
                hintText: "Village",
              ),
            ),
            SizedBox(height: 24,),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return BottomAppBar(
          color: Colors.white,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
            child: CustomElevatedButton(buttonColor: Colors.green, onPress: () {
              controller.updateFpoDetail(selectedCrops, phoneNumber, registrationId, establishedDate);
            }, widget: controller.loading.value ? progressIndicator() : Text(
              "SAVE",
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
