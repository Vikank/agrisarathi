import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:fpo_assist/screens/shared/select_crop_screen.dart';
import 'package:fpo_assist/widgets/custom_text_button.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/widgets/custom_elevated_button.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/api_constants.dart';
import 'farmer_address_detail.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({required this.phone});

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
    Get.to(()=>FarmerAddressDetail());
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
              children: [
                SizedBox(
                  height: 75,
                ),
                Center(
                  child: Text('OTP_Sent'.tr,
                      style: Theme.of(context).textTheme.headlineLarge!
                          .copyWith(fontFamily: 'Bitter')),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${'OTP_has_been_sent_to'.tr} ${widget.phone}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontFamily: 'NotoSans'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
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
                            style: TextStyle(color: Colors.green, fontFamily: 'NotoSans'),
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
                  height: 52,
                ),
                Form(
                  key: _formKey,
                  child: Pinput(
                    length: 5,
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
                      } else if (pinController.length < 5) {
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
                ),
                SizedBox(
                  height: 16,
                ),
                CustomTextButton(buttonText: "change_phone_number".tr, buttonColor: Color(0xff00B251), size: 14, onPress: (){
                  Get.back();
                }),
                CustomElevatedButton(
                  buttonColor: Color(0xff00B251),
                  onPress: pinController.text.isEmpty
                      ? () {
                    if (_formKey.currentState!.validate()) {}
                  }
                      : onButtonPressed,
                  widget: loading ? progressIndicator() : Text(
                    "verify_otp".tr,
                    style: TextStyle(fontFamily: 'NotoSans', fontSize: 15, fontWeight: FontWeight.w500),
                  ),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  Future<void> otpVerify() async {
    setState(() {
      loading = true;
    });
    log("OTP is ${int.parse(pinController.text)}");
    var headers = {'Content-Type': 'application/json'};
    Map body = {
      "mobile_no": widget.phone,
      "user_language": 1,
    };
    log("map is ${body}");
      var response = await http.post(
        Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.farmerLogin),
        body: jsonEncode(body),
        headers: headers
      );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.snackbar("Success", "Otp verified");
          final json = jsonDecode(response.body);
          var farmerId = json['obj_id'];
          log("farmer id to be set ${json['obj_id']}");
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('farmerId', farmerId.toString());
          await prefs.setString('mobile_no', widget.phone);
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
