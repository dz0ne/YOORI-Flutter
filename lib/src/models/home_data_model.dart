class HomeDataModel {
  bool? success;
  String? message;
  List<Data>? data;

  HomeDataModel({this.success, this.message, this.data});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? icon;
  int? parentId;
  String? slug;
  String? title;
  String? image;

  Categories({
    this.id,
    this.icon,
    this.parentId,
    this.slug,
    this.title,
    this.image,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    parentId = json['parent_id'];
    slug = json['slug'];
    title = json['title'] ?? "No Title";
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['icon'] = icon;
    data['parent_id'] = parentId;
    data['slug'] = slug;
    data['title'] = title;
    data['image'] = image;
    return data;
  }
}

class Data {
  String? sectionType;
  List<Slider>? slider;
  List<Benefits>? benefits;
  List<Categories>? categories;
  List<Banners>? banners;
  List<Campaigns>? campaigns;
  List<PopularCategories>? popularCategories;
  List<TopCategories>? topCategories;
  List<TodayDeals>? todayDeals;
  List<FlashDeals>? flashDeals;
  String? categorySecBanner;
  String? categorySecBannerUrl;
  CategorySection? categorySection;
  List<BestSellingProducts>? bestSellingProducts;
  List<OfferEnding>? offerEnding;
  String? offerEndingBanner;
  String? offerEndingBannerUrl;
  List<LatestProducts>? latestProducts;
  List<LatestNews>? latestNews;
  List<PopularBrands>? popularBrands;
  List<TopShops>? topShops;
  List<FeaturedShops>? featuredShops;
  List<BestShops>? bestShops;
  List<ExpressShops>? expressShops;
  List<RecentViewedProduct>? recentViewedProduct;
  bool? subscriptionSection;

  Data({
    this.sectionType,
    this.slider,
    this.benefits,
    this.banners,
    this.campaigns,
    this.popularCategories,
    this.topCategories,
    this.todayDeals,
    this.flashDeals,
    this.categorySecBanner,
    this.categorySecBannerUrl,
    this.categorySection,
    this.bestSellingProducts,
    this.offerEnding,
    this.offerEndingBanner,
    this.offerEndingBannerUrl,
    this.latestProducts,
    this.latestNews,
    this.popularBrands,
    this.topShops,
    this.featuredShops,
    this.bestShops,
    this.expressShops,
    this.recentViewedProduct,
    this.subscriptionSection,
    this.categories,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sectionType = json['section_type'];

    if (sectionType == 'slider') {
      if (json['slider'] != null) {
        slider = <Slider>[];
        json['slider'].forEach((v) {
          slider!.add(Slider.fromJson(v));
        });
      }
    } else if (sectionType == 'categories') {
      if (json['categories'] != null) {
        categories = <Categories>[];
        json['categories'].forEach((v) {
          categories!.add(Categories.fromJson(v));
        });
      }
    } else if (sectionType == 'benefits') {
      if (json['benefits'] != null) {
        benefits = <Benefits>[];
        json['benefits'].forEach((v) {
          benefits!.add(Benefits.fromJson(v));
        });
      }
    } else if (sectionType == 'banners') {
      if (json['banners'] != null) {
        banners = <Banners>[];
        json['banners'].forEach((v) {
          banners!.add(Banners.fromJson(v));
        });
      }
    } else if (sectionType == 'campaigns') {
      if (json['campaigns'] != null) {
        campaigns = <Campaigns>[];
        json['campaigns'].forEach((v) {
          campaigns!.add(Campaigns.fromJson(v));
        });
      }
    } else if (sectionType == 'popular_categories') {
      if (json['popular_categories'] != null) {
        popularCategories = <PopularCategories>[];
        json['popular_categories'].forEach((v) {
          popularCategories!.add(PopularCategories.fromJson(v));
        });
      }
    } else if (sectionType == 'top_categories') {
      if (json['top_categories'] != null) {
        topCategories = <TopCategories>[];
        json['top_categories'].forEach((v) {
          topCategories!.add(TopCategories.fromJson(v));
        });
      }
    } else if (sectionType == 'today_deals') {
      if (json['today_deals'] != null) {
        todayDeals = <TodayDeals>[];
        json['today_deals'].forEach((v) {
          todayDeals!.add(TodayDeals.fromJson(v));
        });
      }
    } else if (sectionType == 'flash_deals') {
      if (json['flash_deals'] != null) {
        flashDeals = <FlashDeals>[];
        json['flash_deals'].forEach((v) {
          flashDeals!.add(FlashDeals.fromJson(v));
        });
      }
    } else if (sectionType == 'best_selling_products') {
      if (json['best_selling_products'] != null) {
        bestSellingProducts = <BestSellingProducts>[];
        json['best_selling_products'].forEach((v) {
          bestSellingProducts!.add(BestSellingProducts.fromJson(v));
        });
      }
    } else if (sectionType == 'offer_ending') {
      if (json['offer_ending'] != null) {
        offerEnding = <OfferEnding>[];
        json['offer_ending'].forEach((v) {
          offerEnding!.add(OfferEnding.fromJson(v));
        });
      }
    } else if (sectionType == 'latest_products') {
      if (json['latest_products'] != null) {
        latestProducts = <LatestProducts>[];
        json['latest_products'].forEach((v) {
          latestProducts!.add(LatestProducts.fromJson(v));
        });
      }
    } else if (sectionType == 'latest_news') {
      if (json['latest_news'] != null) {
        latestNews = <LatestNews>[];
        json['latest_news'].forEach((v) {
          latestNews!.add(LatestNews.fromJson(v));
        });
      }
    } else if (sectionType == 'popular_brands') {
      if (json['popular_brands'] != null) {
        popularBrands = <PopularBrands>[];
        json['popular_brands'].forEach((v) {
          popularBrands!.add(PopularBrands.fromJson(v));
        });
      }
    } else if (sectionType == 'top_shops') {
      if (json['top_shops'] != null) {
        topShops = <TopShops>[];
        json['top_shops'].forEach((v) {
          topShops!.add(TopShops.fromJson(v));
        });
      }
    } else if (sectionType == 'featured_shops') {
      if (json['featured_shops'] != null) {
        featuredShops = <FeaturedShops>[];
        json['featured_shops'].forEach((v) {
          featuredShops!.add(FeaturedShops.fromJson(v));
        });
      }
    } else if (sectionType == 'best_shops') {
      if (json['best_shops'] != null) {
        bestShops = <BestShops>[];
        json['best_shops'].forEach((v) {
          bestShops!.add(BestShops.fromJson(v));
        });
      }
    } else if (sectionType == 'express_shops') {
      if (json['express_shops'] != null) {
        expressShops = <ExpressShops>[];
        json['express_shops'].forEach((v) {
          expressShops!.add(ExpressShops.fromJson(v));
        });
      }
    } else if (sectionType == 'recent_viewed_product') {
      if (json['recent_viewed_product'] != null) {
        recentViewedProduct = <RecentViewedProduct>[];
        json['recent_viewed_product'].forEach((v) {
          recentViewedProduct!.add(RecentViewedProduct.fromJson(v));
        });
      }
    }

    categorySecBanner = json['category_sec_banner'];
    categorySecBannerUrl = json['category_sec_banner_url'];
    categorySection = json['category_section'] != null
        ? CategorySection.fromJson(json['category_section'])
        : null;
    offerEndingBanner = json['offer_ending_banner'];
    offerEndingBannerUrl = json['offer_ending_banner_url'];

    subscriptionSection = json['subscription_section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['section_type'] = sectionType;
    if (slider != null) {
      data['slider'] = slider!.map((v) => v.toJson()).toList();
    }
    if (benefits != null) {
      data['benefits'] = benefits!.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (banners != null) {
      data['banners'] = banners!.map((v) => v.toJson()).toList();
    }
    if (campaigns != null) {
      data['campaigns'] = campaigns!.map((v) => v.toJson()).toList();
    }
    if (popularCategories != null) {
      data['popular_categories'] =
          popularCategories!.map((v) => v.toJson()).toList();
    }
    if (topCategories != null) {
      data['top_categories'] = topCategories!.map((v) => v.toJson()).toList();
    }
    if (todayDeals != null) {
      data['today_deals'] = todayDeals!.map((v) => v.toJson()).toList();
    }
    if (flashDeals != null) {
      data['flash_products'] = flashDeals!.map((v) => v.toJson()).toList();
    }
    data['category_sec_banner'] = categorySecBanner;
    data['category_sec_banner_url'] = categorySecBannerUrl;
    if (categorySection != null) {
      data['category_section'] = categorySection!.toJson();
    }
    if (bestSellingProducts != null) {
      data['best_selling_products'] =
          bestSellingProducts!.map((v) => v.toJson()).toList();
    }
    if (offerEnding != null) {
      data['offer_ending'] = offerEnding!.map((v) => v.toJson()).toList();
    }
    data['offer_ending_banner'] = offerEndingBanner;
    data['offer_ending_banner_url'] = offerEndingBannerUrl;
    if (latestProducts != null) {
      data['latest_products'] = latestProducts!.map((v) => v.toJson()).toList();
    }
    if (latestNews != null) {
      data['latest_news'] = latestNews!.map((v) => v.toJson()).toList();
    }
    if (popularBrands != null) {
      data['popular_brands'] = popularBrands!.map((v) => v.toJson()).toList();
    }
    if (topShops != null) {
      data['top_shops'] = topShops!.map((v) => v.toJson()).toList();
    }
    if (featuredShops != null) {
      data['featured_shops'] = featuredShops!.map((v) => v.toJson()).toList();
    }
    if (bestShops != null) {
      data['best_shops'] = bestShops!.map((v) => v.toJson()).toList();
    }
    if (expressShops != null) {
      data['express_shops'] = expressShops!.map((v) => v.toJson()).toList();
    }
    if (recentViewedProduct != null) {
      data['recent_viewed_product'] =
          recentViewedProduct!.map((v) => v.toJson()).toList();
    }
    data['subscription_section'] = subscriptionSection;
    return data;
  }
}

class BestShops {
  int? id;
  String? slug;
  String? logo;
  String? banner;
  dynamic rating;
  dynamic totalReviews;
  String? shopName;
  bool? isFollowed;
  List<Products>? products;

  BestShops(
      {this.id,
      this.slug,
      this.logo,
      this.banner,
      this.rating,
      this.totalReviews,
      this.shopName,
        this.isFollowed,
      this.products});

  BestShops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    logo = json['logo'];
    banner = json['banner'];
    rating = json['rating'];
    totalReviews = json['total_reviews'];
    shopName = json['shop_name'];
    isFollowed = json['is_followed'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['logo'] = logo;
    data['banner'] = banner;
    data['rating'] = rating;
    data['total_reviews'] = totalReviews;
    data['shop_name'] = shopName;
    data['is_followed'] = isFollowed;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExpressShops {
  int? id;
  String? slug;
  String? logo;
  String? banner;
  dynamic rating;
  dynamic totalReviews;
  String? shopName;
  bool? isFollowed;


  ExpressShops(
      {this.id,
      this.slug,
      this.logo,
      this.banner,
      this.rating,
      this.totalReviews,
      this.shopName,
        this.isFollowed,
      });

  ExpressShops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    logo = json['logo'];
    banner = json['banner'];
    rating = json['rating'];
    totalReviews = json['total_reviews'];
    shopName = json['shop_name'];
    isFollowed = json['is_followed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['logo'] = logo;
    data['banner'] = banner;
    data['rating'] = rating;
    data['total_reviews'] = totalReviews;
    data['shop_name'] = shopName;
    data['is_followed'] = isFollowed;
    return data;
  }
}

class RecentViewedProduct {
  int? id;
  String? slug;
  String? title;
  String? shortDescription;
  String? specialDiscountType;
  String? specialDiscount;
  String? discountPrice;
  String? image;
  String? price;
  int? rating;
  int? totalReviews;
  int? currentStock;
  int? reward;
  int? minimumOrderQuantity;
  bool? isNew;

  RecentViewedProduct({
    this.id,
    this.slug,
    this.title,
    this.shortDescription,
    this.specialDiscountType,
    this.specialDiscount,
    this.discountPrice,
    this.image,
    this.price,
    this.rating,
    this.totalReviews,
    this.currentStock,
    this.reward,
    this.minimumOrderQuantity,
    this.isNew,
  });

  RecentViewedProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    shortDescription = json['short_description'];
    specialDiscountType = json['special_discount_type'];
    specialDiscount = json['special_discount'];
    discountPrice = json['discount_price'];
    image = json['image'];
    price = json['price'];
    rating = json['rating'];
    totalReviews = json['total_reviews'];
    currentStock = json['current_stock'];
    reward = json['reward'];
    minimumOrderQuantity = json['minimum_order_quantity'];
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
    data['image'] = image;
    data['price'] = price;
    data['rating'] = rating;
    data['total_reviews'] = totalReviews;
    data['current_stock'] = currentStock;
    data['reward'] = reward;
    data['minimum_order_quantity'] = minimumOrderQuantity;
    data['is_new'] = isNew;
    return data;
  }
}

class Products {
  int? id;
  String? slug;
  String? title;
  String? shortDescription;
  String? specialDiscountType;
  String? specialDiscount;
  String? discountPrice;
  String? image;
  String? price;
  int? rating;
  int? totalReviews;
  int? currentStock;
  int? reward;
  int? minimumOrderQuantity;

  Products({
    this.id,
    this.slug,
    this.title,
    this.shortDescription,
    this.specialDiscountType,
    this.specialDiscount,
    this.discountPrice,
    this.image,
    this.price,
    this.rating,
    this.totalReviews,
    this.currentStock,
    this.reward,
    this.minimumOrderQuantity,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    shortDescription = json['short_description'];
    specialDiscountType = json['special_discount_type'];
    specialDiscount = json['special_discount'];
    discountPrice = json['discount_price'];
    image = json['image'];
    price = json['price'];
    rating = json['rating'];
    totalReviews = json['total_reviews'];
    currentStock = json['current_stock'];
    reward = json['reward'];
    minimumOrderQuantity = json['minimum_order_quantity'];
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
    data['image'] = image;
    data['price'] = price;
    data['rating'] = rating;
    data['total_reviews'] = totalReviews;
    data['current_stock'] = currentStock;
    data['reward'] = reward;
    data['minimum_order_quantity'] = minimumOrderQuantity;
    return data;
  }
}

class LatestProducts {
  int? id;
  String? slug;
  String? title;
  String? shortDescription;
  String? specialDiscountType;
  String? specialDiscount;
  dynamic discountPrice;
  String? image;
  dynamic price;
  int? rating;
  int? totalReviews;
  int? currentStock;
  int? reward;
  int? minimumOrderQuantity;
  bool? isFavourite;
  bool? isNew;

  LatestProducts({
    this.id,
    this.slug,
    this.title,
    this.shortDescription,
    this.specialDiscountType,
    this.specialDiscount,
    this.discountPrice,
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

  LatestProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    shortDescription = json['short_description'];
    specialDiscountType = json['special_discount_type'];
    specialDiscount = json['special_discount'];
    discountPrice = json['discount_price'];
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

class OfferEnding {
  int? id;
  String? slug;
  String? title;
  String? shortDescription;
  dynamic specialDiscountType;
  String? specialDiscount;
  dynamic discountPrice;
  String? image;
  dynamic price;
  dynamic rating;
  int? totalReviews;
  int? currentStock;
  int? reward;
  int? minimumOrderQuantity;
  bool? isFavourite;
  bool? isNew;

  OfferEnding({
    this.id,
    this.slug,
    this.title,
    this.shortDescription,
    this.specialDiscountType,
    this.specialDiscount,
    this.discountPrice,
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

  OfferEnding.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    shortDescription = json['short_description'];
    specialDiscountType = json['special_discount_type'];
    specialDiscount = json['special_discount'];
    discountPrice = json['discount_price'];
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

class BestSellingProducts {
  int? id;
  String? slug;
  String? title;
  String? shortDescription;
  String? specialDiscountType;
  String? specialDiscount;
  dynamic discountPrice;
  String? image;
  dynamic price;
  dynamic rating;
  int? totalReviews;
  int? currentStock;
  int? reward;
  int? minimumOrderQuantity;
  bool? isFavourite;
  bool? isNew;

  BestSellingProducts({
    this.id,
    this.slug,
    this.title,
    this.shortDescription,
    this.specialDiscountType,
    this.specialDiscount,
    this.discountPrice,
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

  BestSellingProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    shortDescription = json['short_description'];
    specialDiscountType = json['special_discount_type'];
    specialDiscount = json['special_discount'];
    discountPrice = json['discount_price'];
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

class TopCategories {
  int? id;
  String? icon;
  dynamic parentId;
  String? slug;
  String? title;
  String? image;

  TopCategories({
    this.id,
    this.icon,
    this.parentId,
    this.slug,
    this.title,
    this.image,
  });

  TopCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    parentId = json['parent_id'];
    slug = json['slug'];
    title = json['title'] ?? "No Title";
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['icon'] = icon;
    data['parent_id'] = parentId;
    data['slug'] = slug;
    data['title'] = title;
    data['image'] = image;
    return data;
  }
}

class Slider {
  int? id;
  String? title;
  String? url;
  String? backgroundImage;
  String? banner;
  String? actionType;
  dynamic actionTo;

  Slider(
      {this.id,
      this.title,
      this.url,
      this.backgroundImage,
      this.banner,
      this.actionTo,
      this.actionType});

  Slider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    backgroundImage = json['background_image'];

    banner = json['banner'];
    actionTo = json['action_to'];
    actionType = json['action_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['background_image'] = backgroundImage;

    data['banner'] = banner;
    data['action_to'] = actionTo;
    data['action_type'] = actionType;
    return data;
  }
}

class Benefits {
  int? id;
  String? title;
  String? subTile;
  String? image;

  Benefits({this.id, this.title, this.subTile, this.image});

  Benefits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTile = json['sub_tile'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['sub_tile'] = subTile;
    data['image'] = image;
    return data;
  }
}

class Banners {
  String? thumbnail;
  String? actionType;
  String? actionTo;
  String? actionId;

  Banners({this.thumbnail, this.actionTo,this.actionType,this.actionId});

  Banners.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    actionType = json['action_type'];
    actionTo = json['action_to'];
    actionId = json['action_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thumbnail'] = thumbnail;
    data['action_type'] = actionType;
    data['action_to'] = actionTo;
    data['action_id'] = actionId;
    return data;
  }
}

class Campaigns {
  int? id;
  String? slug;
  String? title;
  String? shortDescription;
  String? startDate;
  String? endDate;
  String? banner;

  Campaigns(
      {this.id,
      this.slug,
      this.title,
      this.shortDescription,
      this.startDate,
      this.endDate,
      this.banner});

  Campaigns.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    shortDescription = json['short_description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    banner = json['banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['title'] = title;
    data['short_description'] = shortDescription;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['banner'] = banner;
    return data;
  }
}

class PopularCategories {
  int? id;
  String? icon;
  dynamic parentId;
  String? slug;
  String? title;
  String? image;

  PopularCategories({
    this.id,
    this.icon,
    this.parentId,
    this.slug,
    this.title,
    this.image,
  });

  PopularCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    parentId = json['parent_id'];
    slug = json['slug'];
    title = json['title'] ?? "No Title";
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['icon'] = icon;
    data['parent_id'] = parentId;
    data['slug'] = slug;
    data['title'] = title;
    data['image'] = image;
    return data;
  }
}

class TodayDeals {
  int? id;
  String? slug;
  String? title;
  String? shortDescription;
  String? specialDiscountType;
  String? specialDiscount;
  dynamic discountPrice;
  String? image;
  dynamic price;
  dynamic rating;
  int? totalReviews;
  int? currentStock;
  int? reward;
  int? minimumOrderQuantity;
  bool? isFavourite;
  bool? isNew;

  TodayDeals({
    this.id,
    this.slug,
    this.title,
    this.shortDescription,
    this.specialDiscountType,
    this.specialDiscount,
    this.discountPrice,
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

  TodayDeals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    shortDescription = json['short_description'];
    specialDiscountType = json['special_discount_type'];
    specialDiscount = json['special_discount'];
    discountPrice = json['discount_price'];
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

class FlashDeals {
  int? id;
  String? slug;
  String? title;
  String? shortDescription;
  String? specialDiscountType;
  String? specialDiscount;
  dynamic discountPrice;
  String? image;
  dynamic price;
  dynamic rating;
  int? totalReviews;
  int? currentStock;
  int? reward;
  int? minimumOrderQuantity;
  bool? isFavourite;
  bool? isNew;

  FlashDeals({
    this.id,
    this.slug,
    this.title,
    this.shortDescription,
    this.specialDiscountType,
    this.specialDiscount,
    this.discountPrice,
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

  FlashDeals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    shortDescription = json['short_description'];
    specialDiscountType = json['special_discount_type'];
    specialDiscount = json['special_discount'];
    discountPrice = json['discount_price'];
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

class CategorySection {
  int? id;
  String? slug;
  String? title;
  List<Products>? products;

  CategorySection({
    this.id,
    this.slug,
    this.title,
    this.products,
  });

  CategorySection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
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
    data['id'] = id;
    data['slug'] = slug;
    data['title'] = title;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LatestNews {
  int? id;
  String? slug;
  String? title;
  String? shortDescription;
  String? thumbnail;
  String? url;

  LatestNews({
    this.id,
    this.slug,
    this.title,
    this.shortDescription,
    this.thumbnail,
    this.url,
  });

  LatestNews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    shortDescription = json['short_description'];
    thumbnail = json['thumbnail'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['title'] = title;
    data['short_description'] = shortDescription;
    data['thumbnail'] = thumbnail;
    data['url'] = url;
    return data;
  }
}

class PopularBrands {
  int? id;
  String? slug;
  String? title;
  String? thumbnail;

  PopularBrands({this.id, this.slug, this.title, this.thumbnail});

  PopularBrands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    return data;
  }
}

class TopShops {
  int? id;
  String? slug;
  String? logo;
  String? banner;
  dynamic rating;
  dynamic totalReviews;
  String? shopName;
  bool? isFollowed;

  TopShops({
    this.id,
    this.slug,
    this.logo,
    this.banner,
    this.rating,
    this.totalReviews,
    this.shopName,
    this.isFollowed,
  });

  TopShops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    logo = json['logo'];
    banner = json['banner'];
    rating = json['rating'];
    totalReviews = json['total_reviews'];
    shopName = json['shop_name'];
    isFollowed = json['is_followed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['logo'] = logo;
    data['banner'] = banner;
    data['rating'] = rating;
    data['total_reviews'] = totalReviews;
    data['shop_name'] = shopName;
    data['is_followed'] = isFollowed;
    return data;
  }
}

class FeaturedShops {
  int? id;
  String? slug;
  String? logo;
  String? banner;
  dynamic rating;
  dynamic totalReviews;
  String? shopName;
  List<Products>? products;
  bool? isFollowed;

  FeaturedShops(
      {this.id,
      this.slug,
      this.logo,
      this.banner,
      this.rating,
      this.totalReviews,
      this.shopName,
      this.products,
        this.isFollowed,
      });

  FeaturedShops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    logo = json['logo'];
    banner = json['banner'];
    rating = json['rating'];
    totalReviews = json['total_reviews'];
    shopName = json['shop_name'];
    isFollowed = json['is_followed'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['logo'] = logo;
    data['banner'] = banner;
    data['rating'] = rating;
    data['total_reviews'] = totalReviews;
    data['shop_name'] = shopName;
    data['is_followed'] = isFollowed;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
