import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/shared/language_selection_controller.dart';
import 'package:fpo_assist/screens/farmer/auth/farmer_login_screen.dart';
import 'package:fpo_assist/utils/color_constants.dart';
import 'package:fpo_assist/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fpo/auth/login_screen.dart';

class LanguageSelection extends StatelessWidget {
  LanguageSelectionController controller =
      Get.put(LanguageSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          alignment: Alignment.bottomCenter,
          image: AssetImage(
            "assets/images/farm_land.png",
          ),
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        )),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(
                height: 75,
              ),
              Text(
                "Select Language",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontFamily: 'Bitter'),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                height: 350,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.data.length,
                  itemBuilder: (context, index) {
                    return Obx(() {
                      return InkWell(
                        onTap: () async {
                          SharedPreferences prefLang =
                              await SharedPreferences.getInstance();
                          controller.select.value = index;
                          controller.langSel.value = controller.data[index];
                          if (index == 0) {
                            var locale = const Locale('en', 'US');
                            Get.updateLocale(locale);
                          } else if (index == 1) {
                            var locale = const Locale("hi", "HI");
                            Get.updateLocale(locale);
                          }
                          await prefLang.setInt(
                              'selected_language_index', index);
                          log("message ${controller.langSel}");
                        },
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                                border: Border.all(color: controller.select.value == index
                                    ? ColorConstants.primaryColor
                                    : Colors.grey,)
                          ),
                          child: Center(
                            child: Text(
                              controller.data[index],
                              style: TextStyle(
                                color: controller.select.value == index
                                    ? ColorConstants.primaryColor
                                    : Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'NotoSans'
                              ),
                            ),
                          ),
                        ),
                      );
                    });
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 32,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 52,
              ),
              CustomElevatedButton(
                buttonColor: Colors.green,
                onPress: () {
                  Get.to(
                    () => FarmerLoginScreen(),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 500),
                  );
                },
                widget: Text("ACCEPT"),
              ),
              SizedBox(
                height: 1,
              ),
              // RichText(
              //     text: TextSpan(children: [
              //   TextSpan(
              //     text: "I read and accept the ",
              //     style: Theme.of(context).textTheme.headlineMedium,
              //   ),
              //   TextSpan(
              //     text: "terms of use ",
              //     style: Theme.of(context)
              //         .textTheme
              //         .headlineMedium!
              //         .copyWith(color: Colors.blue),
              //   ),
              //   TextSpan(
              //     text: "and the",
              //     style: Theme.of(context).textTheme.headlineMedium,
              //   ),
              //   TextSpan(
              //     text: "privacy policy",
              //     style: Theme.of(context)
              //         .textTheme
              //         .headlineMedium!
              //         .copyWith(color: Colors.blue),
              //   ),
              // ]))
            ],
          ),
        ),
      ),
    );
  }
}
