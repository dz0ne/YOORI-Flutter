class StateListModel {
  StateListModel({
      this.success, 
      this.message, 
      this.data,});

  StateListModel.fromJson(dynamic json) {
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
      this.states,});

  Data.fromJson(dynamic json) {
    if (json['states'] != null) {
      states = [];
      json['states'].forEach((v) {
        states?.add(States.fromJson(v));
      });
    }
  }
  List<States>? states;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (states != null) {
      map['states'] = states?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class States {
  States({
      this.id, 
      this.name, 
      this.countryId, 
      this.latitude, 
      this.longitude, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  States.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  int? countryId;
  String? latitude;
  String? longitude;
  int? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['country_id'] = countryId;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}