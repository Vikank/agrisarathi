import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpo_assist/screens/farmer/detect_disease/choose_farm_land.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../controllers/farmer/service_provider_controller.dart';
import '../../../models/service_provider_model.dart';
import '../../../utils/color_constants.dart';

class SelectServiceProvider extends StatelessWidget {

  ServiceProviderController controller = Get.put(ServiceProviderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Select Service Provider",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: "Bitter"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                onChanged: (value) => {},
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: ColorConstants.textFieldBgClr,
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search_Service_Provider".tr,
                    hintStyle: TextStyle(fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'NotoSans')
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Please_select_your_service_provider_whose_app_you_wanna_use'
                    .tr,
                style: TextStyle(fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'NotoSans'),
              ),
            ),
            SizedBox(height: 24,),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Obx(() {
                  return controller.loading.value ? Center(child: CircularProgressIndicator()) : GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                    ),
                    itemCount: controller.serviceProviderModel.value.data
                        ?.length,
                    itemBuilder: (BuildContext context, int index) {
                      var serviceProvider = controller.serviceProviderModel
                          .value.data![index];
                      return InkWell(
                        onTap: () {
                          controller.serviceId.value =
                              serviceProvider.id ?? 1;
                          if (index != 0) {
                            Fluttertoast.showToast(
                                msg: "Comming Soon",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: ColorConstants.primaryColor,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }else{
                            Get.to(ChooseFarmLand());
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              margin: EdgeInsets.only(top: 1, bottom: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xff002833d).withOpacity(
                                    0.06),
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage('${ApiEndPoints
                                      .imageBaseUrl}${serviceProvider
                                      .serviceProviderPic ?? ""}'),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                serviceProvider.name ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: ColorConstants.textColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  fontFamily: "NotoSans"
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
