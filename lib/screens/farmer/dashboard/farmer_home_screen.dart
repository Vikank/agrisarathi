import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/fpo/fpo_home_controller.dart';
import 'farmer_community_widget.dart';
import 'farmer_dashboard_widget.dart';
import 'farmer_mandi_widget.dart';
import 'my_farms_widget.dart';


class FarmerHomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  static List<Widget> _widgetOptions = <Widget>[
    FarmerDashboardWidget(),
    MyFarmsWidget(),
    FarmerCommunityWidget(),
    FarmerMandiWidget(),
  ];

  static List<Widget> _textOptions = <Widget>[
    Text("Agri Sarthi"),
    Text("Community"),
    Text("Mandi"),
    Text("Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Obx(() {
          return _textOptions.elementAt(controller.selectedIndex.value);
        }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset("assets/icons/announcements.png", height: 24, width: 24,),
          )
        ],
      ),
      body: Obx(() {
        return _widgetOptions.elementAt(controller.selectedIndex.value);
      }),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                controller.updateSelectedIndex(0);
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Community'),
              onTap: () {
                controller.updateSelectedIndex(1);
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.store),
              title: Text('Mandi'),
              onTap: () {
                controller.updateSelectedIndex(2);
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                controller.updateSelectedIndex(3);
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(controller.selectedIndex.value == 0
                  ? "assets/icons/home_sel.png"
                  : "assets/icons/home_unsel.png", width: 24, height: 24,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(controller.selectedIndex.value == 1
                  ? "assets/icons/community_sel.png"
                  : "assets/icons/community_unsel.png", width: 24, height: 24,),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(controller.selectedIndex.value == 2
                  ? "assets/icons/shop_sel.png"
                  : "assets/icons/shop_unsel.png", width: 24, height: 24,),
              label: 'Mandi',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(controller.selectedIndex.value == 3
                  ? "assets/icons/profile_sel.png"
                  : "assets/icons/profile_unsel.png", width: 24, height: 24,),
              label: 'Profile',
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(color: Colors.green,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto'),
          unselectedLabelStyle: TextStyle(color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto'),
          onTap: controller.updateSelectedIndex,
        );
      }),
    );
  }
}