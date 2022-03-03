import 'package:pollution_environment/src/model/pollution_response.dart';

class NotificationResponse {
  List<NotificationModel>? results;
  int? page;
  int? limit;
  int? totalPages;
  int? totalResults;

  NotificationResponse(
      {this.results,
      this.page,
      this.limit,
      this.totalPages,
      this.totalResults});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <NotificationModel>[];
      json['results'].forEach((v) {
        results!.add(new NotificationModel.fromJson(v));
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

class NotificationModel {
  String? user;
  PollutionModel? pollution;
  String? createdAt;
  String? updatedAt;
  String? id;

  NotificationModel(
      {this.user, this.pollution, this.createdAt, this.updatedAt, this.id});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    pollution = json['pollution'] != null
        ? new PollutionModel.fromJson(json['pollution'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    if (this.pollution != null) {
      data['pollution'] = this.pollution!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}
