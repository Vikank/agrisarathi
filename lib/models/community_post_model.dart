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

/*class CommunityPost {
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

  CommunityPost({
    this.userName,
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
    this.commentList,
  });

  CommunityPost.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'] as String?;
    userId = json['user_id'] as int?;
    postId = json['post_id'] as int?;
    profilePic = json['profile_pic'] as String?;
    cropName = json['crop_name'] as String?;
    postImage = json['post_image'] as String?;
    likeCount = json['like_count'] as int?;
    isLikedbysameuser = json['is_likedbysameuser'] as bool?;
    usersLiked = (json['users_liked'] as List?)?.map((dynamic e) => UsersLiked.fromJson(e as Map<String,dynamic>)).toList();
    description = json['description'] as String?;
    createdDt = json['created_dt'] as String?;
    commentList = (json['comment_list'] as List?)?.map((dynamic e) => CommentList.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['user_name'] = userName;
    json['user_id'] = userId;
    json['post_id'] = postId;
    json['profile_pic'] = profilePic;
    json['crop_name'] = cropName;
    json['post_image'] = postImage;
    json['like_count'] = likeCount;
    json['is_likedbysameuser'] = isLikedbysameuser;
    json['users_liked'] = usersLiked?.map((e) => e.toJson()).toList();
    json['description'] = description;
    json['created_dt'] = createdDt;
    json['comment_list'] = commentList?.map((e) => e.toJson()).toList();
    return json;
  }
}

class UsersLiked {
  dynamic userId;
  dynamic userName;
  int? postId;

  UsersLiked({
    this.userId,
    this.userName,
    this.postId,
  });

  UsersLiked.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    postId = json['post_id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['user_id'] = userId;
    json['user_name'] = userName;
    json['post_id'] = postId;
    return json;
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

  CommentList({
    this.userName,
    this.userId,
    this.profilePic,
    this.id,
    this.postComment,
    this.createdDt,
    this.replyComments,
  });

  CommentList.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'] as String?;
    userId = json['user_id'] as int?;
    profilePic = json['profile_pic'] as String?;
    id = json['id'] as int?;
    postComment = json['post_comment'] as String?;
    createdDt = json['created_dt'] as String?;
    replyComments = (json['reply_comments'] as List?)?.map((dynamic e) => ReplyComments.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['user_name'] = userName;
    json['user_id'] = userId;
    json['profile_pic'] = profilePic;
    json['id'] = id;
    json['post_comment'] = postComment;
    json['created_dt'] = createdDt;
    json['reply_comments'] = replyComments?.map((e) => e.toJson()).toList();
    return json;
  }
}

class ReplyComments {
  String? userName;
  int? userId;
  String? profilePic;
  int? id;
  String? text;
  String? createdDt;

  ReplyComments({
    this.userName,
    this.userId,
    this.profilePic,
    this.id,
    this.text,
    this.createdDt,
  });

  ReplyComments.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'] as String?;
    userId = json['user_id'] as int?;
    profilePic = json['profile_pic'] as String?;
    id = json['id'] as int?;
    text = json['text'] as String?;
    createdDt = json['created_dt'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['user_name'] = userName;
    json['user_id'] = userId;
    json['profile_pic'] = profilePic;
    json['id'] = id;
    json['text'] = text;
    json['created_dt'] = createdDt;
    return json;
  }
}*/
