class BestSellingProductsModel {
  BestSellingProductsModel({
    this.success,
    this.message,
    required this.data,
  });

  BestSellingProductsModel.fromJson(dynamic json) {
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
    this.isNew,
    this.minimumOrderQuantity,
    this.isFavourite,
  });

  Data.fromJson(dynamic json) {
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
    isNew = json['is_new'];
    minimumOrderQuantity = json['minimum_order_quantity'];
    isFavourite = json['is_favourite'];
  }
  int? id;
  String? slug;
  String? title;
  String? shortDescription;
  String? specialDiscountType;
  String? specialDiscount;
  dynamic discountPrice;
  dynamic formattedPrice;
  dynamic formattedDiscount;
  String? image;
  String? price;
  dynamic rating;
  int? totalReviews;
  int? currentStock;
  int? reward;
  bool? isNew;
  int? minimumOrderQuantity;
  bool? isFavourite;

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
    map['is_new'] = isNew;
    map['minimum_order_quantity'] = minimumOrderQuantity;
    map['is_favourite'] = isFavourite;
    return map;
  }
}
