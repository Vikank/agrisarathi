import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/shared/language_selection_controller.dart';
import 'package:fpo_assist/screens/farmer/auth/farmer_login_screen.dart';
import 'package:fpo_assist/screens/initial/role_screen.dart';
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
                "Select_language".tr,
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontFamily: 'GoogleSans'),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                height: 350,
                child: Obx(() {
                  return ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.langSel.value = 1;
                          controller.changeLanguage('en', 'US');
                        },
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                              border: Border.all(color: controller.langSel.value == 1
                                  ? ColorConstants.primaryColor
                                  : Colors.grey,
                              )),
                          child: Center(
                            child: Text(
                              "English / अंग्रेजी",
                              style: TextStyle(
                                  color: controller.langSel.value == 1
                                      ? ColorConstants.primaryColor
                                      : Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'GoogleSans'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          // controller.langSel.value = 2;
                          // controller.changeLanguage('hi', 'IN');
                          controller.langSel.value = 1;
                          controller.changeLanguage('en', 'US');
                        },
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: controller.langSel.value == 2
                                    ? ColorConstants.primaryColor
                                    : Colors.grey,
                              )),
                          child: Center(
                            child: Text(
                              "Hindi / हिंदी",
                              style: TextStyle(
                                  color: controller.langSel.value == 2
                                      ? ColorConstants.primaryColor
                                      : Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'GoogleSans'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.changeLanguage('en', 'US');
                        },
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Center(
                            child: Text(
                              "Marathi / मराठी",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'GoogleSans'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.changeLanguage('en', 'US');
                        },
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Center(
                            child: Text(
                              "Malyalam / മലയാളം",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'GoogleSans'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.changeLanguage('en', 'US');
                        },
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Center(
                            child: Text(
                              "Punjabi / ਪੰਜਾਬੀ",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'GoogleSans'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.changeLanguage('en', 'US');
                        },
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Center(
                            child: Text(
                              "Gujarati / ગુજરાતી",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'GoogleSans'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.changeLanguage('en', 'US');
                        },
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Center(
                            child: Text(
                              "Bangla / বাংলা",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'GoogleSans'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.changeLanguage('en', 'US');
                        },
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Center(
                            child: Text(
                              "Odia / ଓଡିଆ",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'GoogleSans'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.changeLanguage('en', 'US');
                        },
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Center(
                            child: Text(
                              "Tamil / தமிழ்",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'GoogleSans'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.changeLanguage('en', 'US');
                        },
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Center(
                            child: Text(
                              "Telgu / తెలుగు",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'GoogleSans'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(
                height: 52,
              ),
              CustomElevatedButton(
                buttonColor: Colors.green,
                onPress: () {
                  Get.to(
                        () => RoleScreen(),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 500),
                  );
                },
                widget: Text("Next".tr),
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
