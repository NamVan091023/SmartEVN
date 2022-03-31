import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

class AQIMapResponse {
  List<Markers>? markers;
  int? total;

  AQIMapResponse({this.markers, this.total});

  AQIMapResponse.fromJson(Map<String, dynamic> json) {
    if (json['markers'] != null) {
      markers = <Markers>[];
      json['markers'].forEach((v) {
        markers!.add(new Markers.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.markers != null) {
      data['markers'] = this.markers!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Markers with ClusterItem {
  String? type;
  String? geohashMarker;
  int? stationsCount;
  Coordinates? coordinates;
  num? aqi;
  String? name;
  String? url;
  String? id;

  Markers(
      {this.type,
      this.geohashMarker,
      this.stationsCount,
      this.coordinates,
      this.aqi,
      this.name,
      this.url,
      this.id});

  Markers.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    geohashMarker = json['geohash'];
    stationsCount = json['stationsCount'];
    coordinates = json['coordinates'] != null
        ? new Coordinates.fromJson(json['coordinates'])
        : null;
    aqi = json['aqi'];
    name = json['name'];
    url = json['url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['geohash'] = this.geohash;
    data['stationsCount'] = this.stationsCount;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.toJson();
    }
    data['aqi'] = this.aqi;
    data['name'] = this.name;
    data['url'] = this.url;
    data['id'] = this.id;
    return data;
  }

  @override
  LatLng get location =>
      LatLng(coordinates?.latitude ?? 0, coordinates?.longitude ?? 0);
}

class Coordinates {
  double? latitude;
  double? longitude;

  Coordinates({this.latitude, this.longitude});

  Coordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
