import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

class WAQIMapResponse {
  String? status;
  List<WAQIMapData>? data;

  WAQIMapResponse({this.status, this.data});

  WAQIMapResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <WAQIMapData>[];
      json['data'].forEach((v) {
        data!.add(new WAQIMapData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WAQIMapData with ClusterItem {
  double? lat;
  double? lon;
  int? uid;
  String? aqi;
  WAQIMapStation? station;

  WAQIMapData({this.lat, this.lon, this.uid, this.aqi, this.station});

  WAQIMapData.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    uid = json['uid'];
    aqi = json['aqi'];
    station = json['station'] != null
        ? new WAQIMapStation.fromJson(json['station'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['uid'] = this.uid;
    data['aqi'] = this.aqi;
    if (this.station != null) {
      data['station'] = this.station!.toJson();
    }
    return data;
  }

  @override
  LatLng get location => LatLng(lat ?? 0, lon ?? 0);
}

class WAQIMapStation {
  String? name;
  String? time;

  WAQIMapStation({this.name, this.time});

  WAQIMapStation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['time'] = this.time;
    return data;
  }
}
