class UserDataModel {
  UserDataModel({
      this.success, 
      this.message, 
      this.data,});

  UserDataModel.fromJson(dynamic json) {
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
      this.token = "",
      this.userId,
      this.firstName, 
      this.lastName, 
      this.image, 
      this.phone, 
      this.email, 
      this.favourites, 
      this.notifications,
      this.gender,
      this.dateOfBirth
  });

  Data.fromJson(dynamic json) {
    token = json['token'] ;
    userId = json['id'] ;
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image']??"";
    phone = json['phone'];
    email = json['email'];
    favourites = json['favourites'];
    notifications = json['notifications'];
    dateOfBirth = json['date_of_birth']??"Select Date";
    gender = json['gender']??"Select Gender";
  }
  late String token;
  int? userId;
  String? firstName;
  String? lastName;
  String? image;
  String? phone;
  String? email;
  dynamic favourites;
  dynamic notifications;
  String? dateOfBirth;
  String? gender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token ;
    map['id'] = userId ;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['image'] = image;
    map['phone'] = phone;
    map['email'] = email;
    map['favourites'] = favourites;
    map['notifications'] = notifications;
    map['date_of_birth'] = dateOfBirth;
    map['gender'] = gender;
    return map;
  }

}