import 'package:flutter/material.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../models/community_post_model.dart';

class CommunityForumController extends GetxController {
  var posts = <CommunityPost>[].obs;
  var isLoading = true.obs;
  RxInt likeCount = 0.obs;

  // Assuming these values are set when the user logs in
  late int currentUserId;
  late String currentUserType;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      fetchPosts();
    });
  }

  Future<void> fetchPosts() async {
    isLoading(true);
    try {
      final response = await http.post(Uri.parse('${ApiEndPoints.baseUrl}Get_Community_Posts_List?filter_type=farmer?'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        posts.value = (jsonData['data'] as List)
            .map((post) => CommunityPost.fromJson(post))
            .toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<bool> likePost(int postId) async {
    var url = Uri.parse('${ApiEndPoints.baseUrl}Like_Post_By_User');
    var request = http.MultipartRequest('POST', url)
      ..fields['user_id'] = currentUserId.toString()
      ..fields['post_id'] = postId.toString()
      ..fields['user_type'] = currentUserType;

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // Update local state
        var post = posts.firstWhere((p) => p.postId == postId);
        post.likeCount = post.likeCount! + 1;
        likeCount.value = post.likeCount!;
        posts.refresh();
        return true;
      } else {
        print('Failed to like post. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error liking post: $e');
      return false;
    }
  }

  Future<bool> addComment(int postId, String commentText) async {
    var url = Uri.parse('${ApiEndPoints.baseUrl}Comment_On_Post');
    var request = http.MultipartRequest('POST', url)
      ..fields['user_id'] = currentUserId.toString()
      ..fields['post_id'] = postId.toString()
      ..fields['comment_text'] = commentText
      ..fields['user_type'] = currentUserType;

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // Update local state
        // Ideally, the API should return the new comment object
        // For now, we'll create a dummy comment
        var post = posts.firstWhere((p) => p.postId == postId);
        post.commentList!.add(CommentList(
          userName: 'Current User', // Replace with actual user name
          userId: currentUserId,
          profilePic: '', // Replace with actual profile pic
          id: DateTime.now().millisecondsSinceEpoch,
          postComment: commentText,
          createdDt: DateTime.now().toIso8601String(),
          replyComments: [],
        ));
        posts.refresh();
        return true;
      } else {
        print('Failed to add comment. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error adding comment: $e');
      return false;
    }
  }

  Future<bool> replyToComment(int commentId, String replyText) async {
    var url = Uri.parse('${ApiEndPoints.baseUrl}Reply_ON_Post_Comment');
    var request = http.MultipartRequest('POST', url)
      ..fields['fk_postcoment_id'] = commentId.toString()
      ..fields['user_id'] = currentUserId.toString()
      ..fields['text'] = replyText
      ..fields['user_type'] = currentUserType;

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // Update local state
        // Find the post and comment, then add the reply
        for (var post in posts) {
          var comment = post.commentList!.firstWhereOrNull((c) => c.id == commentId);
          if (comment != null) {
            comment.replyComments!.add(ReplyComments(
              userName: 'Current User', // Replace with actual user name
              userId: currentUserId,
              profilePic: '', // Replace with actual profile pic
              id: DateTime.now().millisecondsSinceEpoch,
              text: replyText,
              createdDt: DateTime.now().toIso8601String(),
            ));
            posts.refresh();
            break;
          }
        }
        return true;
      } else {
        print('Failed to reply to comment. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error replying to comment: $e');
      return false;
    }
  }

  Future<bool> addNewPost(String description, File? imageFile, File? videoFile) async {
    var url = Uri.parse('${ApiEndPoints.baseUrl}Add_Community_Post');
    var request = http.MultipartRequest('POST', url)
      ..fields['description'] = description
      ..fields['user_id'] = currentUserId.toString()
      ..fields['user_type'] = currentUserType;

    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('image_file', imageFile.path));
    }
    if (videoFile != null) {
      request.files.add(await http.MultipartFile.fromPath('video_file', videoFile.path));
    }

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // Refresh the post list
        await fetchPosts();
        return true;
      } else {
        print('Failed to add post. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error adding post: $e');
      return false;
    }
  }
}