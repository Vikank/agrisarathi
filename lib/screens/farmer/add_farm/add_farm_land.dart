import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/farmer/dashboard_controller.dart';
import 'package:get/get.dart';

import '../../../controllers/farmer/farmer_address_controller.dart';
import '../../../utils/color_constants.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../dashboard/farmer_home_screen.dart';

class AddFarmLand extends StatelessWidget {
  final FarmerAddressController farmerAddressController =
  Get.put(FarmerAddressController());
  FarmerDashboardController farmerDashboardController = Get.put(FarmerDashboardController());
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
                            farmerAddressController.state = selectedStateId;
                          },
                        );
                      }),
                    ),
                    SizedBox(width: 10,),
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please choose district';
                            }
                            return null;
                          },
                          value: farmerAddressController.district != null
                              ? farmerAddressController.district.toString()
                              : null,
                          items: farmerAddressController.districts
                              .map<DropdownMenuItem<String>>((district) {
                            return DropdownMenuItem<String>(
                              value: district['district'],
                              child: Text(district['district']),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            int selectedDistrictId = farmerAddressController.districts
                                .firstWhere((element) =>
                            element['district'] == newValue)['id'];
                            farmerAddressController.district = selectedDistrictId;
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
                SizedBox(height: 10,),
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
                            'Crop'.tr,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: 12,
                              fontFamily: 'NotoSans',
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please choose crop';
                            }
                            return null;
                          },
                          value: farmerAddressController.selectedCropId != null
                              ? farmerAddressController.selectedCropId.toString()
                              : null,
                          items: farmerAddressController.crops
                              .map<DropdownMenuItem<String>>((crop) {
                            return DropdownMenuItem(
                              value: crop['id'],
                              child: Text(crop['name']),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            farmerAddressController.selectedCropId = newValue;
                            farmerAddressController.fetchVarieties(newValue!);
                          },
                        );
                      }),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Obx(() {
                        print("Selected Variety ID: ${farmerAddressController.selectedVarietyId}");
                        print("Varieties: ${farmerAddressController.varieties}");

                        Set<String> usedValues = Set<String>();
                        List<DropdownMenuItem<String>> dropdownItems = [];

                        if (farmerAddressController.varieties.isNotEmpty) {
                          // Filter and create dropdown items
                          dropdownItems = farmerAddressController.varieties
                              .where((variety) => variety['id'] != null && variety['name'] != null)
                              .map<DropdownMenuItem<String>>((variety) {
                            String id = variety['id'].toString();
                            if (!usedValues.contains(id)) {
                              usedValues.add(id);
                              return DropdownMenuItem<String>(
                                value: id,
                                child: Text(variety['name'].toString()),
                              );
                            } else {
                              // Return a default item with a unique value
                              return DropdownMenuItem<String>(
                                value: '',  // Use a placeholder value
                                child: Text('Unknown'),
                              );
                            }
                          }).toList();

                          // Add a "None" option at the start
                          dropdownItems.insert(0, DropdownMenuItem<String>(
                            value: '',
                            child: Text('None'),
                          ));
                        }

                        print("Dropdown Items:");
                        dropdownItems.forEach((item) {
                          print("Item value: ${item.value}");
                        });

                        String? currentValue = farmerAddressController.selectedVarietyId?.toString() ?? '';

                        // Ensure that the currentValue exists in dropdownItems
                        if (!dropdownItems.any((item) => item.value == currentValue)) {
                          currentValue = '';  // Or set it to null if you want the hint to show
                        }

                        print("Current Value: $currentValue");

                        return DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: ColorConstants.primaryColor),
                            ),
                          ),
                          hint: Text(
                            'Variety'.tr,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: 12,
                              fontFamily: 'NotoSans',
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please choose variety';
                            }
                            return null;
                          },
                          value: currentValue.isEmpty ? null : currentValue,
                          items: dropdownItems,
                          onChanged: (String? newValue) {
                            print("Dropdown onChanged: $newValue");
                            farmerAddressController.selectedVarietyId = newValue?.isEmpty ?? true ? null : newValue;
                          },
                        );
                      }),
                    )


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
                  await farmerAddressController.addNewLand().then((value){
                    farmerDashboardController.fetchFarmerLands();
                  });
                  Get.offAll(()=>FarmerHomeScreen());
                }
                },
              widget: farmerAddressController.loading.value
                  ? progressIndicator()
                  : Text(
                "Done".tr,
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
