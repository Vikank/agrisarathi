import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/get_community_post_model.dart';


class CommunityController extends GetxController{

  GetCommunityPostModel getCommunityPostModel = GetCommunityPostModel();

  Future<void> getCommunityPost() async {
    var response = await http
        .post(Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.getCommunityPost+"?filter_type=farmer"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      getCommunityPostModel = GetCommunityPostModel.fromJson(data);
      print('community post values: $getCommunityPostModel');
    } else {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }



  List<CommentList> getCommentsForPost(int postId) {
    List<CommentList> comments = [];
    int? postIdInt = postId;
    if (postIdInt != null) {
      getCommunityPostModel.data?.forEach((post) {
        if (post.id == postIdInt) {
          comments.addAll(post.commentList!.cast<CommentList>());
        }
      });
    } else {
      print('Failed to parse postId as an integer');
    }
    return comments;
  }





  String formatPostDate(String createdDate) {
    try {
      DateTime postDateTime = DateTime.parse(createdDate);
      DateTime now = DateTime.now();
      Duration difference = now.difference(postDateTime);
      if (difference.inDays == 0) {
        return 'Today';
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else {
        return '${postDateTime.day}-${postDateTime.month}-${postDateTime.year}';
      }
    } catch (e) {
      print("Error parsing date: $e");
      return "Invalid Date";
    }
  }



}