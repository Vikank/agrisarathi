import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/fpo/fpo_update_profile_controller.dart';
import 'package:fpo_assist/models/select_crop_model.dart';
import 'package:fpo_assist/screens/shared/select_crop_screen.dart';
import 'package:fpo_assist/utils/color_constants.dart';
import 'package:fpo_assist/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FarmerAddressDetail extends StatelessWidget {

  UpdateProfileController controller = Get.put(UpdateProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farm's Address", style: TextStyle(fontSize:16, fontWeight: FontWeight.w700, fontFamily: 'Bitter')),
        // centerTitle: true,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Address", style: Theme
                .of(context)
                .textTheme
                .labelMedium!.copyWith(fontFamily: 'Bitter', color: ColorConstants.primaryColor)),
            SizedBox(height: 24,),
            TextFormField(
              controller: controller.addressLine,
              decoration: InputDecoration(
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(4)),
                //   borderSide: BorderSide(color: Color(0xff959CA3), width: 1),
                // ),
                hintStyle:
                const TextStyle(fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 12,
                  fontFamily: 'NotoSans',),
                hintText: "Line 1",
              ),
            ),
            SizedBox(height: 24,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.pinCode,
                    decoration: InputDecoration(
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(4)),
                      //   borderSide: BorderSide(
                      //       color: Color(0xff959CA3), width: 1),
                      // ),
                      hintStyle:
                      const TextStyle(fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 12,
                        fontFamily: 'NotoSans',),
                      hintText: "Pin Code",
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    controller: controller.state,
                    decoration: InputDecoration(
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(4)),
                      //   borderSide: BorderSide(
                      //       color: Color(0xff959CA3), width: 1),
                      // ),
                      hintStyle:
                      const TextStyle(fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 12,
                        fontFamily: 'NotoSans',),
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
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(4)),
                      //   borderSide: BorderSide(
                      //       color: Color(0xff959CA3), width: 1),
                      // ),
                      hintStyle:
                      const TextStyle(fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 12,
                        fontFamily: 'NotoSans',),
                      hintText: "District",
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    controller: controller.subDistrict,
                    decoration: InputDecoration(
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(4)),
                      //   borderSide: BorderSide(
                      //       color: Color(0xff959CA3), width: 1),
                      // ),
                      hintStyle:
                      const TextStyle(fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 12,
                        fontFamily: 'NotoSans',),
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
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(4)),
                //   borderSide: BorderSide(color: Color(0xff959CA3), width: 1),
                // ),
                hintStyle:
                const TextStyle(fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 12,
                  fontFamily: 'NotoSans',),
                hintText: "Village",
              ),
            ),
            SizedBox(height: 48,),
            Text("Land Area", style: Theme
                .of(context)
                .textTheme
                .labelMedium!.copyWith(fontFamily: 'Bitter', color: ColorConstants.primaryColor)),
            TextFormField(
              controller: controller.landArea,
              decoration: InputDecoration(
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(4)),
                //   borderSide: BorderSide(color: Color(0xff959CA3), width: 1),
                // ),
                hintStyle:
                const TextStyle(fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 12,
                  fontFamily: 'NotoSans',
                ),
                hintText: "In acers",
              ),
            ),
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
              Get.to(()=> SelectCropScreen());
            }, widget: controller.loading.value ? progressIndicator() : Text(
              "NEXT",
              style: TextStyle(fontFamily: 'NotoSans',
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),),
          ),
        );
      }),
    );
  }
}
