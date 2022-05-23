class AlertResponse {
  List<Alert>? results;
  int? page;
  int? limit;
  int? totalPages;
  int? totalResults;

  AlertResponse(
      {this.results,
      this.page,
      this.limit,
      this.totalPages,
      this.totalResults});

  AlertResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Alert>[];
      json['results'].forEach((v) {
        results!.add(new Alert.fromJson(v));
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

class Alert {
  List<String>? images;
  List<String>? provinceIds;
  String? title;
  String? content;
  String? userCreated;
  String? createdAt;
  String? updatedAt;
  String? id;

  Alert(
      {this.images,
      this.provinceIds,
      this.title,
      this.content,
      this.userCreated,
      this.createdAt,
      this.updatedAt,
      this.id});

  Alert.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    provinceIds = json['provinceIds'].cast<String>();
    title = json['title'];
    content = json['content'];
    userCreated = json['userCreated'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['provinceIds'] = this.provinceIds;
    data['title'] = this.title;
    data['content'] = this.content;
    data['userCreated'] = this.userCreated;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}
