class NewsArticle {
  NewsArticle({
    required this.newsId,
    required this.title,
    required this.content,
    required this.image,
    required this.newsType,
    required this.source,
    required this.link,
    required this.publishDate,
    required this.language,
  });
  late final int? newsId;
  late final String? title;
  late final String? content;
  late final String? image;
  late final String? newsType;
  late final String? source;
  late final String? link;
  late final String? publishDate;
  late final String? language;

  NewsArticle.fromJson(Map<String, dynamic> json){
    newsId = json['id'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    newsType = json['related_post'];
    source = json['source'];
    link = json['link'];
    publishDate = json['created_at'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = newsId;
    _data['title'] = title;
    _data['content'] = content;
    _data['image'] = image;
    _data['related_post'] = newsType;
    _data['source'] = source;
    _data['link'] = link;
    _data['created_at'] = publishDate;
    _data['language'] = language;
    return _data;
  }
}




