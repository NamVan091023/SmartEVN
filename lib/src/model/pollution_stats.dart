import 'package:pollution_environment/src/model/pollution_response.dart';

class PollutionStats {
  int air = 0;
  int land = 0;
  int sound = 0;
  int water = 0;
  int total = 0;
  List<PollutionModel>? weekData;

  PollutionStats.fromJson(Map<String, dynamic> json) {
    air = json['air'];
    land = json['land'];
    sound = json['sound'];
    water = json['water'];
    total = json['total'];
    if (json['weekData'] != null) {
      weekData = <PollutionModel>[];
      json['weekData'].forEach((v) {
        weekData!.add(new PollutionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['air'] = this.air;
    data['land'] = this.land;
    data['sound'] = this.sound;
    data['water'] = this.water;
    data['total'] = this.total;
    if (this.weekData != null) {
      data['weekData'] = this.weekData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
