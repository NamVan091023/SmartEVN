class TokenModel {
  String? token;
  String? expires;

  TokenModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expires'] = this.expires;
    return data;
  }
}

class TokensResponse {
  TokenModel? access;
  TokenModel? refresh;

  TokensResponse.fromJson(Map<String, dynamic> json) {
    access = TokenModel.fromJson(json['access']);
    refresh = TokenModel.fromJson(json['refresh']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access'] = this.access;
    data['refresh'] = this.refresh;
    return data;
  }
}
