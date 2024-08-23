import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/farmer/farmer_address_controller.dart';
import 'package:get/get.dart';

import '../../../models/select_crop_model.dart';

class CropVarietyScreen extends StatelessWidget {
  RxList<Crop> selectedCrops;
  CropVarietyScreen({super.key, required this.selectedCrops});


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
