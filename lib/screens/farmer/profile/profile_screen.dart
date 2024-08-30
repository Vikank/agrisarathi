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
        padding: const EdgeInsets.symmetric(horizontal : 16.0, vertical: 16),
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(height: 16,),
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
              child: Icon(Icons.photo_camera_rounded, color: Colors.white, size: 16),
            ),
          ],
        ),
        SizedBox(width: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ramesh', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('8800228800'),
              ],
            ),
            IconButton(
              icon: Icon(Icons.edit_outlined, size: 20),
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
      child: ListView(
        scrollDirection: Axis.horizontal,
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
    );
  }

  Widget _languageButton(String language, String nativeText) {
    return SizedBox(
      width: 100,
      child: OutlinedButton(
        child: Column(
          children: [
            Text(language, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
            Text(nativeText, style: TextStyle(fontSize: 12)),
          ],
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
        _settingsItem('Notification', Icons.notifications_none, isSwitch: true),
        _settingsItem('Turn off SMS', Icons.sms_outlined, isSwitch: true),
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
      title: Text(title),
      trailing: isSwitch
          ? Switch(value: true, onChanged: (bool value) {})
          : Icon(Icons.arrow_forward_ios, size: 16),
      onTap: isSwitch ? null : () {},
    );
  }
}
