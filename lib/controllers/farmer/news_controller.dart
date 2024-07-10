import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/news_model.dart';
import '../../utils/helper_functions.dart';

class NewsController extends GetxController {
  var allArticles = <NewsArticle>[].obs;
  var filteredArticles = <NewsArticle>[].obs;
  var isLoading = true.obs;
  var selectedSource = 'All'.obs;
  int? userLanguage;

  final List<Map<String, String>> sources = [
    {"name": "All", "image": "assets/images/allnews.png", "source": "all"},
    {
      "name": "ABP Live",
      "image": "assets/images/abplive.png",
      "source": "ABPLIVE"
    },
    {
      "name": "Krishak Jagat",
      "image": "assets/images/krishakjagat.png",
      "source": "KRISHAKJAGAT"
    },
    {
      "name": "Kisan Samadhaan",
      "image": "assets/images/kisansamadhaan.png",
      "source": "KISANSAMADHAAN"
    },
    {
      "name": "Krishi Jagran",
      "image": "assets/images/krishijagran.png",
      "source": "KRISHIJAGRAN"
    },
    {
      "name": "Kisan Tak",
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

  Future<void> fetchNews() async {
    isLoading(true);
    try {
      log("api call me aaya ${userLanguage}");
      var response = await http.post(
        Uri.parse('http://64.227.166.238:8090/GetCurrentNews'),
        body: jsonEncode({"user_language": userLanguage, "filter_type": "all"}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var articlesJson = jsonResponse['articles'] as List;
        allArticles.value = articlesJson
            .map((articleJson) => NewsArticle.fromJson(articleJson))
            .toList();
        filteredArticles.value = allArticles;
        log("api call me aaya ${allArticles.value}");
      }
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      isLoading(false);
    }
  }

  void filterBySource(String source) {
    selectedSource.value = source;
    if (source == 'all') {
      filteredArticles.value = allArticles;
    } else {
      filteredArticles.value = allArticles
          .where(
              (article) => article.source.toLowerCase() == source.toLowerCase())
          .toList();
    }
  }
}
