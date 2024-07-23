class CommunityPost {
  String? userName;
  int? userId;
  int? postId;
  String? profilePic;
  String? cropName;
  String? postImage;
  int? likeCount;
  bool? isLikedbysameuser;
  List<UsersLiked>? usersLiked;
  String? description;
  String? createdDt;
  List<CommentList>? commentList;

  CommunityPost(
      {this.userName,
        this.userId,
        this.postId,
        this.profilePic,
        this.cropName,
        this.postImage,
        this.likeCount,
        this.isLikedbysameuser,
        this.usersLiked,
        this.description,
        this.createdDt,
        this.commentList});

  CommunityPost.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userId = json['user_id'];
    postId = json['post_id'];
    profilePic = json['profile_pic'];
    cropName = json['crop_name'];
    postImage = json['post_image'];
    likeCount = json['like_count'];
    isLikedbysameuser = json['is_likedbysameuser'];
    if (json['users_liked'] != null) {
      usersLiked = <UsersLiked>[];
      json['users_liked'].forEach((v) {
        usersLiked!.add(UsersLiked.fromJson(v));
      });
    }
    description = json['description'];
    createdDt = json['created_dt'];
    if (json['comment_list'] != null) {
      commentList = <CommentList>[];
      json['comment_list'].forEach((v) {
        commentList!.add(CommentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_name'] = userName;
    data['user_id'] = userId;
    data['post_id'] = postId;
    data['profile_pic'] = profilePic;
    data['crop_name'] = cropName;
    data['post_image'] = postImage;
    data['like_count'] = likeCount;
    data['is_likedbysameuser'] = isLikedbysameuser;
    if (usersLiked != null) {
      data['users_liked'] = usersLiked!.map((v) => v.toJson()).toList();
    }
    data['description'] = description;
    data['created_dt'] = createdDt;
    if (commentList != null) {
      data['comment_list'] = commentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UsersLiked {
  int? userId;
  String? userName;
  int? postId;

  UsersLiked({this.userId, this.userName, this.postId});

  UsersLiked.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    postId = json['post_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['post_id'] = postId;
    return data;
  }
}

class CommentList {
  String? userName;
  int? userId;
  String? profilePic;
  int? id;
  String? postComment;
  String? createdDt;
  List<ReplyComments>? replyComments;

  CommentList(
      {this.userName,
        this.userId,
        this.profilePic,
        this.id,
        this.postComment,
        this.createdDt,
        this.replyComments});

  CommentList.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userId = json['user_id'];
    profilePic = json['profile_pic'];
    id = json['id'];
    postComment = json['post_comment'];
    createdDt = json['created_dt'];
    if (json['reply_comments'] != null) {
      replyComments = <ReplyComments>[];
      json['reply_comments'].forEach((v) {
        replyComments!.add(ReplyComments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_name'] = userName;
    data['user_id'] = userId;
    data['profile_pic'] = profilePic;
    data['id'] = id;
    data['post_comment'] = postComment;
    data['created_dt'] = createdDt;
    if (replyComments != null) {
      data['reply_comments'] =
          replyComments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReplyComments {
  String? userName;
  int? userId;
  String? profilePic;
  int? id;
  String? text;
  String? createdDt;

  ReplyComments(
      {this.userName,
        this.userId,
        this.profilePic,
        this.id,
        this.text,
        this.createdDt});

  ReplyComments.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userId = json['user_id'];
    profilePic = json['profile_pic'];
    id = json['id'];
    text = json['text'];
    createdDt = json['created_dt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_name'] = userName;
    data['user_id'] = userId;
    data['profile_pic'] = profilePic;
    data['id'] = id;
    data['text'] = text;
    data['created_dt'] = createdDt;
    return data;
  }
}