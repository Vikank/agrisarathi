import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/community_controller.dart';
import '../../../../models/community_post_model.dart';

class CommentsSheet extends StatelessWidget {
  final CommunityPost post;
  final CommunityForumController controller = Get.find();
  final TextEditingController commentController = TextEditingController();

  CommentsSheet({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: post.commentList!.length,
              itemBuilder: (context, index) {
                final comment = post.commentList![index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('https://www.agrisarathi.com${comment.profilePic}'),
                      ),
                      title: Text(comment.userName ?? ""),
                      subtitle: Text(comment.postComment ?? ""),
                    ),
                    ...comment.replyComments!.map((reply) => Padding(
                      padding: EdgeInsets.only(left: 32),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage('https://www.agrisarathi.com${reply.profilePic}'),
                        ),
                        title: Text(reply.userName ?? ""),
                        subtitle: Text(reply.text ?? ""),
                      ),
                    )).toList(),
                    Padding(
                      padding: EdgeInsets.only(left: 32),
                      child: TextButton(
                        child: Text('Reply'),
                        onPressed: () {
                          // Show reply dialog
                          _showReplyDialog(context, comment.id!);
                        },
                      ),
                    ),
                  ],
                );
              },
            )),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(hintText: 'Add a comment...'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (commentController.text.isNotEmpty) {
                    controller.addComment(post.postId!, commentController.text);
                    commentController.clear();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showReplyDialog(BuildContext context, int commentId) {
    final replyController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: Text('Reply to comment'),
        content: TextField(
          controller: replyController,
          decoration: InputDecoration(hintText: 'Enter your reply'),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Reply'),
            onPressed: () {
              if (replyController.text.isNotEmpty) {
                controller.replyToComment(commentId, replyController.text);
                Get.back();
              }
            },
          ),
        ],
      ),
    );
  }
}