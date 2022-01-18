class NotificationModel {
  List<Data>? data;

  NotificationModel({this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? id, latitude, longitude, address, range;
  int? type;

  Data(this.id, this.latitude, this.longitude, this.address, this.range,
      this.type);

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'] == null ? "" : json['latitude'];
    longitude = json['longitude'] == null ? "" : json['longitude'];
    address = json['address'] == null ? "" : json['address'];
    type = json['type'] == null ? 0 : json['type'];
    range = json['range'] == null ? "" : json['range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['type'] = this.type;
    data['range'] = this.range;
    return data;
  }
}
