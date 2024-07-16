import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/community_controller.dart';
import '../../../../models/community_post_model.dart';
import '../../../../utils/api_constants.dart';
import 'comment_sheet.dart';

class PostCard extends StatelessWidget {
  final CommunityPost post;
  final CommunityForumController controller = Get.find();

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    controller.likeCount.value = post.likeCount!;
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('${ApiEndPoints.baseUrl}${post.profilePic}'),
            ),
            title: Text(post.userName ?? ""),
            subtitle: Text(post.cropName ?? ""),
          ),
          Image.network('${ApiEndPoints.baseUrl}${post.postImage}'),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(post.description ?? ""),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.thumb_up),
                onPressed: () => controller.likePost(post.postId!),
              ),
              Obx(() => Text('${controller.likeCount} Likes')),
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {
                  // Get.bottomSheet(
                  //   CommentsSheet(post: post),
                  //   isScrollControlled: true,
                  // );
                },
              ),
              Text('${post.commentList!.length} Comments'),
            ],
          ),
        ],
      ),
    );
  }
}