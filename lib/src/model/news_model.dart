class NewsModel {
  String? id;
  String? link;
  String? title;
  String? topic;
  String? author;
  String? time;
  String? content;
  List<String>? image;
  List<Tags>? tags;

  NewsModel(
      {this.id,
      this.link,
      this.title,
      this.topic,
      this.author,
      this.time,
      this.content,
      this.image,
      this.tags});

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    title = json['title'];
    topic = json['topic'];
    author = json['author'];
    time = json['time'];
    content = json['content'];
    image = json['image'].cast<String>();
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['link'] = this.link;
    data['title'] = this.title;
    data['topic'] = this.topic;
    data['author'] = this.author;
    data['time'] = this.time;
    data['content'] = this.content;
    data['image'] = this.image;
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags {
  String? tagName;
  String? tagLink;

  Tags({this.tagName, this.tagLink});

  Tags.fromJson(Map<String, dynamic> json) {
    tagName = json['tag_name'];
    tagLink = json['tag_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_name'] = this.tagName;
    data['tag_link'] = this.tagLink;
    return data;
  }
}

class NewsResponse {
  List<NewsModel>? results;
  int? page;
  int? limit;
  int? totalPages;
  int? totalResults;

  NewsResponse(
      {this.results,
      this.page,
      this.limit,
      this.totalPages,
      this.totalResults});

  NewsResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <NewsModel>[];
      json['results'].forEach((v) {
        results!.add(new NewsModel.fromJson(v));
      });
    }
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    totalResults = json['totalResults'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['totalPages'] = this.totalPages;
    data['totalResults'] = this.totalResults;
    return data;
  }
}
