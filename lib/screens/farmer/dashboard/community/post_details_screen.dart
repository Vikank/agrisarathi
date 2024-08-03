import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpo_assist/controllers/community_controller.dart';
import 'package:fpo_assist/models/community_post_model.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';

class PostDetailsScreen extends StatelessWidget {
  final CommunityPost post;
  final CommunityForumController controller = Get.find();
  int? currentFocussedCommentID;
  PostDetailsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();
    OutlineInputBorder CommentBoxborder =
        OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(5));
    RxInt likeCount = post.likeCount!.obs;
    FocusNode myFocusNode = FocusNode();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Community Form".tr,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: "Bitter",
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${ApiEndPoints.baseUrl}${post.profilePic}'),
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Obx(() => Text('${likeCount} Likes')),
                    Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                    ),
                    post.commentList!.isNotEmpty ? Text('${post.commentList!.length} Comments') : Text('0 Comments'),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    IconButton(
                      // icon: Image.asset("assets/icons/like.png", width: 24, height: 24, color: post.isLikedbysameuser??false ? Colors.blue : null ),
                      // icon: Image.asset("assets/icons/like.png", width: 24, height: 24,),
                      icon: Icon(Icons.thumb_up_alt_outlined,
                          color: post.isLikedbysameuser ?? false ? Colors.blue : null),
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
                    SizedBox(
                      width: 70,
                    ),
                    IconButton(
                      icon: Image.asset(
                        "assets/icons/comment.png",
                        width: 24,
                        height: 24,
                      ),
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
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: post.commentList?.length,
                  itemBuilder: (context, index) {
                    CommentList? comment = post.commentList?[index];
                    return comments(
                        myFocusNode: myFocusNode,
                        comment: comment,
                        userName: comment?.userName ?? '',
                        profilePic: comment?.profilePic ?? '',
                        postComment: comment?.postComment ?? '');
                  },
                ),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Expanded(
                    child: TextField(
                      focusNode: myFocusNode,
                      controller: commentController,
                      decoration: InputDecoration(
                          hintText: "Comment",
                          border: CommentBoxborder,
                          enabledBorder: CommentBoxborder,
                          focusedBorder: CommentBoxborder),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      debugPrint("--------Comment -----------------");
                      controller.addComment(post.postId ?? -1,commentController.text.trim());},
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        )),
                  )
                ])
              ],
            ),
          ),
        ));
  }

  Column comments(
      {required FocusNode myFocusNode,
      required CommentList? comment,
      required String userName,
      required String profilePic,
      required String postComment}) {
    int replyCommentsCount = comment?.replyComments?.length ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('${ApiEndPoints.baseUrl}${profilePic}'),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName),
                Text("----"),
              ],
            )
          ],
        ),
        SizedBox(height: 10),
        Text(postComment),
        TextButton(
            onPressed: () {
              myFocusNode.requestFocus();
              currentFocussedCommentID = comment?.id;
            },
            child: Text(
              "Reply",
              style: TextStyle(fontSize: 15, color: Colors.green, decoration: TextDecoration.underline),
            )),
        SizedBox(height: 10),
        for (int i = 0; i < replyCommentsCount; i++)
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: replyComments(comment?.replyComments?[i].profilePic ?? '', comment?.replyComments?[i].userName ?? '',
                comment?.replyComments?[i].text ?? ''),
          )
      ],
    );
  }

  Column replyComments(String profilePic, String userName, String postComment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('${ApiEndPoints.baseUrl}${profilePic}'),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName),
                Text("----"),
              ],
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(postComment),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
