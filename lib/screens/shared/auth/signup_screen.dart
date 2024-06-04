import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/signup_controller.dart';
import 'package:fpo_assist/widgets/custom_text_button.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/textfield_heading_text.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .sizeOf(context)
        .height;
    final width = MediaQuery
        .sizeOf(context)
        .width;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background_image.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: height / 8),
            child: Column(
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
                            Center(
                                child: Text("Sign up",
                                    style:
                                    Theme
                                        .of(context)
                                        .textTheme
                                        .headlineLarge)),
                            const SizedBox(
                              height: 4,
                            ),
                            Center(
                                child: Text(
                                    "Sign up to start your journey with us",
                                    style:
                                    Theme
                                        .of(context)
                                        .textTheme
                                        .headlineMedium)),
                            const SizedBox(
                              height: 24,
                            ),
                            const TextfieldHeadingText(textData: "Name of FPO"),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextField(
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Name is required';
                                } else {
                                  return null;
                                }
                              },
                              hint: 'Enter your name',
                              controller: controller.nameController,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            // const TextfieldHeadingText(textData: "Email Id"),
                            // const SizedBox(
                            //   height: 8,
                            // ),
                            // CustomTextField(
                            //   validator: (value) {
                            //     if (value != null && value.isEmpty) {
                            //       return 'Email is required';
                            //     }
                            //     if (!GetUtils.isEmail(value!)) {
                            //       return "Email is not valid";
                            //     }
                            //     return null;
                            //   },
                            //   hint: 'Enter your email',
                            //   controller: controller.emailController,
                            // ),
                            // const SizedBox(
                            //   height: 24,
                            // ),
                            const TextfieldHeadingText(
                                textData: "Phone number"),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextField(
                              inputType: TextInputType.number,
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Phone is required';
                                }
                                if (!GetUtils.isPhoneNumber(value!)) {
                                  return "Phone is not valid";
                                }
                                return null;
                              },
                              hint: 'Enter your Phone number',
                              controller: controller.phoneController,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const TextfieldHeadingText(textData: "Password"),
                            const SizedBox(
                              height: 8,
                            ),
                            Obx(() {
                              return TextFormField(
                                obscureText: controller.passwordVisible.value,
                                controller: controller.passwordController,
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return 'Password is required';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  suffixIconConstraints: const BoxConstraints(
                                      maxHeight: 32),
                                  suffixIcon: IconButton(
                                    icon: Icon(controller.passwordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                      color: Colors.grey,),
                                    onPressed: () {
                                      controller.passwordVisible.value =
                                      !controller.passwordVisible.value;
                                    },
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff959CA3)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff959CA3)),
                                  ),
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey
                                  ),
                                  hintText: "Enter your password",
                                ),
                              );
                            }),
                            const SizedBox(
                              height: 24,
                            ),
                            const TextfieldHeadingText(
                                textData: "Confirm Password"),
                            const SizedBox(
                              height: 8,
                            ),
                            Obx(() {
                              return TextFormField(
                                obscureText: controller.confirmPasswordVisible
                                    .value,
                                controller: controller
                                    .confirmPasswordController,
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return 'Conform password is required';
                                  }
                                  if (value !=
                                      controller.passwordController.text) {
                                    return 'Confirm password not matching';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  suffixIconConstraints: BoxConstraints(
                                      maxHeight: 32),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.confirmPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,),
                                    onPressed: () {
                                      controller.confirmPasswordVisible.value =
                                      !controller.confirmPasswordVisible.value;
                                    },
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff959CA3)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff959CA3)),
                                  ),
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey
                                  ),
                                  hintText: "Enter the same password",
                                ),
                              );
                            }),
                            const SizedBox(
                              height: 24,
                            ),
                            Obx(() {
                              return CustomElevatedButton(
                                widget: controller.loading.value
                                    ? progressIndicator()
                                    : const Text(
                                  "SIGN UP",
                                  style: TextStyle(fontFamily: 'Roboto',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                buttonColor: Color(0xff00B251),
                                onPress: () {
                                  if (_formKey.currentState!.validate()) {
                                    log("submit is pressed");
                                    controller.registerWithEmail();
                                  }
                                },
                              );
                            }),
                            Center(
                              child: CustomTextButton(
                                buttonText: 'LOGIN',
                                buttonColor: Color(0xff00B251),
                                onPress: () {
                                  Get.off(LoginScreen());
                                }, size: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
