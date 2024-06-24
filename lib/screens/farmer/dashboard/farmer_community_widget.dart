import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/community_controller.dart';
import 'package:get/get.dart';

class FarmerCommunityWidget extends StatelessWidget {

  CommunityController controller = Get.put(CommunityController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Community Page'),
    );
  }
}