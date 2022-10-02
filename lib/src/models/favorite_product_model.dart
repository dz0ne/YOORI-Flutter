class FavouriteData {
  FavouriteData({
     this.success,
     this.message,
     this.data,
  });
  late final bool? success;
  late final String? message;
  late final Data? data;

  FavouriteData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{};
    jsonData['success'] = success;
    jsonData['message'] = message;
    jsonData['data'] = data!.toJson();
    return jsonData;
  }
}

class Data {
  Data({
    required this.favouriteShop,
    required this.favouriteProducts,
  });
  late final List<FavouriteShop> favouriteShop;
  late final List<FavouriteProducts> favouriteProducts;

  Data.fromJson(Map<String, dynamic> json) {
    favouriteShop = List.from(json['favourite_shop'])
        .map((e) => FavouriteShop.fromJson(e))
        .toList();
    favouriteProducts = List.from(json['favourite_products'])
        .map((e) => FavouriteProducts.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{};
    jsonData['favourite_shop'] = favouriteShop.map((e) => e.toJson()).toList();
    jsonData['favourite_products'] =
        favouriteProducts.map((e) => e.toJson()).toList();
    return jsonData;
  }
}

class FavouriteShop {
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
  int? totalProduct;
  String? joinDate;

  FavouriteShop({
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
    this.joinDate,
    this.totalProduct,
  });

  FavouriteShop.fromJson(Map<String, dynamic> json) {
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
    totalProduct = json['total_products'];
    joinDate = json['join_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['title'] = title;
    data['shop_name'] = shopName;
    data['rating_count'] = ratingCount;
    data['reviews_count'] = reviewsCount;
    data['logo'] = logo;
    data['banner'] = banner;
    data['image_90x60'] = image90x60;
    data['image_82x82'] = image82x82;
    data['image_617x145'] = image617x145;
    data['total_products'] = totalProduct;
    data['join_date'] = joinDate;
    return data;
  }
}

class FavouriteProducts {
  int? id;
  String? slug;
  String? title;
  String? shortDescription;
  String? specialDiscountType;
  String? specialDiscount;
  String? discountPrice;

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

  FavouriteProducts({
    this.id,
    this.slug,
    this.title,
    this.shortDescription,
    this.specialDiscountType,
    this.specialDiscount,
    this.discountPrice,
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

  FavouriteProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    shortDescription = json['short_description'];
    specialDiscountType = json['special_discount_type'];
    specialDiscount = json['special_discount'];
    discountPrice = json['discount_price'];
    
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['title'] = title;
    data['short_description'] = shortDescription;
    data['special_discount_type'] = specialDiscountType;
    data['special_discount'] = specialDiscount;
    data['discount_price'] = discountPrice;
    data['formatted_discount'] = formattedDiscount;
    data['image'] = image;
    data['price'] = price;
    data['rating'] = rating;
    data['total_reviews'] = totalReviews;
    data['current_stock'] = currentStock;
    data['reward'] = reward;
    data['minimum_order_quantity'] = minimumOrderQuantity;
    data['is_favourite'] = isFavourite;
    data['is_new'] = isNew;
    return data;
  }
}
