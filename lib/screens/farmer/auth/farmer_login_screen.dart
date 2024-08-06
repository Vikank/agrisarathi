import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/fpo/fpo_login_controller.dart';
import 'package:fpo_assist/screens/farmer/auth/farmer_otp_screen.dart';
import 'package:fpo_assist/screens/shared/privacy_policy.dart';
import 'package:fpo_assist/utils/color_constants.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/textfield_heading_text.dart';

class FarmerLoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  FpoLoginController controller = Get.put(FpoLoginController());

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
              SizedBox(
                height: 75,
              ),
              Center(
                child: Text(
                  "Login_With_Phone_Number".tr,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontFamily: 'Bitter'),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Center(
                child: Text("We_wil_send_you_an_OTP_on_this_number".tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!.copyWith(fontFamily: 'NotoSans')),
              ),
              SizedBox(height: 52,),
              Column(
                children: [
                  Text("Enter_your_Mobile_Number".tr,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!.copyWith(fontFamily: 'NotoSans', color: ColorConstants.fieldNameColor)),
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
                      controller: controller.phoneController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomElevatedButton(
                      widget: controller.loading.value
                          ? progressIndicator()
                          : Text(
                              "Send_otp".tr,
                              style: TextStyle(
                                  fontFamily: 'NotoSans',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                      buttonColor: Color(0xff00B251),
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          Get.to(()=> OtpScreen(phone: controller.phoneController.text));
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1,),
              TextButton(
                onPressed: (){
                  Get.to(()=>PrivacyPolicy());
                }, child: Text("Privacy policy and terms & conditions.", style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "Bitter"),),

              )
            ],
          ),
        ),
      ),
    );
  }
}
