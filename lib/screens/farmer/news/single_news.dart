import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/utils/helper_functions.dart';
import 'package:get/get.dart';

import '../../../models/news_model.dart';
import '../../../utils/api_constants.dart';

class SingleNewsScreen extends StatelessWidget {
  final NewsArticle article;

  SingleNewsScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "News_Details".tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title ?? "",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Bitter"
                ),
              ),
              SizedBox(height: 8),
              // Text(
              //   'Source: ${article.source}',
              //   style: TextStyle(
              //     fontStyle: FontStyle.italic,
              //     color: Colors.grey[600],
              //   ),
              // ),
              Text(
                '${HelperFunctions().formatDate(article.publishDate)}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 4),
              CachedNetworkImage(
                imageUrl: "${ApiEndPoints.imageBaseUrl}${article.image ?? ""}",
                imageBuilder: (context, imageProvider) => Container(
                  height: 190,
                  width: double.infinity,
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
                  height: 190,
                  width: double.infinity,
                  child: Image.asset("assets/images/news_placeholder.png"),
                ),
              ),
              SizedBox(height: 16),
              Text(
                article.content ?? "",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}