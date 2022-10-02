class AllCampaignModel {
  AllCampaignModel({
      this.success, 
      this.message, 
      required this.data,});

  AllCampaignModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  late final List<Data>? data;


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

class Data {
  Data({
      this.id, 
      this.slug, 
      this.title, 
      this.shortDescription, 
      this.startDate, 
      this.endDate, 
      this.banner,});

  Data.fromJson(dynamic json) {
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