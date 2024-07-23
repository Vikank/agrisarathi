import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/community_controller.dart';
import 'community/add_new_post.dart';
import 'community/post_card.dart';
import 'community/post_details_screen.dart';

class CommunityForumScreen extends StatelessWidget {
  CommunityForumController controller = Get.put(CommunityForumController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () => Get.to(()=>PostDetailsScreen(post: controller.posts[index])), child: PostCard(post: controller.posts[index]));
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.to(() => AddPostScreen()),
      ),
    );
  }

}