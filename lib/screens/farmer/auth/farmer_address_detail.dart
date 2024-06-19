import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpo_assist/screens/shared/select_crop_screen.dart';
import 'package:fpo_assist/utils/color_constants.dart';
import 'package:fpo_assist/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';

import '../../../controllers/farmer/farmer_address_controller.dart';

class FarmerAddressDetail extends StatelessWidget {
  final FarmerAddressController farmerAddressController =
      Get.put(FarmerAddressController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Farm's Address",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Bitter')),
        // centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_outlined)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Address",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontFamily: 'Bitter',
                        color: ColorConstants.primaryColor)),
                SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: farmerAddressController.addressLine,
                  cursorColor: ColorConstants.primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorConstants.primaryColor),
                    ),
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: 'NotoSans',
                    ),
                    hintText: "Line 1",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: farmerAddressController.pinCode,
                        cursorColor: ColorConstants.primaryColor,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorConstants.primaryColor),
                          ),
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: 'NotoSans',
                          ),
                          hintText: "Pin Code",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter pin code';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Obx(() {
                        return DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.primaryColor),
                            ),
                          ),
                          hint: Text(
                            'State',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: 12,
                              fontFamily: 'NotoSans',
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please choose state';
                            }
                            return null;
                          },
                          value: farmerAddressController.states.isNotEmpty
                              ? farmerAddressController.states[0]['state']
                              : null,
                          items: farmerAddressController.states
                              .map<DropdownMenuItem<String>>((state) {
                            return DropdownMenuItem(
                              value: state['state'],
                              child: Text(state['state']),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            int selectedStateId = farmerAddressController.states
                                .firstWhere((element) =>
                                    element['state'] == newValue)['id'];
                            farmerAddressController.fetchDistricts(
                                selectedStateId); // Fetch districts on state change
                            farmerAddressController.state = newValue;
                          },
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        return DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.primaryColor),
                            ),
                          ),
                          hint: Text(
                            'District',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: 12,
                              fontFamily: 'NotoSans',
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please choose district';
                            }
                            return null;
                          },
                          value: farmerAddressController.districts.isNotEmpty
                              ? farmerAddressController.districts[0]['district']
                              : null,
                          items: farmerAddressController.districts
                              .map<DropdownMenuItem<String>>((district) {
                            return DropdownMenuItem<String>(
                              value: district['district'],
                              child: Text(district['district']),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            farmerAddressController.district = newValue;
                          },
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: farmerAddressController.village,
                  cursorColor: ColorConstants.primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorConstants.primaryColor),
                    ),
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: 'NotoSans',
                    ),
                    hintText: "Village",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter village';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 48,
                ),
                Text("Land Area",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontFamily: 'Bitter',
                        color: ColorConstants.primaryColor)),
                TextFormField(
                  controller: farmerAddressController.landArea,
                  cursorColor: ColorConstants.primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorConstants.primaryColor),
                    ),
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: 'NotoSans',
                    ),
                    hintText: "In acers",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter land area';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        return BottomAppBar(
          color: Colors.white,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
            child: CustomElevatedButton(
              buttonColor: Colors.green,
              onPress: () {
                if (_formKey.currentState!.validate()) {
                  farmerAddressController.postFarmerAddress();
                }
              },
              widget: farmerAddressController.loading.value
                  ? progressIndicator()
                  : Text(
                      "NEXT",
                      style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
            ),
          ),
        );
      }),
    );
  }
}
