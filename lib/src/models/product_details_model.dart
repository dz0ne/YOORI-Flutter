class ProductDetailsModel {
  bool? success;
  String? message;
  Data? data;

  ProductDetailsModel({this.success, this.message, this.data});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? specialDiscountType;
  String? details;
  dynamic specialDiscount;
  dynamic discountPrice;
  dynamic price;
  dynamic rating;
  int? totalReviews;
  int? currentStock;
  int? minimumOrderQuantity;
  int? reward;
  int? totalImages;
  List<String>? images;
  List<ColorsData>? colors;
  List<Attributes>? attributes;
  String? specialDiscountStart;
  String? specialDiscountEnd;
  String? description;
  bool isFavourite = false;
  String? shortDescription;
  bool? hasVariant;
  bool isWholesale = false;
  bool? isCatalog;
  bool? isFeatured;
  bool? isClassified;
  bool? isDigital;
  bool? isRefundable;
  String? specifications;
  List<Reviews>? reviews;
  bool? isReviewed;
  dynamic delivery;
  int returnData = 0;
  dynamic stockVisibility;
  List<WholesalePrices>? wholesalePrices;
  FormData? form;
  Links? links;

  ClassifiedContactInfo? classifiedContactInfo;
  String? catalogExternalLink;

  Data({
    this.title,
    this.details,
    this.specialDiscountType,
    this.specialDiscount,
    this.discountPrice,
    this.price,
    this.rating,
    this.totalReviews,
    this.currentStock,
    this.minimumOrderQuantity,
    this.reward,
    this.totalImages,
    this.images,
    this.colors,
    this.attributes,
    this.specialDiscountStart,
    this.specialDiscountEnd,
    this.description,
    required this.isFavourite,
    this.shortDescription,
    this.hasVariant,
    this.isWholesale = false,
    this.specifications,
    this.reviews,
    this.isReviewed,
    this.delivery,
    this.returnData = 0,
    this.stockVisibility,
    this.wholesalePrices,
    this.isCatalog,
    this.isClassified,
    this.isFeatured,
    this.isDigital,
    this.isRefundable,
    this.form,
    this.links,
    this.catalogExternalLink,
    this.classifiedContactInfo,
  });

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    details = json['details'];
    specialDiscountType = json['special_discount_type'];
    specialDiscount = json['special_discount'];
    discountPrice = json['discount_price'].toString();
    price = json['price'].toString();
    rating = json['rating'];
    totalReviews = json['total_reviews'];
    currentStock = json['current_stock'];
    minimumOrderQuantity = json['minimum_order_quantity'];
    reward = json['reward'];
    totalImages = json['total_images'];
    images = json['images'].cast<String>();
    if (json['colors'] != null) {
      colors = <ColorsData>[];
      json['colors'].forEach((v) {
        colors!.add(ColorsData.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
    specialDiscountStart = json['special_discount_start'];
    specialDiscountEnd = json['special_discount_end'];
    description = json['description'];
    isFavourite = json['is_favourite'] ?? false;
    shortDescription = json['short_description'];
    hasVariant = json['has_variant'];
    isWholesale = json['is_wholesale'];
    isCatalog = json['is_catalog'];
    isFeatured = json['is_featured'];
    isClassified = json['is_classified'];
    isDigital = json['is_digital'];
    isRefundable = json['is_refundable'];
    specifications = json['specifications'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    isReviewed = json['is_reviewed'];
    delivery = json['delivery'];
    returnData = json['return'];
    stockVisibility = json['stock_visibility'];
    if (json['wholesale_prices'] != null) {
      wholesalePrices = <WholesalePrices>[];
      json['wholesale_prices'].forEach((v) {
        wholesalePrices!.add(WholesalePrices.fromJson(v));
      });
    }
    // wholesalePrices = List.from(json['wholesale_prices'])
    //     .map((e) => WholesalePrices.fromJson(e))
    //     .toList();
    form = json['form'] != null ? FormData.fromJson(json['form']) : null;
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    classifiedContactInfo = json['classified_contact_info'] != null
        ? ClassifiedContactInfo.fromJson(json['classified_contact_info'])
        : null;
    catalogExternalLink = json['catalog_external_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['details'] = details;
    data['special_discount_type'] = specialDiscountType;
    data['special_discount'] = specialDiscount;
    data['discount_price'] = discountPrice;
    data['price'] = price;
    data['rating'] = rating;
    data['total_reviews'] = totalReviews;
    data['current_stock'] = currentStock;
    data['minimum_order_quantity'] = minimumOrderQuantity;
    data['reward'] = reward;
    data['total_images'] = totalImages;
    data['images'] = images;
    if (colors != null) {
      data['colors'] = colors!.map((v) => v.toJson()).toList();
    }
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    data['special_discount_start'] = specialDiscountStart;
    data['special_discount_end'] = specialDiscountEnd;
    data['description'] = description;
    data['is_favourite'] = isFavourite;
    data['short_description'] = shortDescription;
    data['has_variant'] = hasVariant;
    data['is_wholesale'] = isWholesale;
    data['is_catalog'] = isCatalog;
    data['is_featured'] = isFeatured;
    data['is_classified'] = isClassified;
    data['is_digital'] = isDigital;
    data['is_refundable'] = isRefundable;
    data['specifications'] = specifications;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (wholesalePrices != null) {
      data['wholesale_prices'] =
          wholesalePrices!.map((e) => e.toJson()).toList();
    }
    data['is_reviewed'] = isReviewed;
    data['delivery'] = delivery;
    data['return'] = returnData;
    data['stock_visibility'] = stockVisibility;
    if (form != null) {
      data['form'] = form!.toJson();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }

    if (classifiedContactInfo != null) {
      data['classified_contact_info'] = classifiedContactInfo!.toJson();
    }
    data['catalog_external_link'] = catalogExternalLink;
    return data;
  }
}

class WholesalePrices {
  WholesalePrices({
    required this.id,
    required this.productStockId,
    required this.minQty,
    required this.maxQty,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int productStockId;
  late final int minQty;
  late final int maxQty;
  late final String price;
  late final String createdAt;
  late final String updatedAt;

  WholesalePrices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productStockId = json['product_stock_id'];
    minQty = json['min_qty'];
    maxQty = json['max_qty'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['product_stock_id'] = productStockId;
    data['min_qty'] = minQty;
    data['max_qty'] = maxQty;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ColorsData {
  int? id;
  String? name;
  String? hexCode;

  ColorsData({this.id, this.name, this.hexCode});

  ColorsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hexCode = json['hex_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['hex_code'] = hexCode;
    return data;
  }
}

class Attributes {
  int? id;
  String? title;
  List<AttributeValue>? attributeValue;

  Attributes({this.id, this.title, this.attributeValue});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['attribute_value'] != null) {
      attributeValue = <AttributeValue>[];
      json['attribute_value'].forEach((v) {
        attributeValue!.add(AttributeValue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    if (attributeValue != null) {
      data['attribute_value'] = attributeValue!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttributeValue {
  int? id;
  int? attributeId;
  String? value;
  String? createdAt;
  String? updatedAt;

  AttributeValue(
      {this.id, this.attributeId, this.value, this.createdAt, this.updatedAt});

  AttributeValue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributeId = json['attribute_id'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['attribute_id'] = attributeId;
    data['value'] = value;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Reviews {
  int? id;
  dynamic rating;
  String? comment;
  String? title;
  String? date;
  int? totalLikes;
  int? totalReplies;
  List<Replies>? replies;
  bool? isLiked;
  User? user;
  String? image;

  Reviews(
      {this.id,
      this.rating,
      this.comment,
      this.title,
      this.date,
      this.totalLikes,
      this.totalReplies,
      this.replies,
      this.isLiked,
      this.user,
      this.image});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    comment = json['comment'];
    title = json['title'];
    date = json['date'];
    totalLikes = json['total_likes'];
    totalReplies = json['total_replies'];
    image = json['image'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(Replies.fromJson(v));
      });
    }
    isLiked = json['is_liked'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rating'] = rating;
    data['comment'] = comment;
    data['title'] = title;
    data['date'] = date;
    data['total_likes'] = totalLikes;
    data['total_replies'] = totalReplies;
    data['image'] = image;
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    data['is_liked'] = isLiked;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Replies {
  int? id;
  String? reply;
  String? date;
  User? user;

  Replies({this.id, this.reply, this.date, this.user});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reply = json['reply'];
    date = json['date'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reply'] = reply;
    data['date'] = date;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? image;

  User({this.id, this.name, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class FormData {
  int? productId;
  List<dynamic>? attributeValues;
  String? colorId;
  int? quantity;
  String? variantsIds;
  String? variantsName;

  FormData(
      {this.productId,
      this.attributeValues,
      this.colorId,
      this.quantity,
      this.variantsIds,
      this.variantsName});

  FormData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    attributeValues = json['attribute_values'];
    colorId = json['color_id'];
    quantity = json['quantity'];
    variantsIds = json['variants_ids'];
    variantsName = json['variants_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['attribute_values'] = attributeValues;
    data['color_id'] = colorId;
    data['quantity'] = quantity;
    data['variants_ids'] = variantsIds;
    data['variants_name'] = variantsName;
    return data;
  }
}

class Links {
  String? facebook;
  String? twitter;
  String? linkedin;
  String? whatsapp;

  Links({
    this.facebook,
    this.twitter,
    this.whatsapp,
    this.linkedin,
  });

  Links.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
    whatsapp = json['whatsapp'];
    linkedin = json['linkedin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    data['whatsapp'] = whatsapp;
    data['linkedin'] = linkedin;
    return data;
  }
}

class ClassifiedContactInfo {
  String? name;
  String? phone;
  String? email;
  String? address;
  String? others;

  ClassifiedContactInfo(
      {this.name, this.phone, this.email, this.address, this.others});

  ClassifiedContactInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    others = json['others'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['others'] = others;
    return data;
  }
}
