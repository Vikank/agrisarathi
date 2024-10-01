import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/fpo/fpo_update_profile_controller.dart';
import 'package:fpo_assist/models/select_crop_model.dart';
import 'package:fpo_assist/screens/fpo/auth/address_detail.dart';
import 'package:fpo_assist/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpdateProfileScreen extends StatelessWidget {

  RxList<Crop> selectedCrops;
  UpdateProfileScreen(this.selectedCrops);

  UpdateProfileController controller = Get.put(UpdateProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail", style: Theme
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Phone Number", style: Theme
                .of(context)
                .textTheme
                .labelMedium,),
            SizedBox(height: 8,),
            TextFormField(
              controller: controller.phoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(color: Color(0xff959CA3), width: 1),
                ),
                hintStyle:
                const TextStyle(fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 16),
                hintText: "Number",
              ),
            ),
            SizedBox(height: 24,),
            Text("Registration ID", style: Theme
                .of(context)
                .textTheme
                .labelMedium,),
            SizedBox(height: 8,),
            TextFormField(
              controller: controller.registrationId,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(color: Color(0xff959CA3), width: 1),
                ),
                hintStyle:
                const TextStyle(fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 16),
                hintText: "ID",
              ),
            ),
            SizedBox(height: 24,),
            Text("Established Date", style: Theme
                .of(context)
                .textTheme
                .labelMedium,),
            SizedBox(height: 8,),
            TextFormField(
              controller: controller.establishedDate,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(color: Color(0xff959CA3), width: 1),
                ),
                suffixIcon: InkWell(
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(
                          picked);
                      controller.establishedDate.text = formattedDate;
                      controller.updateDate(formattedDate);
                    }
                  },
                  child: Icon(Icons.calendar_month_outlined),
                ),
                hintStyle:
                const TextStyle(fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 16),
                hintText: "MM/DD/YYYY",
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
              Get.to(AddressDetail(selectedCrops, controller.phoneController.text, controller.registrationId.text, controller.establishedDate.text));
            }, widget: controller.loading.value ? progressIndicator() : Text(
              "Next",
              style: TextStyle(fontFamily: 'GoogleSans',
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),),
          ),
        );
      }),
    );
  }
}
