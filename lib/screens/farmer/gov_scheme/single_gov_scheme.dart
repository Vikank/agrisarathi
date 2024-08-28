import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/gov_scheme_model.dart';

class SingleSchemeScreen extends StatelessWidget {
  final SchemeModel scheme;

  SingleSchemeScreen({required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "gov_scheme".tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              scheme.schemeName ?? "",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: "Bitter"
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${scheme.ministryName ?? ""}',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: "NotoSans"
              ),
            ),
            SizedBox(
              height: 16,
            ),
            CachedNetworkImage(
              imageUrl: "https://api.agrisarathi.com/api/${scheme.schemeImage}",
              imageBuilder: (context, imageProvider) => Container(
                height: 190,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              placeholder: (context, url) => SizedBox(
                  height: 10,
                  width: 10,
                  child: const CircularProgressIndicator(
                    strokeAlign: 2,
                    strokeWidth: 2,
                  )),
              errorWidget: (context, url, error) => SizedBox(
                height: 190,
                width: double.infinity,
                child: Image.asset("assets/images/gov_scheme_placeholder.png"),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(child: DefaultTabController(
              length: 6,
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      labelColor: Colors.green,
                      unselectedLabelColor: Colors.black,
                      indicatorColor: Colors.green,
                      dividerHeight: 0,
                      tabAlignment: TabAlignment.start,
                      tabs: [
                        Tab(text: 'Details'.tr),
                        Tab(text: 'Benefits'.tr),
                        Tab(text: 'Eligibility'.tr),
                        Tab(text: 'Application_Process'.tr),
                        Tab(text: 'Document_required'.tr),
                        Tab(text: 'Links'.tr),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          detailsTab(scheme.details ?? "No data available"),
                          benefitsTab(scheme.benefits ?? "No data available"),
                          eligibilityTab(scheme.eligibility ?? "No data available"),
                          applicationProcessTab(scheme.applicationProcess ?? "No data available"),
                          documentRequiredTab(scheme.documentRequire ?? "No data available"),
                          schemeLinksTab(scheme.applicationformLink ?? "" + scheme.reference! ?? ""),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),),
          ],
        ),
      ),
    );
  }

  Widget detailsTab(String details){
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(details, style: TextStyle(fontFamily: "NotoSans", fontSize: 12, fontWeight: FontWeight.w400),),
    );
  }

  Widget benefitsTab(String benefits){
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(benefits, style: TextStyle(fontFamily: "NotoSans", fontSize: 12, fontWeight: FontWeight.w400),),
    );
  }

  Widget eligibilityTab(String eligibility){
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(eligibility, style: TextStyle(fontFamily: "NotoSans", fontSize: 12, fontWeight: FontWeight.w400),),
    );
  }

  Widget applicationProcessTab(String applicationProcess){
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(applicationProcess, style: TextStyle(fontFamily: "NotoSans", fontSize: 12, fontWeight: FontWeight.w400),),
    );
  }

  Widget documentRequiredTab(String documentRequire){
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(documentRequire, style: TextStyle(fontFamily: "NotoSans", fontSize: 12, fontWeight: FontWeight.w400),),
    );
  }

  Widget schemeLinksTab(String links){
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(links ?? "No data available", style: TextStyle(fontFamily: "NotoSans", fontSize: 12, fontWeight: FontWeight.w400),),
    );
  }
}