import 'package:cached_network_image/cached_network_image.dart';
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
    RxInt likeCount = post.likeCount!.obs;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage('${ApiEndPoints.baseUrl}${post.profilePic}'),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.userName ?? ""),
                  Text(post.cropName ?? ""),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(post.description ?? ""),
          SizedBox(
            height: 5,
          ),
          CachedNetworkImage(
            // imageUrl: '${ApiEndPoints.baseUrl}${post.postImage}',
            imageUrl: 'https://api.agrisarathi.com/api/${post.postImage}',
            imageBuilder: (context, imageProvider) => Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                ),
              ),
            ),
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
            errorWidget: (context, url, error) => Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xff002833d).withOpacity(0.06),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Icon(Icons.error)),
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Obx(() => Text('${likeCount} Likes')),
              Container(
                height: 4,
                width: 4,
                decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(100),),
              ),),
              post.commentList!.isNotEmpty
                  ? Text('${post.commentList!.length} Comments')
                  : Text('0 Comments'),
            ],
          ),
          Divider(),
          Row(
            children: [
              IconButton(
                icon: Image.asset("assets/icons/like.png", width: 24, height: 24,),
                onPressed: () async {
                  // bool isPostLiked = await controller.likePost(post.postId!);
                  bool isPostLiked = await Future.delayed(Duration(seconds: 2), () => true);
                  if (isPostLiked == true) {
                    // API Call Success(post liked)
                    likeCount.value++;
                    post.likeCount = post.likeCount ?? 0 + 1;
                  }
                },
              ),
              Text('Like'),
              SizedBox(width: 70,),
              IconButton(
                icon: Image.asset("assets/icons/comment.png", width: 24, height: 24,),
                onPressed: () {
                  // Get.bottomSheet(
                  //   CommentsSheet(post: post),
                  //   isScrollControlled: true,
                  // );
                },
              ),
              Text('Comment'),
            ],
          ),
        ],
      ),
    );
  }
}
