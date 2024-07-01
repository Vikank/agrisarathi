import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../models/service_provider_model.dart';
import '../../../utils/color_constants.dart';

class SelectServiceProvider extends StatefulWidget {
  @override
  State<SelectServiceProvider> createState() => _SelectServiceProviderState();
}

class _SelectServiceProviderState extends State<SelectServiceProvider> {


  ServiceProviderModel serviceProviderModel = ServiceProviderModel();

  int? sel;
  var serId ;

  @override
  void initState() {
    getService();
    super.initState();
  }

  void getService() async {
    var response = await http.get(
      Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.getServiceProviderList),
    );
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        serviceProviderModel = ServiceProviderModel.fromJson(data);
      });
    } else {
      Fluttertoast.showToast(
          msg: "Failed to fetch data. Please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Service Provider",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
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
                    hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'NotoSans')
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Please_select_your_service_provider_whose_app_you_wanna_use'.tr,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'NotoSans'),
              ),
            ),
            SizedBox(height: 24,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 1.0,
                    mainAxisExtent: 17
                ),
                itemCount:serviceProviderModel.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        serId = serviceProviderModel.data?[index].id??"";
                        sel = index;
                        if(index!=0){
                          Fluttertoast.showToast(
                              msg: "Comming Soon",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: ColorConstants.primaryColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 10,
                          width: 20,
                          margin: EdgeInsets.only(top: 1, bottom: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xff002833d).withOpacity(0.06),
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                              color: sel == index? ColorConstants.primaryColor:Colors.transparent,
                            ),
                            image: DecorationImage(
                              image: NetworkImage('${ApiEndPoints.imageBaseUrl}${serviceProviderModel.data?[index].serviceProviderPic??""}'),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 20,
                            height: 5,
                            child: Text(
                              serviceProviderModel.data?[index].name??"",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  color: ColorConstants.textColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
