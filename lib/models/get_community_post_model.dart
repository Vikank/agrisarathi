class GetCommunityPostModel {
  String? status;
  String? msg;
  List<Data>? data;

  GetCommunityPostModel({this.status, this.msg, this.data});

  GetCommunityPostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? userId;
  int? id;
  String? profilePic;
  String? userName;
  String? userState;
  String? cropName;
  int? likeCount;
  String? postImage;
  String? description;
  String? createdDt;
  List<CommentList>? commentList;

  Data(
      {this.userId,
        this.id,
        this.profilePic,
        this.userName,
        this.userState,
        this.cropName,
        this.likeCount,
        this.postImage,
        this.description,
        this.createdDt,
        this.commentList});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    id = json['post_id'];
    profilePic = json['profile_pic'];
    userName = json['user_name'];
    userState = json['user_state'];
    cropName = json['crop_name'];
    likeCount = json['like_count'];
    postImage = json['post_image'];
    description = json['description'];
    createdDt = json['created_dt'];
    if (json['comment_list'] != null) {
      commentList = <CommentList>[];
      json['comment_list'].forEach((v) {
        commentList!.add(new CommentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['id'] = this.id;
    data['profile_pic'] = this.profilePic;
    data['user_name'] = this.userName;
    data['user_state'] = this.userState;
    data['crop_name'] = this.cropName;
    data['like_count'] = this.likeCount;
    data['post_image'] = this.postImage;
    data['description'] = this.description;
    data['created_dt'] = this.createdDt;
    if (this.commentList != null) {
      data['comment_list'] = this.commentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentList {
  int? userId;
  String? profilePic;
  int? id;
  String? userName;
  String? postComment;
  String? createdDt;
  List<ReplyComments>? replyComments;

  CommentList(
      {this.userId,
        this.profilePic,
        this.id,
        this.userName,
        this.postComment,
        this.createdDt,
        this.replyComments});

  CommentList.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    profilePic = json['profile_pic'];
    id = json['id'];
    userName = json['user_name'];
    postComment = json['post_comment'];
    createdDt = json['created_dt'];
    if (json['reply_comments'] != null) {
      replyComments = <ReplyComments>[];
      json['reply_comments'].forEach((v) {
        replyComments!.add(new ReplyComments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['profile_pic'] = this.profilePic;
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['post_comment'] = this.postComment;
    data['created_dt'] = this.createdDt;
    if (this.replyComments != null) {
      data['reply_comments'] =
          this.replyComments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReplyComments {
  int? userId;
  String? userName;
  String? profilePic;
  int? id;
  String? text;
  String? createdDt;

  ReplyComments(
      {this.userId, this.userName, this.profilePic, this.id, this.text, this.createdDt});

  ReplyComments.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    profilePic = json['profile_pic'];
    id = json['id'];
    text = json['text'];
    createdDt = json['created_dt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['profile_pic'] = this.profilePic;
    data['id'] = this.id;
    data['text'] = this.text;
    data['created_dt'] = this.createdDt;
    return data;
  }
}