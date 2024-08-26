import 'package:flutter/material.dart';
import 'package:fpo_assist/screens/fpo/dashboard/fpo_home_screen.dart';
import 'package:fpo_assist/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';

import '../../../controllers/farmer/farmer_update_profile_controller.dart';
import '../../../models/select_crop_model.dart';
import '../../../utils/color_constants.dart';

class FarmerUpdateProfileScreen extends StatelessWidget {

  FarmerUpdateProfileController controller = Get.put(
      FarmerUpdateProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("farmer_detail".tr, style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Bitter')),
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
            Text("Name".tr, style: Theme
                .of(context)
                .textTheme
                .labelMedium!
                .copyWith(
                fontFamily: 'Bitter', color: ColorConstants.primaryColor),),
            SizedBox(height: 8,),
            TextFormField(
              controller: controller.nameController,
              decoration: InputDecoration(
                hintStyle:
                const TextStyle(fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 16),
                hintText: "Name".tr,
              ),
            ),
            Obx(() {
              return Visibility(
                visible: controller.fpoNameExist.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24,),
                    Text("FPO_Name".tr, style: Theme
                        .of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontFamily: 'Bitter',
                        color: ColorConstants.primaryColor),),
                    SizedBox(height: 8,),
                    TextFormField(
                      controller: controller.fpoName,
                      decoration: InputDecoration(
                        hintStyle:
                        const TextStyle(fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'NotoSans'
                        ),
                        hintText: "Company Name",
                      ),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 24,),
            Text("Enter_your_mail_id".tr, style: Theme
                .of(context)
                .textTheme
                .labelMedium!
                .copyWith(
                fontFamily: 'Bitter', color: ColorConstants.primaryColor),),
            SizedBox(height: 8,),
            TextFormField(
              controller: controller.emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isNotEmpty && !GetUtils.isEmail(value!))
                  return "Email is not valid";
                else
                  return null;
              },
              decoration: InputDecoration(
                hintStyle:
                const TextStyle(fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 16),
                hintText: "Abc@gmail.com".tr,
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
              controller.updateFarmerDetail();
            }, widget: controller.loading.value ? progressIndicator() : Text(
              "Save".tr,
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
