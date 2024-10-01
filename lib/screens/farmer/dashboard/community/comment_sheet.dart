import 'package:fpo_assist/utils/helper_functions.dart';

import '../../../../controllers/shared/community/comments_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../models/community_post_model.dart';
import '../../../../utils/api_constants.dart';

class CommentBottomSheet extends StatelessWidget {
  final CommunityPost post;
  final CommentController controller = Get.put(CommentController());
  final TextEditingController textController = TextEditingController();

  CommentBottomSheet({required this.post});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller with the post's comments
    controller.initializeComments(post.comments);

    return Container(
      height: Get.height * 0.85,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            elevation: 4.0, // Elevation effect
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.0),
                  topRight: Radius.circular(14.0),
                ),
              ),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 50,
              child: const Text(
                "Comments",
                style: TextStyle(
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.comments.length,
                itemBuilder: (context, index) {
                  final comment = controller.comments[index];
                  return CommentTile(comment: comment);
                },
              );
            }),
          ),
          Obx(() {
            if (controller.replyingTo.value != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Replying to ${controller.replyingTo.value!.userName}'),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (controller.replyingTo.value == null) {
                      controller.postComment(post.postId, textController.text);
                    } else {
                      controller.postReply(
                        controller.replyingTo.value!.id,
                        textController.text,
                      );
                    }
                    textController.clear();
                    controller.setReplyingTo(null);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommentTile extends StatelessWidget {
  final Comment comment;

  CommentTile({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage:
                NetworkImage(ApiEndPoints.baseUrl + comment.profilePic),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color(0xffF4F4F4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            comment.userName,
                            style: const TextStyle(
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            HelperFunctions().formatDate(comment.createdDate),
                            style: const TextStyle(
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Text(comment.postComment,
                          style: const TextStyle(
                            fontFamily: "GoogleSans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xff262626),
                          ),),
                    ],
                  ),
                ),
                TextButton(
                  child: const Text('Reply',
                    style: const TextStyle(
                      fontFamily: "GoogleSans",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    Get.find<CommentController>().setReplyingTo(comment);
                  },
                ),
                ...comment.replyComments
                    .map((reply) => ReplyTile(reply: reply)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReplyTile extends StatelessWidget {
  final Reply reply;

  ReplyTile({required this.reply});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          backgroundImage:
              NetworkImage(ApiEndPoints.baseUrl + reply.profilePic)),
      title: Text(reply.userName),
      subtitle: Text(reply.text),
    );
  }
}
