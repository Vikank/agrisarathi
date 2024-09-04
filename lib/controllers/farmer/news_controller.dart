import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/news_model.dart';
import '../../utils/helper_functions.dart';

class NewsController extends GetxController {
  final storage = FlutterSecureStorage();
  var allArticles = <NewsArticle>[].obs;
  var filteredArticles = <NewsArticle>[].obs;
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var selectedSource = 'All'.obs;
  int? userLanguage;
  int currentPage = 0;
  bool hasMore = true;

  final List<Map<String, String>> sources = [
    {"name": "All".tr, "image": "assets/images/allnews.png", "source": "all"},
    {
      "name": "ABP_Live".tr,
      "image": "assets/images/abplive.png",
      "source": "ABPLIVE"
    },
    {
      "name": "krishak_jagat".tr,
      "image": "assets/images/krishakjagat.png",
      "source": "KRISHAKJAGAT"
    },
    {
      "name": "KISAN_SAMADHAAN".tr,
      "image": "assets/images/kisansamadhaan.png",
      "source": "KISANSAMADHAAN"
    },
    {
      "name": "Krishi_Jagran".tr,
      "image": "assets/images/krishijagran.png",
      "source": "KRISHIJAGRAN"
    },
    {
      "name": "KISAN_TAK".tr,
      "image": "assets/images/kisantak.png",
      "source": "KISANTAK"
    }
  ];

  @override
  void onInit() {
    super.onInit();
    getUserLanguage().then((userlanguage) {
      fetchNews();
    });
  }

  Future<int?> getUserLanguage() async {
    userLanguage = await HelperFunctions.getUserLanguage();
    log("UserRole $userLanguage");
    return userLanguage;
  }

  Future<void> fetchNews({bool loadMore = false}) async {
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }
    if (isLoadingMore.value || (!hasMore && loadMore)) return;

    if (loadMore) {
      isLoadingMore(true);
      currentPage += 20; // Increase the offset for pagination
    } else {
      isLoading(true);
      currentPage = 0;
      hasMore = true;
    }

    try {
      final uri = Uri.parse(
          "${ApiEndPoints.baseUrlTest}GetCurrentNews?filter_type=all&limit=20&offset=${currentPage.toString()}");

      log("API call: ${uri.toString()}");

      var response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var articlesJson = jsonResponse['results'] as List;

        if (loadMore) {
          allArticles.addAll(articlesJson
              .map((articleJson) => NewsArticle.fromJson(articleJson))
              .toList());
        } else {
          allArticles.value = articlesJson
              .map((articleJson) => NewsArticle.fromJson(articleJson))
              .toList();
        }

        filteredArticles.value = allArticles;

        // Check if more data is available
        hasMore = jsonResponse['next'] != null;
      } else {
        log('Error fetching news: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      if (loadMore) {
        isLoadingMore(false);
      } else {
        isLoading(false);
      }
    }
  }

  void filterBySource(String source) {
    selectedSource.value = source;
    if (source == 'all') {
      filteredArticles.value = allArticles;
    } else {
      filteredArticles.value = allArticles
          .where((article) =>
              article.source!.toLowerCase() == source.toLowerCase())
          .toList();
    }
  }
}
