import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/fertilizer_calci_response.dart';


class FertilizerCalciController extends GetxController{

  final nitrogenValue = TextEditingController();
  final phosphorousValue = TextEditingController();
  final potassiumValue = TextEditingController();

  Future<FertilizerResponse> fetchFertilizerData() async {
    final url = Uri.parse('https://api.agrisarathi.com/api/Fertilizerswithtest');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "user_id": 1,
        "crop_id": 4,
        "user_language": 1,
        "farm_id": 1,
        "nitrogen": int.parse(nitrogenValue.text),
        "phosphorous": int.parse(phosphorousValue.text),
        "potassium": int.parse(potassiumValue.text)
      }),
    );

    if (response.statusCode == 200) {
      return FertilizerResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load fertilizer data');
    }
  }
}