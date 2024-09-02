import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Profile".tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(
              height: 16,
            ),
            _buildLanguageSelection(),
            _buildSettingsOptions(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/profile_image.png'),
            ),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.photo_camera_rounded,
                  color: Colors.white, size: 16),
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
                  'Ramesh',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Bitter"),
                ),
                Text(
                  '8800228800',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: "NotoSans"),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.edit_outlined, size: 23),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLanguageSelection() {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _languageButton('English', 'अंग्रेजी'),
            SizedBox(width: 8),
            _languageButton('Hindi', 'हिंदी'),
            SizedBox(width: 8),
            _languageButton('Marathi', 'मराठी'),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios, size: 16),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _languageButton(String language, String nativeText) {
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
                    fontFamily: "NotoSans"),
              ),
              Text(nativeText, style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: "NotoSans"),),
            ],
          ),
        ),
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildSettingsOptions() {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.notifications_none),
          title: Text("Notification", style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: "NotoSans"),),
          trailing: Switch.adaptive(
              activeColor: Colors.green,
              value: true,
              onChanged: (bool value) {}),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.sms_outlined),
          title: Text("Turn off SMS", style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: "NotoSans"),),
          trailing: Switch.adaptive(
              activeColor: Colors.green,
              value: true,
              onChanged: (bool value) {}),
          onTap: () {},
        ),
        _settingsItem('Privacy Policy', Icons.lock_outline),
        _settingsItem('Terms and Conditions', Icons.description_outlined),
        _settingsItem('Help', Icons.help_outline),
        _settingsItem('Log out', Icons.logout),
      ],
    );
  }

  Widget _settingsItem(String title, IconData icon, {bool isSwitch = false}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: "NotoSans"),),
      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16),
      onTap: null,
    );
  }
}
