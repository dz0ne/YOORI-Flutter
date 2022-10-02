class ForgetPasswordModel {
  ForgetPasswordModel({
      this.success, 
      this.message, 
      this.data,});

  ForgetPasswordModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.email, 
      this.code,});

  Data.fromJson(dynamic json) {
    email = json['email'];
    code = json['code'];
  }
  String? email;
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['code'] = code;
    return map;
  }

}