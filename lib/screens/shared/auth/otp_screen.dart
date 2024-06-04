import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:fpo_assist/widgets/custom_text_button.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/widgets/custom_elevated_button.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api_constants.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

  class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();
  bool loading = false;
  int _resendDelay = 60;
  Timer? _resendTimer;

  int get resendDelay => _resendDelay;

  void startResendTimer() {
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendDelay <= 0) {
        _resendTimer?.cancel();
      } else {
        _resendDelay--;
        setState(() {});
      }
    });
    setState(() {});
  }

  void resetResendTimer() {
    _resendDelay = 60;
    startResendTimer();
    setState(() {});
  }

  onButtonPressed() async {
    await Future.delayed(const Duration(seconds: 2), () => otpVerify());
    return () {};
  }

  int select = 0;

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/background_image.png",
              ),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1, 1),
                          blurRadius: 5,
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 2,
                      ),
                      Center(
                        child: Text('OTP Sent',
                            style: Theme.of(context).textTheme.headlineLarge),
                      ),
                      SizedBox(
                        height: 1.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'OTP has been sent to ${widget.email}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      resendDelay == 0
                          ? Center(
                              child: InkWell(
                                onTap: () {
                                  resetResendTimer();
                                },
                                child: Text(
                                  'Resend',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (select == 1)
                                  Text(
                                    '$resendDelay ${'sec'} ',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                if (select == 1)
                                  Text(
                                    'Resend OTP in ',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                if (select == 0)
                                  Text(
                                    'Resend OTP in ',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                if (select == 0)
                                  Text(
                                    '$resendDelay',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                if (select == 0)
                                  Text(
                                    'sec',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                              ],
                            ),
                      SizedBox(
                        height: 5,
                      ),
                      Pinput(
                        length: 6,
                        controller: pinController,
                        keyboardType: TextInputType.phone,
                        keyboardAppearance: Brightness.light,
                        listenForMultipleSmsOnAndroid: true,
                        defaultPinTheme: defaultPinTheme,
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {},
                        onChanged: (value) {},
                        validator: (pinValue) {
                          if (pinValue == null || pinValue.isEmpty) {
                            return "enter valid otp";
                          } else if (pinController.length < 6) {
                            return "enter valid otp";
                          } else {
                            return null;
                          }
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: Colors.white.withOpacity(0.10),
                            ),
                          ],
                        ),
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
                      SizedBox(
                        height: 1,
                      ),
                      const Spacer(),
                      CustomElevatedButton(
                        buttonColor: Color(0xff00B251),
                        onPress: pinController.text.isEmpty
                            ? () {
                          if (_formKey.currentState!.validate()) {}
                        }
                            : onButtonPressed,
                        widget: loading ? progressIndicator() : Text(
                          "VERIFY OTP",
                          style: TextStyle(fontFamily: 'Roboto', fontSize: 15, fontWeight: FontWeight.w500),
                        ),),
                      CustomTextButton(buttonText: "CHANGE EMAIL", buttonColor: Color(0xff00B251), size: 14, onPress: (){
                        Get.back();
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> otpVerify() async {
    setState(() {
      loading = true;
    });
    log("OTP is ${int.parse(pinController.text)}");
    var headers = {'Content-Type': 'application/json'};
    Map body = {
      "email": widget.email,
      "entered_otp": int.parse(pinController.text),
    };
    log("map is ${body}");
      var response = await http.post(
        Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.verifyOtp),
        body: jsonEncode(body),
        headers: headers
      );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.snackbar("Success", "Otp verified");
          setState(() {
            loading = false;
          });
        } else {
          setState(() {
            loading = false;
          });
          Get.snackbar("Error", "Otp invalid");
        }


  }
}
