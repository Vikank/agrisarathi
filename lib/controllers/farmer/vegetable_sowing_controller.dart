import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VegetableSowingController extends GetxController {
  var selectedDate = ''.obs;

  // Method to pick a date and update the controller's state
  Future<void> pickDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
    );

    if (pickedDate != null) {
      selectedDate.value = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }
}
