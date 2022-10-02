class AddToCartModel {
  AddToCartModel({
      this.success, 
      this.message, 
      this.data,});

  AddToCartModel.fromJson(dynamic json) {
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
      this.trxId,});

  Data.fromJson(dynamic json) {
    trxId = json['trx_id'];
  }
  String? trxId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['trx_id'] = trxId;
    return map;
  }

}