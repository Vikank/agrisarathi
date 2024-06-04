import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/language_selection_controller.dart';
import 'package:fpo_assist/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class LanguageSelection extends StatelessWidget {
  LanguageSelectionController controller = Get.put(
      LanguageSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Select Language",
          style: Theme
              .of(context)
              .textTheme
              .labelLarge,
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: controller.data.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    return InkWell(
                      onTap: () async {
                        SharedPreferences prefLang = await SharedPreferences
                            .getInstance();
                        controller.select.value = index;
                        controller.langSel.value = controller.data[index];
                        if (index == 0) {
                          var locale = const Locale('en', 'US');
                          Get.updateLocale(locale);
                        } else if (index == 1) {
                          var locale = const Locale("hi", "HI");                          Get.updateLocale(locale);
                        }
                        await prefLang.setInt('selected_language_index', index);
                        log("message ${controller.langSel}");
                      },
                      child: Column(
                        children: [
                          ListTile(
                            title: Center(
                              child: Text(controller.data[index],
                                style: TextStyle(
                                  color: controller.select.value == index
                                      ? Colors.green
                                      : Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(height: 2,),
                          // Divider(
                          //   color: controller.select.value == index ? Colors.green : Colors.grey,
                          //   thickness: controller.select.value == index ? 0.5 : 1,
                          // ),
                          SizedBox(height: 2,),
                        ],
                      ),
                    );
                  });
                }, separatorBuilder: (BuildContext context, int index) {
                return Divider(height: 4, thickness: 2,);
              },
              ),
            ),
            CustomElevatedButton(
              buttonColor: Colors.green, onPress: () {
              Get.to(() => LoginScreen(),
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 500),
              );
            }, widget: Text("ACCEPT"),),
            SizedBox(height: 1,),
            RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                        text: "I read and accept the ",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineMedium,
                      ),
                      TextSpan(
                        text: "terms of use ",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.blue),
                      ),
                      TextSpan(
                        text: "and the",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineMedium,
                      ),
                      TextSpan(
                        text: "privacy policy",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.blue),
                      ),
                    ]
                ))
          ],
        ),
      ),
    );
  }
}
