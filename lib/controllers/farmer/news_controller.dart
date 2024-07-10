import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/news_model.dart';

class NewsController extends GetxController {
  var articles = <NewsArticle>[].obs;
  var sources = <String>[].obs;
  var selectedSource = 'all'.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  Future<void> fetchNews() async {
    isLoading(true);
    try {
      var response = await http.post(
        Uri.parse('http://64.227.166.238:8090/GetCurrentNews'),
        body: jsonEncode({
          "user_language": 1,
          "filter_type": "all"
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var articlesJson = jsonResponse['articles'] as List;
        articles.value = articlesJson.map((articleJson) => NewsArticle.fromJson(articleJson)).toList();

        // Extract unique sources
        sources.value = ['all', ...{...articles.map((article) => article.source)}];
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
      fetchNews();
    } else {
      articles.value = articles.where((article) => article.source == source).toList();
    }
  }
}