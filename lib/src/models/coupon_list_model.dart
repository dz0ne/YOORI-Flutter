class CouponListModel {
  CouponListModel({
      this.success, 
      this.message, 
      this.data,});

  CouponListModel.fromJson(dynamic json) {
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
      this.coupons,});

  Data.fromJson(dynamic json) {
    if (json['coupons'] != null) {
      coupons = [];
      json['coupons'].forEach((v) {
        coupons?.add(Coupons.fromJson(v));
      });
    }
  }
  List<Coupons>? coupons;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (coupons != null) {
      map['coupons'] = coupons?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Coupons {
  Coupons({
      this.id, 
      this.title, 
      this.code, 
      this.discountType, 
      this.discount, 
      this.image145x110,
    this.endTime,

  });

  Coupons.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    discountType = json['discount_type'];
    discount = json['discount'];
    image145x110 = json['image_145x110'];
    endTime = json['end_time'];
  }
  int? id;
  String? title;
  String? code;
  String? discountType;
  int? discount;
  String? image145x110;
  String? endTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['code'] = code;
    map['discount_type'] = discountType;
    map['discount'] = discount;
    map['image_145x110'] = image145x110;
    map['end_time'] = endTime;
    return map;
  }

}