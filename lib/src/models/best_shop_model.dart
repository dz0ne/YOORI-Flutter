class BestShopModel {
  BestShopModel({
      this.success, 
      this.message, 
      required this.data,});

  BestShopModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  late final List<Data> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['data'] = data.map((v) => v.toJson()).toList();
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.slug, 
      this.title, 
      this.shopName, 
      this.ratingCount, 
      this.reviewsCount, 
      this.logo, 
      this.banner, 
      this.image90x60, 
      this.image82x82, 
      this.image617x145,
    this.isFollowed,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    shopName = json['shop_name'];
    ratingCount = json['rating_count'];
    reviewsCount = json['reviews_count'];
    logo = json['logo'];
    banner = json['banner'];
    image90x60 = json['image_90x60'];
    image82x82 = json['image_82x82'];
    image617x145 = json['image_617x145'];
    isFollowed = json['is_followed'];
  }
  int? id;
  String? slug;
  String? title;
  String? shopName;
  dynamic ratingCount;
  int? reviewsCount;
  String? logo;
  String? banner;
  String? image90x60;
  String? image82x82;
  String? image617x145;
  bool? isFollowed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['slug'] = slug;
    map['title'] = title;
    map['shop_name'] = shopName;
    map['rating_count'] = ratingCount;
    map['reviews_count'] = reviewsCount;
    map['logo'] = logo;
    map['banner'] = banner;
    map['image_90x60'] = image90x60;
    map['image_82x82'] = image82x82;
    map['image_617x145'] = image617x145;
    map['is_followed'] = isFollowed;
    return map;
  }

}