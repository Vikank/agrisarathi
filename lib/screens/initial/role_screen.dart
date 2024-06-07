import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/select_role_controller.dart';
import 'package:fpo_assist/screens/shared/auth/language_selection.dart';
import 'package:fpo_assist/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';

class RoleScreen extends StatelessWidget {
  SelectRoleController selectRoleController = Get.put(SelectRoleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/background_image.png",
              ),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.5,
                      ),
                      Text(
                        "Who are you?",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineLarge,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      CustomElevatedButton(
                        buttonColor: Colors.green, onPress: () {
                        selectRoleController.setUserRole("FARMER");
                          Get.to(()=> LanguageSelection());
                      }, widget: Text("FARMER", style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white),),),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Or",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomElevatedButton(
                        buttonColor: Colors.green, onPress: () {
                        selectRoleController.setUserRole("FPO");
                        Get.to(()=> LanguageSelection());
                      }, widget: Text("FPO", style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white),),),
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
