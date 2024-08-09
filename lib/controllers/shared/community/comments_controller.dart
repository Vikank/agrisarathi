import 'dart:convert';

import '../../../models/community_post_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class CommentController extends GetxController {
  var comments = <Comment>[].obs;
  var replyingTo = Rxn<Comment>();

  void initializeComments(List<Comment> postComments) {
    comments.assignAll(postComments);
  }

  Future<void> postComment(int postId, String commentText) async {
    try {
      var url = Uri.parse('https://api.agrisarathi.com/api/Comment_On_Post');
      var response = await http.post(
        url,
        body: json.encode({
          "user_id": 1, // Replace with actual user ID
          "post_id": postId,
          "comment_text": commentText,
          "user_type": "farmer"
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        if (decodedResponse['status'] == 'success') {
          // Add the new comment to the list
          comments.add(Comment.fromJson(decodedResponse['data']));
        }
      }
    } catch (e) {
      print('Error posting comment: $e');
    }
  }

  Future<void> postReply(int commentId, String replyText) async {
    try {
      var url = Uri.parse('https://api.agrisarathi.com/api/Reply_ON_Post_Comment');
      var response = await http.post(
        url,
        body: json.encode({
          "fk_postcoment_id": commentId,
          "user_id": 1, // Replace with actual user ID
          "text": replyText,
          "user_type": "farmer"
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        if (decodedResponse['status'] == 'success') {
          // Add the new reply to the appropriate comment
          var updatedComment = comments.firstWhere((comment) => comment.id == commentId);
          updatedComment.replyComments.add(Reply.fromJson(decodedResponse['data']));
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