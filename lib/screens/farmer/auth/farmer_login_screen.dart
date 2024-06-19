import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/fpo/fpo_login_controller.dart';
import 'package:fpo_assist/screens/farmer/auth/farmer_otp_screen.dart';
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
                  "Login With Phone Number",
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
                child: Text("We wil send you an OTP on this number",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!.copyWith(fontFamily: 'NotoSans')),
              ),
              SizedBox(height: 52,),
              Column(
                children: [
                  Text("Enter your Mobile Number",
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
                          return "Phone is not valid";
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
                              "SEND OTP",
                              style: TextStyle(
                                  fontFamily: 'NotoSans',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                      buttonColor: Color(0xff00B251),
                      onPress: () {
                        // if (_formKey.currentState!.validate()) {
                        //   controller.loginWithEmail();
                        // }
                        Get.to(()=> OtpScreen(phone: controller.phoneController.text));
                      },
                    ),
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
