import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/utils/api_constants.dart';

import '../../../models/community_post_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'community_controller.dart';


class CommentController extends GetxController {
  final storage = FlutterSecureStorage();
  var comments = <Comment>[].obs;
  var replyingTo = Rxn<Comment>();

  void initializeComments(List<Comment> postComments) {
    comments.assignAll(postComments);
  }

  Future<void> postComment(int postId, String commentText) async {
    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
      };
      var url = Uri.parse('${ApiEndPoints.baseUrlTest}CommentOnPost');
      var response = await http.post(
        url,
        body: json.encode({// Replace with actual user ID
          "post_id": postId,
          "comment_text": commentText,
          "user_type": "farmer"
        }),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        if (decodedResponse['status'] == 'success') {
          // Add the new comment to the list
          var newComment = Comment.fromJson(decodedResponse['comment']);
          comments.add(newComment);
          Get.find<CommunityController>().updateCommentCount(postId, 1);
        }
      }
    } catch (e) {
      print('Error posting comment: $e');
    }
  }

  Future<void> postReply(int commentId, String replyText) async {
    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
      };
      var url = Uri.parse('${ApiEndPoints.baseUrlTest}ReplyOnPostComment');
      var response = await http.post(
        url,
        body: json.encode({
          "fk_postcomment_id": commentId,
          "text": replyText,
          "user_type": "farmer"
        }),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        if (decodedResponse['status'] == 'success') {
          // Add the new reply to the appropriate comment
          var updatedComment = comments.firstWhere((comment) => comment.id == commentId);
          updatedComment.replyComments.add(Reply.fromJson(decodedResponse['reply']));
          comments.refresh();
        }
      }
    } catch (e) {
      print('Error posting reply: $e');
    }
  }

  void setReplyingTo(Comment? comment) {
    replyingTo.value = comment;
  }
}