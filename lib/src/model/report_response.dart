class ReportModel {
  List<ReportData>? data;

  ReportModel({this.data});

  ReportModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new ReportData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReportData {
  String? id, latitude, longitude, address;
  int? type, status, like;

  ReportData(this.id, this.latitude, this.longitude, this.address, this.status,
      this.type);

  ReportData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'] == null ? "" : json['latitude'];
    longitude = json['longitude'] == null ? "" : json['longitude'];
    address = json['address'] == null ? "" : json['address'];
    type = json['type'] == null ? 0 : json['type'];
    status = json['status'] == null ? 0 : json['status'];
    like = json['like'] == null ? 0 : json['like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['type'] = this.type;
    data['status'] = this.status;
    data['like'] = this.like;
    return data;
  }
}
