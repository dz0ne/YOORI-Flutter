class ProfileDataModel {
  ProfileDataModel({
      this.success, 
      this.message, 
      this.data,});

  ProfileDataModel.fromJson(dynamic json) {
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
    this.userId,
      this.firstName, 
      this.lastName, 
      this.email, 
      this.phone, 
      this.gender, 
      this.dateOfBirth, 
      this.image, 
      this.facebook, 
      this.twitter, 
      this.linkedin, 
      this.instagram, 
      this.pinterest, 
      this.youtube,
      this.isOrderedDigitalProduct,
  });

  Data.fromJson(dynamic json) {
    userId = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender']??"";
    dateOfBirth = json['date_of_birth']??"1897-05-07";
    image = json['image'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    instagram = json['instagram'];
    pinterest = json['pinterest'];
    youtube = json['youtube'];
    isOrderedDigitalProduct = json['is_ordered_digital_product'];
  }
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? gender;
  String? dateOfBirth;
  String? image;
  String? facebook;
  String? twitter;
  String? linkedin;
  String? instagram;
  String? pinterest;
  String? youtube;
  bool? isOrderedDigitalProduct;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = userId;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['phone'] = phone;
    map['gender'] = gender;
    map['date_of_birth'] = dateOfBirth;
    map['image'] = image;
    map['facebook'] = facebook;
    map['twitter'] = twitter;
    map['linkedin'] = linkedin;
    map['instagram'] = instagram;
    map['pinterest'] = pinterest;
    map['youtube'] = youtube;
    map['is_ordered_digital_product'] = isOrderedDigitalProduct;
    return map;
  }

}