class DataFacebook {
  List<Data> data;

  DataFacebook({this.data});

  DataFacebook.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String description;
  String name;
  String message;
  String updatedTime;
  String link;
  int view = 0;

  Data(
      {this.id,
      this.description,
      this.name,
      this.message,
      this.updatedTime,
      this.link,
      this.view});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    name = json['name'];
    message = json['message'];
    updatedTime = json['updated_time'];
    link = json['link'];
    if (json['view'] == null)
      view = 0;
    else
      view = json['view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['name'] = this.name;
    data['message'] = this.message;
    data['updated_time'] = this.updatedTime;
    data['link'] = this.link;
    data['view'] = this.view;
    return data;
  }
}
