import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/select_role_controller.dart';
import 'package:fpo_assist/screens/shared/language_selection.dart';
import 'package:fpo_assist/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';

import '../shared/language_selection.dart';

class RoleScreen extends StatelessWidget {
  SelectRoleController selectRoleController = Get.put(SelectRoleController());

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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: 75,
              ),
              Text(
                "Who are you?",
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineLarge!.copyWith(fontFamily: 'Bitter'),
              ),
              SizedBox(
                height: 52,
              ),
              CustomElevatedButton(
                buttonColor: Colors.green, onPress: () {
                selectRoleController.setUserRole("FARMER");
                  Get.to(()=> LanguageSelection());
              }, widget: Text("FARMER", style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white, fontFamily: 'NotoSans'),),),

              SizedBox(
                height: 24,
              ),
              CustomElevatedButton(
                buttonColor: Colors.green, onPress: () {
                selectRoleController.setUserRole("FPO");
                Get.to(()=> LanguageSelection());
              }, widget: Text("FPO", style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white, fontFamily: 'NotoSans'),),),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
