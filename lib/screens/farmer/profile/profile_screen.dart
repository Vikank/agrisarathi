import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/models/profile_model.dart';
import 'package:fpo_assist/utils/color_constants.dart';
import 'package:fpo_assist/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';

import '../../../controllers/farmer/profile_controller.dart';
import '../../../utils/api_constants.dart';

class ProfileScreen extends StatelessWidget {
  final FarmerProfileController profileController =
      Get.put(FarmerProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Profile".tr,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: "GoogleSans"),
          ),
        ),
        body: Obx(() {
          if (profileController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          final profile = profileController.farmerProfile.value;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Column(
              children: [
                _buildProfileHeader(profile),
                SizedBox(
                  height: 16,
                ),
                _buildLanguageSelection(profile),
                _buildSettingsOptions(profile),
              ],
            ),
          );
        }));
  }

  Widget _buildProfileHeader(FarmerProfile profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            ClipOval(
              child: profile.profile != null && profile.profile!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl:
                          '${ApiEndPoints.imageBaseUrl}${profile.profile}',
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/icons/user_icon.png', // Path to your asset image
                        fit: BoxFit.cover,
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 100.0, // Customize size as per your design
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : Image.asset(
                      'assets/icons/user_icon.png', // Path to your asset image
                      width: 100.0, // Customize size as per your design
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
            ),
            GestureDetector(
              onTap: profileController.pickImage,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.photo_camera_rounded,
                    color: Colors.white, size: 16),
              ),
            ),
          ],
        ),
        SizedBox(width: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  profile.name ?? "User",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: "GoogleSans"),
                ),
                Text(
                  profile.mobile ?? "1234567890",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: "GoogleSans"),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.edit_outlined, size: 23),
              onPressed: () {
                Get.dialog(
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.8), // Adds transparent barrier color
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20), // Padding around the content inside the dialog
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Material(
                              color: Colors.white,
                              child: SingleChildScrollView(child: _buildDialogContent()))),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDialogContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Make the column only as tall as its content
        children: [
          Text(
            "Please_enter_your_name".tr,
            style: TextStyle(
              fontSize: 18, // You can customize text style
              fontWeight: FontWeight.bold,
              fontFamily: "GoogleSans",
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: profileController.nameController,
            decoration: InputDecoration(
              hintText: 'Your_Name'.tr,
              hintStyle: TextStyle(
                fontSize: 14, // You can customize text style
                fontWeight: FontWeight.w400,
                fontFamily: "GoogleSans",
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
          ),
          SizedBox(height: 20),
          CustomElevatedButton(
            buttonColor: ColorConstants.primaryColor,
            onPress: (() {
              profileController.updateName();
            }),
            widget: Text("Submit".tr, style: TextStyle(
              fontSize: 15, // You can customize text style
              fontWeight: FontWeight.w500,
              fontFamily: "GoogleSans",
            ),),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelection(FarmerProfile profile) {
    final ScrollController scrollController = ScrollController();

    // Function to scroll forward when the arrow is pressed
    void _scrollForward() {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
    Widget languageButton(String language, String nativeText, int id, String param1, String param2) {
      bool isSelected = id == profile.fkLanguage;
      return Container(
        width: 92,
        height: 64,
        child: OutlinedButton(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Text(
                  language,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: "GoogleSans",
                      color: Colors.black),
                ),
                Text(
                  nativeText,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: "GoogleSans",
                      color: Colors.black),
                ),
              ],
            ),
          ),
          onPressed: () {
            profileController.updateLanguage(id, param1, param2);
          },
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            side: BorderSide(width: isSelected ? 2.0 : 1.0, color: isSelected ? Colors.green : Colors.grey,),
          ),
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  languageButton('English', 'अंग्रेजी', 1, 'en', 'US'),
                  SizedBox(width: 8),
                  languageButton('Hindi', 'हिंदी', 2, 'hi', 'IN'),
                  SizedBox(width: 8),
                  languageButton('Marathi', 'मराठी', 3, 'hi', 'IN'),
                  SizedBox(width: 8),
                  languageButton('Marathi', 'मराठी', 4, 'hi', 'IN'),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, size: 16),
            onPressed: _scrollForward,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsOptions(FarmerProfile profile) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.notifications_none),
          title: Text(
            "Notification",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: "GoogleSans"),
          ),
          trailing: Theme(
            data: ThemeData(useMaterial3: false),
            child: Switch(
                activeColor: Colors.green,
                value: profile.isActive ?? false,
                onChanged: (bool value) {}),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.sms_outlined),
          title: Text(
            "Turn off SMS",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: "GoogleSans"),
          ),
          trailing: Theme(
            data: ThemeData(useMaterial3: false),
            child: Switch(
                activeColor: Colors.green,
                value: profile.smsStatus ?? false,
                onChanged: (bool value) {}),
          ),
          onTap: () {},
        ),
        _settingsItem('Privacy Policy', Icons.lock_outline),
        _settingsItem('Terms and Conditions', Icons.description_outlined),
        _settingsItem('Help', Icons.help_outline),
        _settingsItem('Log out', Icons.logout, onTap: () {
          profileController.logout();
        },),
      ],
    );
  }

  Widget _settingsItem(String title, IconData icon, {bool isSwitch = false, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "GoogleSans"),
      ),
      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16),
      onTap: onTap,
    );
  }
}
