class CampaignDetailsModel {
  CampaignDetailsModel({
    this.success,
    this.message,
    this.data,
  });

  CampaignDetailsModel.fromJson(dynamic json) {
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
    this.campaign,
    this.brands,
    this.shops,
    this.products,
  });

  Data.fromJson(dynamic json) {
    campaign =
        json['campaign'] != null ? Campaign.fromJson(json['campaign']) : null;
    if (json['brands'] != null) {
      brands = [];
      json['brands'].forEach((v) {
        brands?.add(Brands.fromJson(v));
      });
    }
    if (json['shops'] != null) {
      shops = [];
      json['shops'].forEach((v) {
        shops?.add(Shops.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
  }
  Campaign? campaign;
  List<Brands>? brands;
  List<Shops>? shops;
  List<Products>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (campaign != null) {
      map['campaign'] = campaign?.toJson();
    }
    if (brands != null) {
      map['brands'] = brands?.map((v) => v.toJson()).toList();
    }
    if (shops != null) {
      map['shops'] = shops?.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Products {
  Products({
    this.id,
    this.slug,
    this.title,
    this.shortDescription,
    this.specialDiscountType,
    this.specialDiscount,
    this.discountPrice,
    this.formattedPrice,
    this.formattedDiscount,
    this.image,
    this.price,
    this.rating,
    this.totalReviews,
    this.currentStock,
    this.reward,
    this.minimumOrderQuantity,
    this.isFavourite,
    this.isNew,
  });

  Products.fromJson(dynamic json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    shortDescription = json['short_description'];
    specialDiscountType = json['special_discount_type'];
    specialDiscount = json['special_discount'];
    discountPrice = json['discount_price'];
    formattedPrice = json['formatted_price'];
    formattedDiscount = json['formatted_discount'];
    image = json['image'];
    price = json['price'];
    rating = json['rating'];
    totalReviews = json['total_reviews'];
    currentStock = json['current_stock'];
    reward = json['reward'];
    minimumOrderQuantity = json['minimum_order_quantity'];
    isFavourite = json['is_favourite'];
    isNew = json['is_new'];
  }
  int? id;
  String? slug;
  String? title;
  String? shortDescription;
  String? specialDiscountType;
  String? specialDiscount;
  String? discountPrice;
  dynamic formattedPrice;
  dynamic formattedDiscount;
  String? image;
  String? price;
  dynamic rating;
  int? totalReviews;
  int? currentStock;
  int? reward;
  int? minimumOrderQuantity;
  bool? isFavourite;
  bool? isNew;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['slug'] = slug;
    map['title'] = title;
    map['short_description'] = shortDescription;
    map['special_discount_type'] = specialDiscountType;
    map['special_discount'] = specialDiscount;
    map['discount_price'] = discountPrice;
    map['formatted_price'] = formattedPrice;
    map['formatted_discount'] = formattedDiscount;
    map['image'] = image;
    map['price'] = price;
    map['rating'] = rating;
    map['total_reviews'] = totalReviews;
    map['current_stock'] = currentStock;
    map['reward'] = reward;
    map['minimum_order_quantity'] = minimumOrderQuantity;
    map['is_favourite'] = isFavourite;
    map['is_new'] = isNew;
    return map;
  }
}

class Shops {
  Shops({
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
    this.totalProduct,
    this.joinDate,
  });

  Shops.fromJson(dynamic json) {
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
    totalProduct = json['total_products'];
    joinDate = json['join_date'];
  }
  int? id;
  String? slug;
  dynamic title;
  String? shopName;
  dynamic ratingCount;
  int? reviewsCount;
  String? logo;
  String? banner;
  String? image90x60;
  String? image82x82;
  String? image617x145;
  bool? isFollowed;
  int? totalProduct;
  String? joinDate;

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
    map['total_products'] = totalProduct;
    map['join_date'] = joinDate;
    return map;
  }
}

class Brands {
  Brands({
    this.id,
    this.slug,
    this.title,
    this.thumbnail,
  });

  Brands.fromJson(dynamic json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    thumbnail = json['thumbnail'];
  }
  int? id;
  String? slug;
  String? title;
  String? thumbnail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['slug'] = slug;
    map['title'] = title;
    map['thumbnail'] = thumbnail;
    return map;
  }
}

class Campaign {
  Campaign({
    this.id,
    this.slug,
    this.title,
    this.shortDescription,
    this.startDate,
    this.endDate,
    this.banner,
  });

  Campaign.fromJson(dynamic json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    shortDescription = json['short_description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    banner = json['banner'];
  }
  int? id;
  String? slug;
  String? title;
  String? shortDescription;
  String? startDate;
  String? endDate;
  String? banner;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['slug'] = slug;
    map['title'] = title;
    map['short_description'] = shortDescription;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['banner'] = banner;
    return map;
  }
}
