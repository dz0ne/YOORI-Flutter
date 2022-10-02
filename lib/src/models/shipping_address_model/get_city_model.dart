class GetCitisModel {
  GetCitisModel({
      this.success, 
      this.message, 
      this.data,});

  GetCitisModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.cities,});

  Data.fromJson(dynamic json) {
    if (json['cities'] != null) {
      cities = [];
      json['cities'].forEach((v) {
        cities?.add(Cities.fromJson(v));
      });
    }
  }
  List<Cities>? cities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (cities != null) {
      map['cities'] = cities?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Cities {
  Cities({
      this.id, 
      this.name, 
      this.stateId, 
      this.countryId, 
      this.cost, 
      this.latitude, 
      this.longitude, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  Cities.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    stateId = json['state_id'];
    countryId = json['country_id'];
    cost = json['cost'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  int? stateId;
  int? countryId;
  int? cost;
  dynamic latitude;
  dynamic longitude;
  int? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['state_id'] = stateId;
    map['country_id'] = countryId;
    map['cost'] = cost;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}