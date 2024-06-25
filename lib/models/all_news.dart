class AllNews {
  AllNews({
    required this.status,
    required this.articles,
  });
  late final String status;
  late final List<Articles> articles;

  AllNews.fromJson(Map<String, dynamic> json){
    status = json['status'];
    articles = List.from(json['articles']).map((e)=>Articles.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['articles'] = articles.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Articles {
  Articles({
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
  late final int newsId;
  late final String title;
  late final String content;
  late final String image;
  late final String newsType;
  late final String source;
  late final String link;
  late final String publishDate;
  late final String language;

  Articles.fromJson(Map<String, dynamic> json){
    newsId = json['news_id'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    newsType = json['news_type'];
    source = json['source'];
    link = json['link'];
    publishDate = json['publish_date'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['news_id'] = newsId;
    _data['title'] = title;
    _data['content'] = content;
    _data['image'] = image;
    _data['news_type'] = newsType;
    _data['source'] = source;
    _data['link'] = link;
    _data['publish_date'] = publishDate;
    _data['language'] = language;
    return _data;
  }
}