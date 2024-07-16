class CommunityPost {
  final String? userName;
  final int? userId;
  final int? postId;
  final String? profilePic;
  final String? cropName;
  final String? postImage;
  int? likeCount;
  final String? description;
  final String? createdDt;
  final List<Comment>? commentList;

  CommunityPost({
    this.userName,
    this.userId,
    this.postId,
    this.profilePic,
    this.cropName,
    this.postImage,
    this.likeCount,
    this.description,
    this.createdDt,
    this.commentList,
  });

  factory CommunityPost.fromJson(Map<String, dynamic> json) {
    return CommunityPost(
      userName: json['user_name'] as String?,
      userId: json['user_id'] != null ? int.tryParse(json['user_id'].toString()) : null,
      postId: json['post_id'] != null ? int.tryParse(json['post_id'].toString()) : null,
      profilePic: json['profile_pic'] as String?,
      cropName: json['crop_name'] as String?,
      postImage: json['post_image'] as String?,
      likeCount: json['like_count'] != null ? int.tryParse(json['like_count'].toString()) : null,
      description: json['description'] as String?,
      createdDt: json['created_dt'] as String?,
      commentList: (json['comment_list'] as List?)
          ?.map((comment) => Comment.fromJson(comment as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Comment {
  final String? userName;
  final int? userId;
  final String? profilePic;
  final int? id;
  final String? postComment;
  final String? createdDt;
  final List<ReplyComment>? replyComments;

  Comment({
    this.userName,
    this.userId,
    this.profilePic,
    this.id,
    this.postComment,
    this.createdDt,
    this.replyComments,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userName: json['user_name'] as String?,
      userId: json['user_id'] != null ? int.tryParse(json['user_id'].toString()) : null,
      profilePic: json['profile_pic'] as String?,
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      postComment: json['post_comment'] as String?,
      createdDt: json['created_dt'] as String?,
      replyComments: (json['reply_comments'] as List?)
          ?.map((reply) => ReplyComment.fromJson(reply as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ReplyComment {
  final String? userName;
  final int? userId;
  final String? profilePic;
  final int? id;
  final String? text;
  final String? createdDt;

  ReplyComment({
    this.userName,
    this.userId,
    this.profilePic,
    this.id,
    this.text,
    this.createdDt,
  });

  factory ReplyComment.fromJson(Map<String, dynamic> json) {
    return ReplyComment(
      userName: json['user_name'] as String?,
      userId: json['user_id'] != null ? int.tryParse(json['user_id'].toString()) : null,
      profilePic: json['profile_pic'] as String?,
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      text: json['text'] as String?,
      createdDt: json['created_dt'] as String?,
    );
  }
}