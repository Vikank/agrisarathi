import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/login_controller.dart';
import 'package:fpo_assist/screens/shared/auth/signup_screen.dart';
import 'package:fpo_assist/widgets/custom_text_button.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/textfield_heading_text.dart';


class LoginScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background_image.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Card(
                elevation: 10,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text("Login", style: Theme
                            .of(context)
                            .textTheme
                            .headlineLarge)),
                        const SizedBox(height: 4,),
                        Center(
                            child: Text("Welcome, to our platform.", style: Theme
                                .of(context)
                                .textTheme
                                .headlineMedium)),
                        const SizedBox(height: 24,),
                        const TextfieldHeadingText(textData: "Phone Number"),
                        const SizedBox(height: 8,),
                        CustomTextField(
                          validator: (value) {
                            if (!GetUtils.isPhoneNumber(value!)) {
                              return "Phone is not valid";
                            } else {
                              return null;
                            }
                        },
                          hint: 'Enter your phone',
                          controller: controller.phoneController,),
                        const SizedBox(height: 24,),
                        CustomElevatedButton(widget: controller.loading.value ? progressIndicator() : Text(
                          "Login",
                          style: TextStyle(fontFamily: 'Roboto', fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                          buttonColor: Color(0xff00B251),
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              controller.loginWithEmail();
                            }
                          },),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
