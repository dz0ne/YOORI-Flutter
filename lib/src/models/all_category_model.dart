class AllCategoryModel {
  AllCategoryModel({
      this.success, 
      this.message, 
      this.data,});

  AllCategoryModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataAll.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<DataAll>? data;

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

class DataAll {
  DataAll({
      this.id, 
      this.icon, 
      this.parentId, 
      this.slug, 
      this.title, 
      this.image, 
      this.childCategories,});

  DataAll.fromJson(dynamic json) {
    id = json['id'];
    icon = json['icon'];
    parentId = json['parent_id'];
    slug = json['slug'];
    title = json['title'];
    image = json['image'];
    if (json['child_categories'] != null) {
      childCategories = [];
      json['child_categories'].forEach((v) {
        childCategories?.add(ChildCategories.fromJson(v));
      });
    }
  }
  int? id;
  String? icon;
  dynamic parentId;
  String? slug;
  String? title;
  String? image;
  List<ChildCategories>? childCategories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['icon'] = icon;
    map['parent_id'] = parentId;
    map['slug'] = slug;
    map['title'] = title;
    map['image'] = image;
    if (childCategories != null) {
      map['child_categories'] = childCategories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ChildCategories {
  ChildCategories({
      this.id, 
      this.icon, 
      this.parentId, 
      this.slug, 
      this.title, 
      this.image,});

  ChildCategories.fromJson(dynamic json) {
    id = json['id']??0;
    icon = json['icon']??"";
    parentId = json['parent_id'];
    slug = json['slug']??"";
    title = json['title']??"";
    image = json['image']??"";
  }
  int? id;
  String? icon;
  dynamic parentId;
  String? slug;
  String? title;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['icon'] = icon;
    map['parent_id'] = parentId;
    map['slug'] = slug;
    map['title'] = title;
    map['image'] = image;
    return map;
  }

}