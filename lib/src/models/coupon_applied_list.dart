class CouponAppliedList {
  CouponAppliedList({
    this.success,
    this.message,
    this.data,
  });

  CouponAppliedList.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.couponId,
    this.title,
    this.status,
    this.discountType,
    this.discount,
    this.couponDiscount,
  });

  Data.fromJson(dynamic json) {
    couponId = json['coupon_id'];
    title = json['title'];
    status = json['status'];
    discountType = json['discount_type'];
    discount = json['discount'];
    couponDiscount = json['coupon_discount'];
  }
  int? couponId;
  String? title;
  int? status;
  String? discountType;
  dynamic discount;
  int? couponDiscount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coupon_id'] = couponId;
    map['title'] = title;
    map['status'] = status;
    map['discount_type'] = discountType;
    map['discount'] = discount;
    map['coupon_discount'] = couponDiscount;
    return map;
  }
}
