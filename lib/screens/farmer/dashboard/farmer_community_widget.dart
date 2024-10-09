import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/shared/community/comments_controller.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:fpo_assist/utils/color_constants.dart';
import 'package:fpo_assist/utils/helper_functions.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../controllers/shared/community/community_controller.dart';
import '../../../models/community_post_model.dart';
import 'community/add_new_post.dart';
import 'community/comment_sheet.dart';

class CommunityForumScreen extends StatelessWidget {
  final CommunityController controller = Get.put(CommunityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.separated(
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {

              // final post = controller.posts[index];
              return CommunityPostCard(index:index, controller: controller);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 30);
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.primaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Get.to(AddPostScreen());
        },
      ),
    );
  }
}

class CommunityPostCard extends StatelessWidget {
  // final CommunityPost post;
  int index;
  final CommunityController controller;

  CommunityPostCard({required this.index, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Use the controller to manage isLiked state
    final isLiked = controller.posts[index].isLikedByUser.obs;
    var likeCount = controller.posts[index].likeCount.obs;
    // var post = controller.posts[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage:
              NetworkImage(ApiEndPoints.imageBaseUrl + controller.posts[index].profilePic! ?? ""),
            ),
            title: Text(
              controller.posts[index].userName!,
              style: const TextStyle(
                fontFamily: "GoogleSans",
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
            subtitle: Text(
              HelperFunctions().formatDate(controller.posts[index].createdDate),
              style: const TextStyle(
                fontFamily: "GoogleSans",
                fontWeight: FontWeight.w400,
                fontSize: 10,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              controller.posts[index].description ?? "",
              style: const TextStyle(
                fontFamily: "GoogleSans",
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
          if (controller.posts[index].postImage.isNotEmpty)
            Image.network(
              ApiEndPoints.imageBaseUrl + controller.posts[index].postImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          if (controller.posts[index].postVideo.isNotEmpty)
            FutureBuilder<void>(
              future: controller.initializeVideoPlayer(
                  ApiEndPoints.imageBaseUrl + controller.posts[index].postVideo),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // Check if chewieController is not null
                  if (controller.chewieController.value != null) {
                    return controller.posts[index].postVideo.isNotEmpty
                        ? SizedBox(
                      height: 180,
                      child: Chewie(
                        controller: controller.chewieController.value!,
                      ),
                    )
                        : Container();
                  } else {
                    return const Center(child: Text('Failed to load video'));
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                ()=> Text(
                  "${likeCount.value} Likes",
                  style: const TextStyle(
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Color(0xff262626),
                  ),
                ),
              ),
              Text(
                  "${controller.posts[index].commentCount} Comments",
                  style: const TextStyle(
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Color(0xff262626),
                  ),
                )
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() =>
                  TextButton.icon(
                    icon: Image.asset(
                      isLiked.value
                          ? "assets/icons/liked.png"
                          : "assets/icons/like.png",
                      width: 24,
                      height: 24,
                    ),
                    label: Text(
                      isLiked.value ? "Unlike" : "Like",
                      style: const TextStyle(
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                    // onPressed: () async {
                    //   final success = await controller.likePost(
                    //     postId: post.postId,
                    //     action: isLiked.value ? "unlike" : "like",
                    //   );
                    //   if (success) {
                    //     isLiked.value = !isLiked.value;
                    //   }
                    // },
                    onPressed: () async {
                      await controller.likePost(
                        postId: controller.posts[index].postId,
                        action: isLiked.value ? "unlike" : "like",
                      );
                      likeCount.value = isLiked.value ? likeCount.value! - 1 : likeCount.value! + 1;
                      isLiked.value = !isLiked.value;
                    },
                  )),
              TextButton.icon(
                icon: Image.asset(
                  "assets/icons/comment.png",
                  width: 24,
                  height: 24,
                ),
                label: const Text(
                  'Comment',
                  style: TextStyle(
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Get.bottomSheet(
                    ignoreSafeArea: true,
                    CommentBottomSheet(post: controller.posts[index]),
                    isScrollControlled: true,
                  );
                  //     .whenComplete(() {
                  //   Get.delete<CommentController>();
                  // });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
