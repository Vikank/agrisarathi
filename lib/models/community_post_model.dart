import 'package:get/get.dart';

class CommunityPost {
  final String userName;
  final int userId;
  final int postId;
  final String profilePic;
  final String postImage;
  final int likeCount;
  final bool isLikedByUser;
  final List<UserLike> usersLiked;
  final String description;
  final String createdDate;
  final RxList<Comment> comments;

  CommunityPost({
    required this.userName,
    required this.userId,
    required this.postId,
    required this.profilePic,
    required this.postImage,
    required this.likeCount,
    required this.isLikedByUser,
    required this.usersLiked,
    required this.description,
    required this.createdDate,
    required this.comments,
  });

  factory CommunityPost.fromJson(Map<String, dynamic> json) {
    return CommunityPost(
      userName: json['user_name'],
      userId: json['user_id'],
      postId: json['post_id'],
      profilePic: json['profile_pic'],
      postImage: json['post_image'],
      likeCount: json['like_count'],
      isLikedByUser: json['is_likedbysameuser'],
      usersLiked: (json['users_liked'] as List)
          .map((like) => UserLike.fromJson(like))
          .toList(),
      description: json['description'],
      createdDate: json['created_dt'],
      comments: RxList<Comment>.from(
        (json['comment_list'] as List).map((comment) => Comment.fromJson(comment)),
      ),
    );
  }
}

class UserLike {
  final int? userId;
  final String? userName;
  final int postId;

  UserLike({
    this.userId,
    this.userName,
    required this.postId,
  });

  factory UserLike.fromJson(Map<String, dynamic> json) {
    return UserLike(
      userId: json['user_id'],
      userName: json['user_name'],
      postId: json['post_id'],
    );
  }
}

class Comment {
  final String userName;
  final int userId;
  final String profilePic;
  final int id;
  final String postComment;
  final String createdDate;
  final List<Reply> replyComments;

  Comment({
    required this.userName,
    required this.userId,
    required this.profilePic,
    required this.id,
    required this.postComment,
    required this.createdDate,
    required this.replyComments,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userName: json['user_name'],
      userId: json['user_id'],
      profilePic: json['profile_pic'],
      id: json['id'],
      postComment: json['post_comment'],
      createdDate: json['created_dt'],
      replyComments: (json['reply_comments'] as List)
          .map((reply) => Reply.fromJson(reply))
          .toList(),
    );
  }
}

class Reply {
  final String userName;
  final int userId;
  final String profilePic;
  final int id;
  final String text;
  final String createdDate;

  Reply({
    required this.userName,
    required this.userId,
    required this.profilePic,
    required this.id,
    required this.text,
    required this.createdDate,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      userName: json['user_name'],
      userId: json['user_id'],
      profilePic: json['profile_pic'],
      id: json['id'],
      text: json['text'],
      createdDate: json['created_dt'],
    );
  }
}