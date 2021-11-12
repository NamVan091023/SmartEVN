

class SimpleResult {
  int errorCode;
  String message;

  SimpleResult(this.errorCode, this.message);

  SimpleResult.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['message'] = this.message;
    return data;
  }

}