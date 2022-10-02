class AllBrandModel {
  AllBrandModel({this.success, this.message, required this.brands});

  AllBrandModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    brands = List.from(json['data']).map((e) => Brand.fromJson(e)).toList();
  }
  bool? success;
  String? message;
  late final List<Brand> brands;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['data'] = brands.map((v) => v.toJson()).toList();
    return map;
  }
}

class Brand {
  Brand({
    this.id,
    this.slug,
    this.title,
    this.thumbnail,
  });

  Brand.fromJson(dynamic json) {
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
