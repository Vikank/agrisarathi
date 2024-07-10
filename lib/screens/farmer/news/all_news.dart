import 'package:flutter/material.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';

import '../../../controllers/farmer/news_controller.dart';

class NewsListView extends StatelessWidget {
  final NewsController controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News')),
      body: Column(
        children: [
          Obx(() => controller.isLoading.value
              ? CircularProgressIndicator()
              : _buildSourceFilter()),
          Expanded(
            child: Obx(() => controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : _buildNewsList()),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceFilter() {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.sources.length,
        itemBuilder: (context, index) {
          return Obx(() => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ChoiceChip(
              label: Text(controller.sources[index]),
              selected: controller.selectedSource.value == controller.sources[index],
              onSelected: (selected) {
                if (selected) {
                  controller.filterBySource(controller.sources[index]);
                }
              },
            ),
          ));
        },
      ),
    );
  }

  Widget _buildNewsList() {
    return ListView.separated(
      itemCount: controller.articles.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        var article = controller.articles[index];
        return Row(
          children: [
            Image.network(
              "${ApiEndPoints.baseUrl}${article.image}" ?? "",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(article.publishDate),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}