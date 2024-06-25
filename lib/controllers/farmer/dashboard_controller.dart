import 'dart:convert';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../models/all_news.dart';


class FarmerDashboardController extends GetxController{
  var news = AllNews(status: "", articles: []).obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }


  void fetchNews() async {
    final url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.getAllNews}');
    final body = jsonEncode({
      "user_language": 1,
      "filter_type": "all"
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        news.value = AllNews.fromJson(jsonData);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }

}