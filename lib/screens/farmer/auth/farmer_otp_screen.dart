import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../controllers/farmer/login_controller.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_button.dart';

class OtpScreen extends StatelessWidget {
  final String phone;
  final int otp;
  final AuthController authController = Get.put(AuthController());
  final TextEditingController pinController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  OtpScreen({Key? key, required this.phone, required this.otp})
      : super(key: key) {
    authController.startResendTimer();
  }

  @override
  Widget build(BuildContext context) {

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 50,
      textStyle: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
      ),
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          alignment: Alignment.bottomCenter,
          image: AssetImage("assets/images/farm_land.png"),
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42.0),
          child: Column(
            children: [
              SizedBox(height: 75),
              Text('OTP_Sent'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontFamily: 'Bitter')),
              SizedBox(height: 4),
              Text(
                '${'OTP_has_been_sent_to'.tr} $phone',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontFamily: 'NotoSans'),
              ),
              SizedBox(height: 4),
              Obx(() => authController.resendDelay.value == 0
                  ? InkWell(
                      onTap: authController.resetResendTimer,
                      child: Text(
                        'Resend',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.green, fontFamily: 'NotoSans'),
                      ),
                    )
                  : Text(
                      'Resend OTP in ${authController.resendDelay.value} sec',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    )),
              SizedBox(height: 52),
              Form(
                key: _formKey,
                child: Pinput(
                  length: 6,
                  controller: pinController,
                  keyboardType: TextInputType.phone,
                  defaultPinTheme: defaultPinTheme,
                  validator: (pinValue) {
                    if (pinValue == null ||
                        pinValue.isEmpty ||
                        pinValue.length < 6) {
                      return "enter valid otp";
                    }
                    return null;
                  },
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(1),
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                ),
              ),
              SizedBox(height: 16),
              CustomTextButton(
                buttonText: "change_phone_number".tr,
                buttonColor: Color(0xff00B251),
                size: 14,
                onPress: () => Get.back(),
              ),
              Obx(() => CustomElevatedButton(
                    buttonColor: Color(0xff00B251),
                    onPress: pinController.text.isEmpty
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              authController.verifyOTP(
                                  phone: phone, otp: pinController.text);
                            }
                          }
                        : () => authController.verifyOTP(
                            phone: phone, otp: pinController.text),
                    widget: authController.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "verify_otp".tr,
                            style: TextStyle(
                                fontFamily: 'NotoSans',
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
