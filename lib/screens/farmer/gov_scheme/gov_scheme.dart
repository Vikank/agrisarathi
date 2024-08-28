import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/screens/farmer/gov_scheme/single_gov_scheme.dart';
import 'package:get/get.dart';
import '../../../controllers/farmer/gov_scheme_controller.dart';

class SchemeListView extends StatelessWidget {
  final SchemeController controller = Get.put(SchemeController());

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
          children: [
            _buildFilterButtons(),
            Expanded(
              child: Obx(() => controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : _buildSchemeList()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Container(
      height: 106,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.filters.length,
        itemBuilder: (context, index) {
          final filter = controller.filters[index];
          final String imageName = filter['image']!;
          final String sourceName = filter['name']!;
          final String schemeFilter = filter['filter']!;
          return GestureDetector(
            onTap: () {
              controller.filterSchemes(schemeFilter);
            },
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 12.5, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: controller.filters[index] == index
                    ? Color(0xffEAFAEB)
                    : Colors.white,
              ),
              child: Column(
                children: [
                  Image.asset(
                    imageName,
                    height: 45,
                    width: 45,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    sourceName,
                    style: TextStyle(
                        fontFamily: "NotoSans",
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSchemeList() {
    return Obx(() => ListView.separated(
      itemCount: controller.filteredSchemes.length,
      separatorBuilder: (context, index) => SizedBox(height: 20,),
      itemBuilder: (context, index) {
        var scheme = controller.filteredSchemes[index];
        return InkWell(
          onTap: () {
            Get.to(() => SingleSchemeScreen(scheme: scheme));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: "https://api.agrisarathi.com/api/${scheme.schemeImage}",
                imageBuilder: (context, imageProvider) => Container(
                  height: 96,
                  width: 155,
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
                  height: 96,
                  width: 155,
                  child: Image.asset("assets/images/gov_scheme_placeholder.png"),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scheme.schemeName ?? "",
                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "NotoSans", fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text(scheme.ministryName ?? "", style: TextStyle(fontWeight: FontWeight.w400, fontFamily: "NotoSans", fontSize: 12),),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}