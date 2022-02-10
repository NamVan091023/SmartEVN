class PollutionModel {
  List<String>? images;
  int? qualityScore;
  String? provinceName;
  int? provinceId;
  String? districtName;
  int? districtId;
  String? wardName;
  int? wardId;
  String? type;
  String? quality;
  String? user;
  String? desc;
  String? specialAddress;
  double? lat;
  double? lng;
  String? createdAt;
  String? updatedAt;
  String? id;

  PollutionModel(
      {this.images,
      this.qualityScore,
      this.provinceName,
      this.provinceId,
      this.districtName,
      this.districtId,
      this.wardName,
      this.wardId,
      this.type,
      this.quality,
      this.user,
      this.desc,
      this.specialAddress,
      this.lat,
      this.lng,
      this.createdAt,
      this.updatedAt,
      this.id});

  PollutionModel.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    qualityScore = json['qualityScore'];
    provinceName = json['provinceName'];
    provinceId = json['provinceId'];
    districtName = json['districtName'];
    districtId = json['districtId'];
    wardName = json['wardName'];
    wardId = json['wardId'];
    type = json['type'];
    quality = json['quality'];
    user = json['user'];
    desc = json['desc'];
    specialAddress = json['specialAddress'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['qualityScore'] = this.qualityScore;
    data['provinceName'] = this.provinceName;
    data['provinceId'] = this.provinceId;
    data['districtName'] = this.districtName;
    data['districtId'] = this.districtId;
    data['wardName'] = this.wardName;
    data['wardId'] = this.wardId;
    data['type'] = this.type;
    data['quality'] = this.quality;
    data['user'] = this.user;
    data['desc'] = this.desc;
    data['specialAddress'] = this.specialAddress;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

class PollutionsResponse {
  List<PollutionModel>? results;
  int? page;
  int? limit;
  int? totalPages;
  int? totalResults;
  double? avgQualityScore;
  String? avgQuality;

  PollutionsResponse(
      {this.results,
      this.page,
      this.limit,
      this.totalPages,
      this.totalResults,
      this.avgQualityScore,
      this.avgQuality});

  PollutionsResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <PollutionModel>[];
      json['results'].forEach((v) {
        results!.add(new PollutionModel.fromJson(v));
      });
    }
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    totalResults = json['totalResults'];
    avgQualityScore = json['avgQualityScore'];
    avgQuality = json['avgQuality'];
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
    data['avgQualityScore'] = this.avgQualityScore;
    data['avgQuality'] = this.avgQuality;
    return data;
  }
}