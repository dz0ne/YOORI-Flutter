class AllNewsModel {
  AllNewsModel({
      this.success, 
      this.message, 
      required this.data,});

  AllNewsModel.fromJson(dynamic json) {
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
      this.url, 
      this.title, 
      this.shortDescription, 
      this.thumbnail,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    slug = json['slug'];
    url = json['url'];
    title = json['title'];
    shortDescription = json['short_description'];
    thumbnail = json['thumbnail'];
  }
  int? id;
  String? slug;
  String? url;
  String? title;
  String? shortDescription;
  String? thumbnail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['slug'] = slug;
    map['url'] = url;
    map['title'] = title;
    map['short_description'] = shortDescription;
    map['thumbnail'] = thumbnail;
    return map;
  }

}