class AlertEntity {
  List<String>? images;
  List<String>? provinceIds;
  String? title;
  String? content;
  String? userCreated;
  String? createdAt;
  String? updatedAt;
  String? id;

  AlertEntity({
    this.images,
    this.provinceIds,
    this.title,
    this.content,
    this.userCreated,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  AlertEntity.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    provinceIds = json['provinceIds'].cast<String>();
    title = json['title'];
    content = json['content'];
    userCreated = json['userCreated'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['images'] = images;
    data['provinceIds'] = provinceIds;
    data['title'] = title;
    data['content'] = content;
    data['userCreated'] = userCreated;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }
}
