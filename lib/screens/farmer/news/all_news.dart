import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/screens/farmer/news/single_news.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';

import '../../../controllers/farmer/news_controller.dart';
import '../../../utils/helper_functions.dart';

class NewsListView extends StatelessWidget {
  final NewsController controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "News".tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSourceFilter(),
            Expanded(
              child: Obx(() => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.filteredArticles.isNotEmpty
                  ? _buildNewsList(context)
                  : Center(
                  child: Text(
                    "No data available",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: "Bitter"),
                  ))),
            ),
            if (controller.isLoadingMore.value)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceFilter() {
    return Container(
      height: 106,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.sources.length,
        itemBuilder: (context, index) {
          final source = controller.sources[index];
          final String imageName = source['image']!;
          final String sourceName = source['name']!;
          final String sourceFilter = source['source']!;
          return GestureDetector(
            onTap: () {
              controller.filterBySource(sourceFilter);
            },
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 12.5, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: controller.sources[index] == index
                    ? Color(0xffEAFAEB)
                    : Colors.white,
              ),
              child: Column(
                children: [
                  Image.asset(
                    imageName,
                    height: 45,
                    width: 45,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    sourceName,
                    style: TextStyle(
                        fontFamily: "NotoSans",
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewsList(BuildContext context) {
    return Obx(() => NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
            !controller.isLoadingMore.value &&
            controller.hasMore) {
          controller.fetchNews(loadMore: true);
        }
        return false;
      },
      child: ListView.separated(
        itemCount: controller.filteredArticles.length,
        separatorBuilder: (context, index) => SizedBox(height: 20),
        itemBuilder: (context, index) {
          var article = controller.filteredArticles[index];
          return InkWell(
            onTap: () {
              Get.to(() => SingleNewsScreen(article: article));
            },
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: "${ApiEndPoints.imageBaseUrl}${article.image ?? ""}",
                  imageBuilder: (context, imageProvider) => Container(
                    height: 96,
                    width: 155,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => SizedBox(
                      height: 10,
                      width: 10,
                      child: const CircularProgressIndicator(
                        strokeAlign: 2,
                        strokeWidth: 2,
                      )),
                  errorWidget: (context, url, error) => SizedBox(
                    height: 96,
                    width: 155,
                    child:
                    Image.asset("assets/images/news_placeholder.png"),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "NotoSans",
                            fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${HelperFunctions().formatDate(article.publishDate)}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: "NotoSans",
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ));
  }
}

