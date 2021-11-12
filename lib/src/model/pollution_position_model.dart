class PollutionPositionModel {
  int _errorCode;
  String _message;
  Data _data;

  PollutionPositionModel({int errorCode, String message, Data data}) {
    this._errorCode = errorCode;
    this._message = message;
    this._data = data;
  }

  int get errorCode => _errorCode;

  set errorCode(int errorCode) => _errorCode = errorCode;

  String get message => _message;

  set message(String message) => _message = message;

  Data get data => _data;

  set data(Data data) => _data = data;

  PollutionPositionModel.fromJson(Map<String, dynamic> json) {
    _errorCode = json['errorCode'];
    _message = json['message'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this._errorCode;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    return data;
  }
}

class Data {
  List<PollutionPosition> _pollutionPosition;

  Data({List<PollutionPosition> pollutionPosition}) {
    this._pollutionPosition = pollutionPosition;
  }

  List<PollutionPosition> get pollutionPosition => _pollutionPosition;

  set pollutionPosition(List<PollutionPosition> pollutionPosition) =>
      _pollutionPosition = pollutionPosition;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['pollutionPosition'] != null) {
      _pollutionPosition = new List<PollutionPosition>();
      json['pollutionPosition'].forEach((v) {
        _pollutionPosition.add(new PollutionPosition.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._pollutionPosition != null) {
      data['pollutionPosition'] =
          this._pollutionPosition.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PollutionPosition {
  String _id;
  String _longtitude;
  String _latitude;
  String _type;
  String _city;
  String _district;

  PollutionPosition(
      {String id,
      String longitude,
      String latitude,
      String type,
      String city,
      String district}) {
    this._id = id;
    this._longtitude = longtitude;
    this._latitude = latitude;
    this._type = type;
    this._city = city;
    this._district = district;
  }

  String get id => _id;

  set id(String id) => _id = id;

  String get longtitude => _longtitude;

  set longtitude(String longtitude) => _longtitude = longtitude;

  String get latitude => _latitude;

  set latitude(String latitude) => _latitude = latitude;

  String get type => _type;

  set type(String type) => _type = type;

  String get city => _city;

  set city(String city) => _city = city;

  String get district => _district;

  set district(String distric) => _district = distric;

  PollutionPosition.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _longtitude = json['longitude'];
    _latitude = json['latitude'];
    _type = json['type'];
    _city = json['city'];
    _district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['longitude'] = this._longtitude;
    data['latitude'] = this._latitude;
    data['type'] = this._type;
    data['city'] = this._city;
    data['district'] = this._district;
    return data;
  }
}
