class PollutionType {
  String? key;
  String? name;

  PollutionType({this.key, this.name});

  PollutionType.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    return data;
  }
}
