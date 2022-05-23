import 'alert_model.dart';

class NotificationAlertResponse {
  List<NotificationAlert>? results;
  int? page;
  int? limit;
  int? totalPages;
  int? totalResults;

  NotificationAlertResponse(
      {this.results,
      this.page,
      this.limit,
      this.totalPages,
      this.totalResults});

  NotificationAlertResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <NotificationAlert>[];
      json['results'].forEach((v) {
        results!.add(new NotificationAlert.fromJson(v));
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

class NotificationAlert {
  Alert? alert;
  String? user;
  String? createdAt;
  String? updatedAt;
  String? id;

  NotificationAlert(
      {this.alert, this.user, this.createdAt, this.updatedAt, this.id});

  NotificationAlert.fromJson(Map<String, dynamic> json) {
    alert = json['alert'] != null ? new Alert.fromJson(json['alert']) : null;
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.alert != null) {
      data['alert'] = this.alert!.toJson();
    }
    data['user'] = this.user;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}
