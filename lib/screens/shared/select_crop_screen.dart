import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpo_assist/controllers/shared/select_crop_controller.dart';
import 'package:fpo_assist/screens/farmer/auth/crop_variety_screen.dart';
import 'package:fpo_assist/screens/fpo/dashboard/fpo_home_screen.dart';
import 'package:get/get.dart';
import '../../utils/api_constants.dart';
import '../../utils/color_constants.dart';
import '../../widgets/custom_elevated_button.dart';
import '../farmer/auth/farmer_update_profile_screen.dart';

class SelectCropScreen extends StatelessWidget {

  CropController controller = Get.put(CropController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Select_Crop'.tr,
          style: TextStyle(fontSize:16, fontWeight: FontWeight.w700, fontFamily: 'GoogleSans'),
        ),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      body: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: EdgeInsets.all(16),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: TextFormField(
            //           textAlignVertical: TextAlignVertical.center,
            //           onChanged: (value) => controller.updateSearchQuery(value),
            //           decoration: InputDecoration(
            //             border: InputBorder.none,
            //             filled: true,
            //             fillColor: ColorConstants.textFieldBgClr,
            //             prefixIcon: const Icon(Icons.search),
            //             hintText: "Search_crop_name_here".tr,
            //             hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'GoogleSans')
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 16,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'You_can_select_upto_1_crops_you_are_interested_in'.tr,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'GoogleSans'),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Obx(() {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 65,
                child: ListView.separated(
                  itemCount: controller.selectedCrops.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final crop = controller.selectedCrops[index];
                    return Stack(
                      children: <Widget>[
                        Container(
                          height: 65,
                          width: 65,
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          decoration: BoxDecoration(
                            color: Color(0xffE9FDED),
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Image.network(
                            '${ApiEndPoints.imageBaseUrl}' +
                                crop.cropImages!,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              controller.removeSelectedCrop(crop);
                            },
                            child: CircleAvatar(
                              radius: 8,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 10,
                              ),
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 10,
                    );
                  },
                ),
              );
            }),
            SizedBox(
              height: 20,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(() => Wrap(
                spacing: 8.0,
                children: controller.categories.map((category) {
                  return FilterChip(
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    label: Text(
                      category.tr,  // Assuming categories are in localized strings
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.black,
                          fontFamily: 'GoogleSans'),
                    ),
                    selected: controller.selectedCategory.value == category,
                    selectedColor: Colors.green,
                    onSelected: (isSelected) => controller.filterCrops(isSelected ? category : ''),
                  );
                }).toList(),
              )),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
                child: controller.displayedCrops.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: controller.displayedCrops.length,
                          itemBuilder: (context, index) {
                            final crop = controller.displayedCrops[index];
                            return Column(
                              children: [
                                Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (crop.status != null && crop.status == true) {
                                          controller.addSelectedCrop(crop);
                                        }
                                      },
                                      child: Container(
                                        height: 75,
                                        width: 75,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 12),
                                        decoration: BoxDecoration(
                                          color: Color(0xffE9FDED),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: "${ApiEndPoints.imageBaseUrl}${crop.cropImages}",
                                          imageBuilder: (context, imageProvider) =>
                                              Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                                filterQuality: FilterQuality.low,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              const Center(
                                                child: CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xff002833d)
                                                        .withOpacity(0.06),
                                                    borderRadius:
                                                        BorderRadius.circular(3),
                                                  ),
                                                  child: const Icon(Icons.error)),
                                        ),
                                        // Image.network(
                                        //     "https://api.agrisarathi.com/api/media/${crop.cropImage}", fit: BoxFit.contain),
                                      ),
                                    ),
                                    Visibility(
                                      visible: crop.status != true,
                                      child: Container(
                                        height: 75,
                                        width: 75,
                                        color: Colors.white70.withOpacity(0.8),
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  crop.cropName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'GoogleSans'),
                                )
                              ],
                            );
                          },
                        ),
                      )),
          ],
        );
      }),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
          child: CustomElevatedButton(
            buttonColor: Colors.green,
            onPress: () {
              if(controller.selectedCrops.isNotEmpty) {
                Get.to(() =>
                    CropVarietyScreen(selectedCrops: controller.selectedCrops));
              } else{
                Fluttertoast.showToast(
                    msg: "Please select a crop",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            widget: Text(
              "Next".tr,
              style: TextStyle(
                  fontFamily: 'GoogleSans',
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
