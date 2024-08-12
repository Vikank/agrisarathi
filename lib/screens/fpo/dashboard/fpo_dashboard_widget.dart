
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:fpo_assist/controllers/fpo/fpo_home_controller.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_home_card.dart';

class DashboardWidget extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());
  final List<String> imgList = [
    'assets/images/carousel_home.png',
    'assets/images/carousel_home.png',
  ];
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffEEEEEE),
                      Color(0xffFFFFFF),
                      Color(0xffFFFFFF),
                    ],
                  )
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 103,
                    width: double.infinity,
                    child: CarouselSlider(
                      items: imgList
                          .map((item) => Image.asset(item,
                              fit: BoxFit.cover, width: double.infinity))
                          .toList(),
                      carouselController: _controller,
                      options: CarouselOptions(
                          viewportFraction: 1,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            homeController.currentCarousel.value = index;
                          }),
                    ),
                  ),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imgList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            margin:
                            EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                homeController.currentCarousel.value == entry.key
                                    ? Colors.green
                                    : Colors.grey[100]),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              color: Color.fromRGBO(254, 255, 254, 0.5),
              padding: EdgeInsets.only(top: 16),
              // color: Colors.black,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomHomeCard(
                            cardName: 'Inventory',
                            image: 'assets/images/inventory.png',
                            context: context),
                        CustomHomeCard(
                            cardName: 'Farmer’s Analytics',
                            image: 'assets/images/farmerAnalytics.png',
                            context: context)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomHomeCard(
                            cardName: 'Shop',
                            image: 'assets/images/shop.png',
                            context: context),
                        CustomHomeCard(
                            cardName: 'Sale',
                            image: 'assets/images/sale.png',
                            context: context)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomHomeCard(
                            cardName: 'Business Plan',
                            image: 'assets/images/businessPlan.png',
                            context: context),
                        CustomHomeCard(
                            cardName: 'Govt. Schemes',
                            image: 'assets/images/govScheme.png',
                            context: context)
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
            SizedBox(height: 16,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.grey, //edited
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Helpline Numbers", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Roboto'),),
                        Text("All the Govt. helpline numbers", style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.w500),),
                      ],
                    ),
                    Image.asset("assets/images/helpline.png", width: 30, height: 30,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
