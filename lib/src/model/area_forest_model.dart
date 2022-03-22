class AreaForestModel {
  String? rank;
  String? country;
  String? forestAreaHectares;
  String? population2017;
  String? sqareMetersPerCapita;
  String? id;

  AreaForestModel(
      {this.rank,
      this.country,
      this.forestAreaHectares,
      this.population2017,
      this.sqareMetersPerCapita,
      this.id});

  AreaForestModel.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    country = json['country'];
    forestAreaHectares = json['forest_area(hectares)'];
    population2017 = json['population(2017)'];
    sqareMetersPerCapita = json['sqare_meters_per_capita'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rank'] = this.rank;
    data['country'] = this.country;
    data['forest_area(hectares)'] = this.forestAreaHectares;
    data['population(2017)'] = this.population2017;
    data['sqare_meters_per_capita'] = this.sqareMetersPerCapita;
    data['id'] = this.id;
    return data;
  }
}
