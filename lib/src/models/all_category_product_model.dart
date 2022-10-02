class AllCategoryProductModel {
  bool? success;
  String? message;
  Data? data;

  AllCategoryProductModel({this.success, this.message, this.data});

  AllCategoryProductModel.fromJson(Map<String, dynamic> json) {
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
  FeaturedCategory? featuredCategory;
  List<Categories>? categories;

  Data({this.featuredCategory, this.categories});

  Data.fromJson(Map<String, dynamic> json) {
    featuredCategory = json['featured_category'] != null
        ? FeaturedCategory.fromJson(json['featured_category'])
        : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (featuredCategory != null) {
      data['featured_category'] = featuredCategory!.toJson();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeaturedCategory {
  String? title;
  String? icon;
  String? banner;
  List<FeaturedSubCategories>? featuredSubCategories;

  FeaturedCategory(
      {this.title, this.icon, this.banner, this.featuredSubCategories});

  FeaturedCategory.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    icon = json['icon'];
    banner = json['banner'] ??"";
    if (json['featured_sub_categories'] != null) {
      featuredSubCategories = <FeaturedSubCategories>[];
      json['featured_sub_categories'].forEach((v) {
        featuredSubCategories!.add(FeaturedSubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['icon'] = icon;
    data['banner'] = banner;
    if (featuredSubCategories != null) {
      data['featured_sub_categories'] =
          featuredSubCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeaturedSubCategories {
  int? id;
  String? icon;
  int? parentId;
  String? slug;
  String? title;
  String? image;

  FeaturedSubCategories(
      {this.id, this.icon, this.parentId, this.slug, this.title, this.image});

  FeaturedSubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    parentId = json['parent_id'];
    slug = json['slug'];
    title = json['title'];
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

class Categories {
  int? id;
  String? icon;
  int? parentId;
  String? slug;
  String? banner;
  String? title;
  String? image;
  List<SubCategories>? subCategories;

  Categories(
      {this.id,
      this.icon,
      this.parentId,
      this.slug,
      this.banner,
      this.title,
      this.image,
      this.subCategories});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    parentId = json['parent_id'];
    slug = json['slug'];
    banner = json['banner'];
    title = json['title'];
    image = json['image'];
    if (json['sub_categories'] != null) {
      subCategories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['icon'] = icon;
    data['parent_id'] = parentId;
    data['slug'] = slug;
    data['banner'] = banner;
    data['title'] = title;
    data['image'] = image;
    if (subCategories != null) {
      data['sub_categories'] = subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  int? id;
  String? icon;
  int? parentId;
  String? slug;
  String? banner;
  String? title;
  String? image;
  List<ChildCategories>? childCategories;

  SubCategories(
      {this.id,
      this.icon,
      this.parentId,
      this.slug,
      this.banner,
      this.title,
      this.image,
      this.childCategories});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    parentId = json['parent_id'];
    slug = json['slug'];
    banner = json['banner'];
    title = json['title'];
    image = json['image'];
    if (json['child_categories'] != null) {
      childCategories = <ChildCategories>[];
      json['child_categories'].forEach((v) {
        childCategories!.add(ChildCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['icon'] = icon;
    data['parent_id'] = parentId;
    data['slug'] = slug;
    data['banner'] = banner;
    data['title'] = title;
    data['image'] = image;
    if (childCategories != null) {
      data['child_categories'] =
          childCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildCategories {
  int? id;
  String? icon;
  int? parentId;
  String? slug;
  String? banner;
  String? title;
  String? image;

  ChildCategories({
    this.id,
    this.icon,
    this.parentId,
    this.slug,
    this.banner,
    this.title,
    this.image,
  });

  ChildCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    parentId = json['parent_id'];
    slug = json['slug'];
    banner = json['banner'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['icon'] = icon;
    data['parent_id'] = parentId;
    data['slug'] = slug;
    data['banner'] = banner;
    data['title'] = title;
    data['image'] = image;

    return data;
  }
}
