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
              final post = controller.posts[index];
              return CommunityPostCard(post: post, controller: controller);
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
  final CommunityPost post;
  final CommunityController controller;

  CommunityPostCard({required this.post, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Use the controller to manage isLiked state
    final isLiked = post.isLikedByUser.obs;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(ApiEndPoints.baseUrl + post.profilePic! ?? ""),
            ),
            title: Text(
              post.userName!,
              style: const TextStyle(
                fontFamily: "GoogleSans",
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
            subtitle: Text(
              HelperFunctions().formatDate(post.createdDate),
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
              post.description ?? "",
              style: const TextStyle(
                fontFamily: "GoogleSans",
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
          if (post.postImage.isNotEmpty)
            Image.network(
              ApiEndPoints.imageBaseUrl + post.postImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          if (post.postVideo.isNotEmpty)
            FutureBuilder<void>(
              future: controller.initializeVideoPlayer(
                  ApiEndPoints.imageBaseUrl + post.postVideo),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // Check if chewieController is not null
                  if (controller.chewieController.value != null) {
                    return VisibilityDetector(
                      key: Key(post.postId.toString()),
                      onVisibilityChanged: (visibilityInfo) {
                        if (visibilityInfo.visibleFraction == 0) {
                          // Pause the video when not visible
                          controller.chewieController.value?.pause();
                        } else {
                          // Play the video when visible
                          controller.chewieController.value?.play();
                        }
                      },
                      child: post.postVideo.isNotEmpty
                          ? SizedBox(
                              height: 180,
                              child: Chewie(
                                controller: controller.chewieController.value!,
                              ),
                            )
                          : Container(), // Display other content if there's no video
                    );
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
              Text(
                "${post.likeCount} Likes",
                style: const TextStyle(
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: Color(0xff262626),
                ),
              ),
              Text(
                "${post.comments.length} Comments",
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
              Obx(() => TextButton.icon(
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
                    onPressed: () async {
                      final success = await controller.likePost(
                        postId: post.postId,
                        action: isLiked.value ? "unlike" : "like",
                      );
                      if (success) {
                        isLiked.value = !isLiked.value;
                      }
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
                    CommentBottomSheet(post: post),
                    isScrollControlled: true,
                  ).whenComplete(() {
                    Get.delete<CommentController>();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
