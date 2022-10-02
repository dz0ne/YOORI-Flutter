class ConfirmOrderModel {
  bool? success;
  String? message;
  List<Data>? data;

  ConfirmOrderModel({this.success, this.message, this.data});

  ConfirmOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  ShippingAddress? shippingAddress;
  ShippingAddress? billingAddress;
  int? sellerId;
  int? userId;
  String? paymentType;
  int? subTotal;
  int? discount;
  int? couponDiscount;
  int? totalTax;
  int? totalAmount;
  int? shippingCost;
  int? totalPayable;
  String? code;
  String? trxId;
  dynamic pickupHubId;
  String? date;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? orderDate;
  dynamic deliveredDays;
  dynamic deliveredAt;

  Data(
      {this.shippingAddress,
      this.billingAddress,
      this.sellerId,
      this.userId,
      this.paymentType,
      this.subTotal,
      this.discount,
      this.couponDiscount,
      this.totalTax,
      this.totalAmount,
      this.shippingCost,
      this.totalPayable,
      this.code,
      this.trxId,
      this.pickupHubId,
      this.date,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.orderDate,
      this.deliveredDays,
      this.deliveredAt});

  Data.fromJson(Map<String, dynamic> json) {
    shippingAddress = json['shipping_address'] != null
        ? ShippingAddress.fromJson(json['shipping_address'])
        : null;
    billingAddress = json['billing_address'] != null
        ? ShippingAddress.fromJson(json['billing_address'])
        : null;
    sellerId = json['seller_id'];
    userId = json['user_id'];
    paymentType = json['payment_type'];
    subTotal = json['sub_total'];
    discount = json['discount'];
    couponDiscount = json['coupon_discount'];
    totalTax = json['total_tax'];
    totalAmount = json['total_amount'];
    shippingCost = json['shipping_cost'];
    totalPayable = json['total_payable'];
    code = json['code'];
    trxId = json['trx_id'];
    pickupHubId = json['pickup_hub_id'];
    date = json['date'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    orderDate = json['order_date'];
    deliveredDays = json['delivered_days'];
    deliveredAt = json['delivered_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shippingAddress != null) {
      data['shipping_address'] = shippingAddress!.toJson();
    }
    if (billingAddress != null) {
      data['billing_address'] = billingAddress!.toJson();
    }
    data['seller_id'] = sellerId;
    data['user_id'] = userId;
    data['payment_type'] = paymentType;
    data['sub_total'] = subTotal;
    data['discount'] = discount;
    data['coupon_discount'] = couponDiscount;
    data['total_tax'] = totalTax;
    data['total_amount'] = totalAmount;
    data['shipping_cost'] = shippingCost;
    data['total_payable'] = totalPayable;
    data['code'] = code;
    data['trx_id'] = trxId;
    data['pickup_hub_id'] = pickupHubId;
    data['date'] = date;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['order_date'] = orderDate;
    data['delivered_days'] = deliveredDays;
    data['delivered_at'] = deliveredAt;
    return data;
  }
}

class ShippingAddress {
  String? id;
  String? name;
  String? email;
  String? phoneNo;
  String? address;
  AddressIds? addressIds;
  String? country;
  String? state;
  String? city;
  String? latitude;
  String? longitude;
  String? postalCode;

  ShippingAddress(
      {this.id,
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
      this.postalCode});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
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
