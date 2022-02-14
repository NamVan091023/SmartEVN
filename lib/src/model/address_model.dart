class AddressModel {
  List<ProvinceModel>? data;
  String? dataDate;
  int? generateDate;

  AddressModel({this.data, this.dataDate, this.generateDate});

  AddressModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProvinceModel>[];
      json['data'].forEach((v) {
        data!.add(new ProvinceModel.fromJson(v));
      });
    }
    dataDate = json['data_date'];
    generateDate = json['generate_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['data_date'] = this.dataDate;
    data['generate_date'] = this.generateDate;
    return data;
  }
}

class ProvinceModel {
  String? id;
  String? name;
  String? type;
  List<DistrictModel>? districts;

  ProvinceModel({this.id, this.name, this.type, this.districts});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    id = json['level1_id'];
    name = json['name'];
    type = json['type'];
    if (json['level2s'] != null) {
      districts = <DistrictModel>[];
      json['level2s'].forEach((v) {
        districts!.add(new DistrictModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level1_id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    if (this.districts != null) {
      data['level2s'] = this.districts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DistrictModel {
  String? id;
  String? name;
  String? type;
  List<WardModel>? wards;

  DistrictModel({this.id, this.name, this.type, this.wards});

  DistrictModel.fromJson(Map<String, dynamic> json) {
    id = json['level2_id'];
    name = json['name'];
    type = json['type'];
    if (json['level3s'] != null) {
      wards = <WardModel>[];
      json['level3s'].forEach((v) {
        wards!.add(new WardModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level2_id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    if (this.wards != null) {
      data['level3s'] = this.wards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WardModel {
  String? id;
  String? name;
  String? type;

  WardModel({this.id, this.name, this.type});

  WardModel.fromJson(Map<String, dynamic> json) {
    id = json['level3_id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level3_id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}
