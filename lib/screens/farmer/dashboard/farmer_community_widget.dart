import 'package:flutter/material.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:fpo_assist/utils/helper_functions.dart';
import 'package:get/get.dart';

import '../../../controllers/shared/community/community_controller.dart';
import '../../../models/community_post_model.dart';
import 'community/comment_sheet.dart';

class CommunityForumScreen extends StatelessWidget {
  final CommunityController controller = Get.put(CommunityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.separated(
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final post = controller.posts[index];
              return CommunityPostCard(post: post);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 30);
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Implement new post creation
        },
      ),
    );
  }
}

class CommunityPostCard extends StatelessWidget {
  final CommunityPost post;

  CommunityPostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(ApiEndPoints.baseUrl + post.profilePic)),
            title: Text(
              post.userName,
              style: TextStyle(
                  fontFamily: "NotoSans",
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
            subtitle: Text(
              HelperFunctions().formatDate(post.createdDate),
              style: TextStyle(
                  fontFamily: "NotoSans",
                  fontWeight: FontWeight.w400,
                  fontSize: 10),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              post.description,
              style: TextStyle(
                  fontFamily: "NotoSans",
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
          ),
          if (post.postImage.isNotEmpty)
            Image.network(
              ApiEndPoints.baseUrl + post.postImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${post.likeCount} Likes",
                style: TextStyle(
                    fontFamily: "NotoSans",
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Color(0xff262626)),
              ),
              Text(
                "${post.comments.length} Comments",
                style: TextStyle(
                    fontFamily: "NotoSans",
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Color(0xff262626)),
              )
            ],
          ),
          Divider(
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton.icon(
                icon: Image.asset(
                  "assets/icons/like.png",
                  width: 24,
                  height: 24,
                ),
                label: Text(
                  'Like',
                  style: TextStyle(
                      fontFamily: "NotoSans",
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: Colors.black),
                ),
                onPressed: () {
                  // Implement like functionality
                },
              ),
              TextButton.icon(
                icon: Image.asset(
                  "assets/icons/comment.png",
                  width: 24,
                  height: 24,
                ),
                label: Text(
                  'Comment',
                  style: TextStyle(
                      fontFamily: "NotoSans",
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: Colors.black),
                ),
                onPressed: () {
                  Get.bottomSheet(
                    ignoreSafeArea: true,
                    CommentBottomSheet(post: post),
                    isScrollControlled: true,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
