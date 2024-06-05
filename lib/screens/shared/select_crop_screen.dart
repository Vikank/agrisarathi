import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fpo_assist/controllers/select_crop_controller.dart';
import 'package:fpo_assist/screens/shared/auth/update_profile_screen.dart';
import 'package:get/get.dart';
import '../../utils/api_constants.dart';
import '../../utils/color_constants.dart';
import '../../widgets/custom_elevated_button.dart';

class SelectCropScreen extends StatelessWidget {
  CropController controller = Get.put(CropController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Select Crop',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      body: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) => controller.updateSearchQuery(value),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: ColorConstants.textFieldBgClr,
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search crop name here",
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // _showBottomSheet(context);
                    },
                    icon: Icon(
                      Icons.filter_list,
                      size: 31,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'You can select upto 5 crops you are interested in',
                style: Theme.of(context).textTheme.displaySmall,
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
                            'http://64.227.166.238:8090/media/' +
                                crop.cropImage,
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
              child: Wrap(
                spacing: 8.0,
                children: [
                  FilterChip(
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    label: Text(
                      'Cereals',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.black),
                    ),
                    selected:
                        controller.selectedCategory.value == 'CerealField',
                    selectedColor: Colors.green,
                    onSelected: (isSelected) =>
                        controller.filterCrops(isSelected ? 'CerealField' : ''),
                  ),
                  FilterChip(
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    label: Text(
                      'Pulse',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.black),
                    ),
                    selected: controller.selectedCategory.value == 'Pulse',
                    selectedColor: Colors.green,
                    onSelected: (isSelected) =>
                        controller.filterCrops(isSelected ? 'Pulse' : ''),
                  ),
                  FilterChip(
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    label: Text(
                      'Fruit',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.black),
                    ),
                    selected: controller.selectedCategory.value == 'Fruit',
                    selectedColor: Colors.green,
                    onSelected: (isSelected) =>
                        controller.filterCrops(isSelected ? 'Fruit' : ''),
                  ),
                  FilterChip(
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    label: Text(
                      'Vegetable',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.black),
                    ),
                    selected: controller.selectedCategory.value == 'Vegetable',
                    selectedColor: Colors.green,
                    onSelected: (isSelected) =>
                        controller.filterCrops(isSelected ? 'Vegetable' : ''),
                  ),
                ],
              ),
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
                                      imageUrl:
                                          "${ApiEndPoints.imageBaseUrl}${crop.cropImage}",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          // color: const Color(0xff002833d)
                                          //     .withOpacity(0.06),
                                          // borderRadius:
                                          //     BorderRadius.circular(3),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            filterQuality: FilterQuality.low,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
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
                                    //     "http://64.227.166.238:8090/media/${crop.cropImage}", fit: BoxFit.contain),
                                  ),
                                ),
                                Text(
                                  crop.cropName,
                                  overflow: TextOverflow.ellipsis,
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
              Get.to(UpdateProfileScreen(controller.selectedCrops));
            },
            widget: Text(
              "NEXT",
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
