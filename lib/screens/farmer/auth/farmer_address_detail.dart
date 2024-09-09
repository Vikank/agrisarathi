import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpo_assist/screens/shared/select_crop_screen.dart';
import 'package:fpo_assist/utils/color_constants.dart';
import 'package:fpo_assist/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';

import '../../../controllers/farmer/farmer_address_controller.dart';
import '../../../models/select_crop_model.dart';
import 'farmer_update_profile_screen.dart';

class FarmerAddressDetail extends StatelessWidget {
  RxList<Crop> selectedCrops;
  int? cropVariety;
  FarmerAddressDetail({super.key, required this.selectedCrops, this.cropVariety});

  final FarmerAddressController farmerAddressController =
      Get.put(FarmerAddressController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Farm’s_Address".tr,
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
                Text("Add_Address".tr,
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
                    hintText: "Address_Line_1".tr,
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
                        keyboardType: TextInputType.phone,
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
                          hintText: "Pin_Code".tr,
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
                            'State'.tr,
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
                          value: farmerAddressController.state != null
                              ? farmerAddressController.state.toString()
                              : null,
                          items: farmerAddressController.states
                              .map<DropdownMenuItem<String>>((state) {
                            return DropdownMenuItem(
                              value: state['state_name'],
                              child: Text(state['state_name']),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            int selectedStateId = farmerAddressController.states
                                .firstWhere((element) =>
                                    element['state_name'] == newValue)['id'];
                            farmerAddressController.fetchDistricts(
                                selectedStateId); // Fetch districts on state change
                            farmerAddressController.state = selectedStateId;
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
                            'District'.tr,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: 12,
                              fontFamily: 'NotoSans',
                            ),
                          ),
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Please choose district';
                          //   }
                          //   return null;
                          // },
                          value: farmerAddressController.district != null
                              ? farmerAddressController.district.toString()
                              : null,
                          items: farmerAddressController.districts
                              .map<DropdownMenuItem<String>>((district) {
                            return DropdownMenuItem<String>(
                              value: district['district_name'],
                              child: Text(district['district_name']),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            int selectedDistrictId = farmerAddressController
                                .districts
                                .firstWhere((element) =>
                                    element['district_name'] == newValue)['id'];
                            farmerAddressController.district =
                                selectedDistrictId;
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
                    hintText: "Village".tr,
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
                Text("Add_Land_Area".tr,
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
                    hintText: "Field_area_in_acres".tr,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter land area';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24,),
                SizedBox(height: 24,),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Obx(() => Radio<String>(
                            value: 'Owned',
                            groupValue: farmerAddressController.selectedPropertyType.value,
                            onChanged: (value) {
                              farmerAddressController.setSelectedPropertyType(value!);
                            },
                          )),
                          Text('Owned'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Obx(() => Radio<String>(
                            value: 'Rented',
                            groupValue: farmerAddressController.selectedPropertyType.value,
                            onChanged: (value) {
                              farmerAddressController.setSelectedPropertyType(value!);
                            },
                          )),
                          Text('Rented'),
                        ],
                      ),
                    ),
                  ],
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
              onPress: () async{
                if (_formKey.currentState!.validate()) {
                  await farmerAddressController.postFarmerAddress(selectedCropId: selectedCrops.first.id, selectedVarietyId: cropVariety);
                }
              },
              widget: farmerAddressController.loading.value
                  ? progressIndicator()
                  : Text(
                      "Next".tr,
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
