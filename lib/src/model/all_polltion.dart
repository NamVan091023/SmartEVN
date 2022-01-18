class PollutionModel {
  List<PollutionData>? data;

  PollutionModel({this.data});

  PollutionModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PollutionData>[];
      json['data'].forEach((v) {
        data!.add(new PollutionData.fromJson(v));
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

class PollutionData {
  String? name;
  int? district;
  int? totalPollution;
  int? normal;
  int? warning;
  int? dangerous;
  List<Items>? items;

  PollutionData({this.name, this.district, this.totalPollution, this.items});

  PollutionData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    district = json['district'];
    totalPollution = json['total_pollution'];
    dangerous = json['dangerous'];
    warning = json['warning'];
    normal = json['normal'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['district'] = this.district;
    data['total_pollution'] = this.totalPollution;
    data['normal'] = this.normal;
    data['warning'] = this.warning;
    data['dangerous'] = this.dangerous;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  String? latitude;
  String? longitude;
  String? address;
  int? type;
  int? district;
  int? level;

  Items(
      {this.id,
      this.latitude,
      this.longitude,
      this.address,
      this.type,
      this.district,
      this.level});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    type = json['type'];
    district = json['district'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['type'] = this.type;
    data['district'] = this.district;
    data['level'] = this.level;
    return data;
  }
}
