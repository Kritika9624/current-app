class PostsModel {
  int? id;
  String? userId;
  String? title;
  String? body;
  String? username;
  List<String>? comments;
  int? likes;
  int? totalComments;
  String? createdAt;
  List<String>? hashtags;

  PostsModel(
      {this.id,
        this.userId,
        this.title,
        this.body,
        this.username,
        this.comments,
        this.likes,
        this.totalComments,
        this.createdAt,
        this.hashtags});

  PostsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    body = json['body'];
    username = json['username'];
    comments = json['comments'].cast<String>();
    likes = json['likes'];
    totalComments = json['totalComments'];
    createdAt = json['createdAt'];
    hashtags = json['hashtags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['username'] = this.username;
    data['comments'] = this.comments;
    data['likes'] = this.likes;
    data['totalComments'] = this.totalComments;
    data['createdAt'] = this.createdAt;
    data['hashtags'] = this.hashtags;
    return data;
  }
}