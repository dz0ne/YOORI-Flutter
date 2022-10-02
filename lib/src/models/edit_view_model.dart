class EditViewModel {
  bool? success;
  String? message;
  Data? data;

  EditViewModel({this.success, this.message, this.data});

  EditViewModel.fromJson(Map<String, dynamic> json) {
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
  Address? address;

  Data({this.address});

  Data.fromJson(Map<String, dynamic> json) {
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

class Address {
  int? id;
  int? userId;
  String? name;
  String? email;
  String? phoneNo;
  String? address;
  AddressIds? addressIds;
  String? country;
  String? state;
  String? city;
  dynamic latitude;
  dynamic longitude;
  String? postalCode;
  int? defaultShipping;
  int? defaultBilling;
  String? createdAt;
  String? updatedAt;

  Address(
      {this.id,
        this.userId,
        this.name,
        this.email,
        this.phoneNo,
        this.address,
        this.addressIds,
        this.country,
        this.state,
        this.city,
        this.latitude,
        this.longitude,
        this.postalCode,
        this.defaultShipping,
        this.defaultBilling,
        this.createdAt,
        this.updatedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    address = json['address'];
    addressIds = json['address_ids'] != null
        ? AddressIds.fromJson(json['address_ids'])
        : null;
    country = json['country'];
    state = json['state'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    postalCode = json['postal_code'];
    defaultShipping = json['default_shipping'];
    defaultBilling = json['default_billing'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['phone_no'] = phoneNo;
    data['address'] = address;
    if (addressIds != null) {
      data['address_ids'] = addressIds!.toJson();
    }
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['postal_code'] = postalCode;
    data['default_shipping'] = defaultShipping;
    data['default_billing'] = defaultBilling;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class AddressIds {
  String? countryId;
  String? stateId;
  String? cityId;

  AddressIds({this.countryId, this.stateId, this.cityId});

  AddressIds.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['city_id'] = cityId;
    return data;
  }
}
