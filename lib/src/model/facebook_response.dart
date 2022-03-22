class FBNewsResponse {
  List<FBNews>? results;
  int? page;
  int? limit;
  int? totalPages;
  int? totalResults;

  FBNewsResponse(
      {this.results,
      this.page,
      this.limit,
      this.totalPages,
      this.totalResults});

  FBNewsResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <FBNews>[];
      json['results'].forEach((v) {
        results!.add(new FBNews.fromJson(v));
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

class FBNews {
  String? id;
  String? permalinkUrl;
  String? message;
  String? fullPicture;
  From? from;
  String? objectId;
  String? createdTime;
  String? type;

  FBNews(
      {this.id,
      this.permalinkUrl,
      this.message,
      this.fullPicture,
      this.from,
      this.objectId,
      this.createdTime,
      this.type});

  FBNews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    permalinkUrl = json['permalink_url'];
    message = json['message'];
    fullPicture = json['full_picture'];
    from = json['from'] != null ? new From.fromJson(json['from']) : null;
    objectId = json['object_id'];
    createdTime = json['created_time'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['permalink_url'] = this.permalinkUrl;
    data['message'] = this.message;
    data['full_picture'] = this.fullPicture;
    if (this.from != null) {
      data['from'] = this.from!.toJson();
    }
    data['object_id'] = this.objectId;
    data['created_time'] = this.createdTime;
    data['type'] = this.type;
    return data;
  }
}

class From {
  String? name;
  String? id;

  From({this.name, this.id});

  From.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
