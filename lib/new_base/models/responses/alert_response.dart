import 'package:pollution_environment/new_base/models/entities/alert_entity.dart';

class AlertResponse {
  List<AlertEntity>? results;
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
      results = <AlertEntity>[];
      json['results'].forEach((v) {
        results!.add(AlertEntity.fromJson(v));
      });
    }
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    totalResults = json['totalResults'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['page'] = page;
    data['limit'] = limit;
    data['totalPages'] = totalPages;
    data['totalResults'] = totalResults;
    return data;
  }
}