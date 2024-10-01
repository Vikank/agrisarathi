import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpo_assist/controllers/fpo/fpo_login_controller.dart';
import 'package:fpo_assist/screens/farmer/auth/farmer_otp_screen.dart';
import 'package:fpo_assist/screens/shared/privacy_policy.dart';
import 'package:fpo_assist/utils/color_constants.dart';
import 'package:get/get.dart';
import '../../../controllers/farmer/login_controller.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/textfield_heading_text.dart';
import '../../shared/privacy_policy_hindi.dart';

class FarmerLoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());

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
          padding: const EdgeInsets.symmetric(horizontal: 42.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 75,
              ),
              Center(
                child: Text(
                  "Login_With_Phone_Number".tr,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontFamily: 'GoogleSans'),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Center(
                child: Text("We_wil_send_you_an_OTP_on_this_number".tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontFamily: 'GoogleSans')),
              ),
              const SizedBox(
                height: 52,
              ),
              Column(
                children: [
                  Text("Enter_your_Mobile_Number".tr,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontFamily: 'GoogleSans',
                          color: ColorConstants.fieldNameColor)),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      inputType: TextInputType.phone,
                      validator: (value) {
                        if (!GetUtils.isPhoneNumber(value!)) {
                          return "Please_enter_a_valid_phone_number".tr;
                        } else {
                          return null;
                        }
                      },
                      hint: '1234567890',
                      controller: authController.phoneController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomElevatedButton(
                      widget: authController.isLoading.value
                          ? progressIndicator()
                          : Text(
                              "Send_otp".tr,
                              style: const TextStyle(
                                  fontFamily: 'GoogleSans',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                      buttonColor: const Color(0xff00B251),
                      onPress: () async {
                        if (_formKey.currentState!.validate()) {
                          await authController.sendLoginOTP(
                            phone: authController.phoneController.text,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => PrivacyPolicyHindi());
                },
                child: const Text(
                  "Privacy policy and terms & conditions.",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: "GoogleSans"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
