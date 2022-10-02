class VisitShopModel {
  bool? success;
  String? message;
  Data? data;

  VisitShopModel({this.success, this.message, this.data});

  VisitShopModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Shop? shop;
  List<Coupons>? coupons;
  List<Products>? products;
  List<Store>? store;

  Data({this.shop, this.coupons, this.products, this.store});

  Data.fromJson(Map<String, dynamic> json) {
    shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
    if (json['coupons'] != null) {
      coupons = <Coupons>[];
      json['coupons'].forEach((v) {
        coupons!.add(Coupons.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    if (json['store'] != null) {
      store = <Store>[];
      json['store'].forEach((v) {
        store!.add(Store.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shop != null) {
      data['shop'] = shop!.toJson();
    }
    if (coupons != null) {
      data['coupons'] = coupons!.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (store != null) {
      data['store'] = store!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shop {
  int? id;
  String? image82x82;
  String? image1905x350;
  String? shopName;
  dynamic ratingCount;
  int? reviewsCount;

  Shop({
    this.id,
    this.image82x82,
    this.image1905x350,
    this.shopName,
    this.ratingCount,
    this.reviewsCount,
  });

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image82x82 = json['image_82x82'];
    image1905x350 = json['image_1905x350'];
    shopName = json['shop_name'];
    ratingCount = json['rating_count'];
    reviewsCount = json['reviews_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_82x82'] = image82x82;
    data['image_1905x350'] = image1905x350;
    data['shop_name'] = shopName;
    data['rating_count'] = ratingCount;
    data['reviews_count'] = reviewsCount;
    return data;
  }
}

class Coupons {
  int? id;
  String? title;
  String? code;
  String? discountType;
  dynamic discount;
  String? image145x110;

  Coupons(
      {this.id,
      this.title,
      this.code,
      this.discountType,
      this.discount,
      this.image145x110});

  Coupons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    discountType = json['discount_type'];
    discount = json['discount'];
    image145x110 = json['image_145x110'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['code'] = code;
    data['discount_type'] = discountType;
    data['discount'] = discount;
    data['image_145x110'] = image145x110;
    return data;
  }
}

class Products {
  int? id;
  String? slug;
  String? title;
  String? specialDiscountType;
  String? specialDiscount;
  String? discountPrice;
  dynamic formattedPrice;
  dynamic formattedDiscount;
  String? image;
  String? price;
  dynamic rating;
  int? reviewsCount;
  int? currentStock;
  int? reward;
  bool? isNew;
  int? minimumOrderQuantity;
  bool? isFavourite;

  Products(
      {this.id,
      this.slug,
      this.title,
      this.specialDiscountType,
      this.specialDiscount,
      this.discountPrice,
      this.formattedPrice,
      this.formattedDiscount,
      this.image,
      this.price,
      this.rating,
      this.reviewsCount,
      this.currentStock,
      this.reward,
      this.isNew,
      this.minimumOrderQuantity,
      this.isFavourite});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    specialDiscountType = json['special_discount_type'];
    specialDiscount = json['special_discount'];
    discountPrice = json['discount_price'];
    formattedPrice = json['formatted_price'];
    formattedDiscount = json['formatted_discount'];
    image = json['image'];
    price = json['price'];
    rating = json['rating'];
    reviewsCount = json['reviews_count'];
    currentStock = json['current_stock'];
    reward = json['reward'];
    isNew = json['is_new'];
    minimumOrderQuantity = json['minimum_order_quantity'];
    isFavourite = json['is_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['title'] = title;
    data['special_discount_type'] = specialDiscountType;
    data['special_discount'] = specialDiscount;
    data['discount_price'] = discountPrice;
    data['formatted_price'] = formattedPrice;
    data['formatted_discount'] = formattedDiscount;
    data['image'] = image;
    data['price'] = price;
    data['rating'] = rating;
    data['reviews_count'] = reviewsCount;
    data['current_stock'] = currentStock;
    data['reward'] = reward;
    data['is_new'] = isNew;
    data['minimum_order_quantity'] = minimumOrderQuantity;
    data['is_favourite'] = isFavourite;
    return data;
  }
}

class Store {
  String? sectionType;
  String? title;
  List<Products>? products;

  Store({this.sectionType, this.title, this.products});

  Store.fromJson(Map<String, dynamic> json) {
    sectionType = json['section_type'];
    title = json['title'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['section_type'] = sectionType;
    data['title'] = title;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
