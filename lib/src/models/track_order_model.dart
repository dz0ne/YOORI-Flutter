class TrackingOrderModel {
  TrackingOrderModel({
    this.success,
    this.message,
    this.data,
  });

  TrackingOrderModel.fromJson(dynamic json) {
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
    this.order,
  });

  Data.fromJson(dynamic json) {
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }
  Order? order;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (order != null) {
      map['order'] = order?.toJson();
    }
    return map;
  }
}

class Order {
  Order({
    this.id,
    this.invoiceNo,
    this.billingAddress,
    this.shippingAddress,
    this.date,
    this.orderStatus,
    this.paymentStatus,
    this.paymentType,
    this.subTotal,
    this.formattedSubTotal,
    this.discount,
    this.formattedDiscount,
    this.couponDiscount,
    this.formattedCouponDiscount,
    this.tax,
    this.formattedTax,
    this.shippingCost,
    this.formattedShippingCost,
    this.totalPayable,
    this.formattedTotalPayable,
    this.isOrderPlaced,
    this.isOrderAccepted,
    this.isOrderProcessing,
    this.isOrderDelivered,
    this.orderDetails,
    this.orderHistory,
  });

  Order.fromJson(dynamic json) {
    id = json['id'];
    invoiceNo = json['invoice_no'];
    billingAddress = json['billing_address'] != null
        ? BillingAddress.fromJson(json['billing_address'])
        : null;
    shippingAddress = json['shipping_address'] != null
        ? ShippingAddress.fromJson(json['shipping_address'])
        : null;
    date = json['date'] != null ? DateTime.parse(json['date']) : null;
    orderStatus = json['order_status'];
    paymentStatus = json['payment_status'];
    paymentType = json['payment_type'];
    subTotal = json['sub_total'];
    formattedSubTotal = json['formatted_sub_total'];
    discount = json['discount'];
    formattedDiscount = json['formatted_discount'];
    couponDiscount = json['coupon_discount'];
    formattedCouponDiscount = json['formatted_coupon_discount'];
    tax = json['tax'];
    formattedTax = json['formatted_tax'];
    shippingCost = json['shipping_cost'];
    formattedShippingCost = json['formatted_shipping_cost'];
    totalPayable = json['total_payable'];
    formattedTotalPayable = json['formatted_total_payable'];
    isOrderPlaced = json['is_order_placed'];
    isOrderAccepted = json['is_order_accepted'];
    isOrderProcessing = json['is_order_processing'];
    isOrderDelivered = json['is_order_delivered'];
    if (json['order_details'] != null) {
      orderDetails = [];
      json['order_details'].forEach((v) {
        orderDetails?.add(OrderDetails.fromJson(v));
      });
    }
    if (json['order_history'] != null) {
      orderHistory = <OrderHistory>[];
      json['order_history'].forEach((v) {
        orderHistory!.add(OrderHistory.fromJson(v));
      });
    }
  }
  int? id;
  String? invoiceNo;
  BillingAddress? billingAddress;
  ShippingAddress? shippingAddress;
  DateTime? date;
  String? orderStatus;
  String? paymentStatus;
  String? paymentType;
  dynamic subTotal;
  String? formattedSubTotal;
  dynamic discount;
  String? formattedDiscount;
  dynamic couponDiscount;
  String? formattedCouponDiscount;
  dynamic tax;
  String? formattedTax;
  dynamic shippingCost;
  String? formattedShippingCost;
  dynamic totalPayable;
  String? formattedTotalPayable;
  bool? isOrderPlaced;
  bool? isOrderAccepted;
  bool? isOrderProcessing;
  bool? isOrderDelivered;
  List<OrderDetails>? orderDetails;
  List<OrderHistory>? orderHistory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['invoice_no'] = invoiceNo;
    if (billingAddress != null) {
      map['billing_address'] = billingAddress?.toJson();
    }
    if (shippingAddress != null) {
      map['shipping_address'] = shippingAddress?.toJson();
    }
    map['date'] = date;
    map['order_status'] = orderStatus;
    map['payment_status'] = paymentStatus;
    map['payment_type'] = paymentType;
    map['sub_total'] = subTotal;
    map['formatted_sub_total'] = formattedSubTotal;
    map['discount'] = discount;
    map['formatted_discount'] = formattedDiscount;
    map['coupon_discount'] = couponDiscount;
    map['formatted_coupon_discount'] = formattedCouponDiscount;
    map['tax'] = tax;
    map['formatted_tax'] = formattedTax;
    map['shipping_cost'] = shippingCost;
    map['formatted_shipping_cost'] = formattedShippingCost;
    map['total_payable'] = totalPayable;
    map['formatted_total_payable'] = formattedTotalPayable;
    map['is_order_placed'] = isOrderPlaced;
    map['is_order_accepted'] = isOrderAccepted;
    map['is_order_processing'] = isOrderProcessing;
    map['is_order_delivered'] = isOrderDelivered;
    if (orderDetails != null) {
      map['order_details'] = orderDetails?.map((v) => v.toJson()).toList();
    }
    if (orderHistory != null) {
      map['order_history'] = orderHistory!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class OrderDetails {
  OrderDetails({
    this.id,
    this.productName,
    this.quantity,
    this.price,
    this.formattedPrice,
    this.tax,
    this.formattedTax,
    this.discount,
    this.formattedDiscount,
    this.couponDiscount,
    this.formattedCouponDiscount,
    this.shippingCost,
    this.formattedShippingCost,
    this.subTotal,
    this.formattedSubTotal,
    this.totalPayable,
    this.formattedTotalPayable,
  });

  OrderDetails.fromJson(dynamic json) {
    id = json['id'];
    productName = json['product_name'];
    quantity = json['quantity'];
    price = json['price'];
    formattedPrice = json['formatted_price'];
    tax = json['tax'];
    formattedTax = json['formatted_tax'];
    discount = json['discount'];
    formattedDiscount = json['formatted_discount'];
    couponDiscount = json['coupon_discount'];
    formattedCouponDiscount = json['formatted_coupon_discount'];
    shippingCost = json['shipping_cost'];
    formattedShippingCost = json['formatted_shipping_cost'];
    subTotal = json['sub_total'];
    formattedSubTotal = json['formatted_sub_total'];
    totalPayable = json['total_payable'];
    formattedTotalPayable = json['formatted_total_payable'];
  }
  int? id;
  String? productName;
  int? quantity;
  dynamic price;
  String? formattedPrice;
  dynamic tax;
  String? formattedTax;
  dynamic discount;
  String? formattedDiscount;
  int? couponDiscount;
  String? formattedCouponDiscount;
  int? shippingCost;
  String? formattedShippingCost;
  dynamic subTotal;
  String? formattedSubTotal;
  dynamic totalPayable;
  String? formattedTotalPayable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_name'] = productName;
    map['quantity'] = quantity;
    map['price'] = price;
    map['formatted_price'] = formattedPrice;
    map['tax'] = tax;
    map['formatted_tax'] = formattedTax;
    map['discount'] = discount;
    map['formatted_discount'] = formattedDiscount;
    map['coupon_discount'] = couponDiscount;
    map['formatted_coupon_discount'] = formattedCouponDiscount;
    map['shipping_cost'] = shippingCost;
    map['formatted_shipping_cost'] = formattedShippingCost;
    map['sub_total'] = subTotal;
    map['formatted_sub_total'] = formattedSubTotal;
    map['total_payable'] = totalPayable;
    map['formatted_total_payable'] = formattedTotalPayable;
    return map;
  }
}

class ShippingAddress {
  ShippingAddress({
    this.id,
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
  });

  ShippingAddress.fromJson(dynamic json) {
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone_no'] = phoneNo;
    map['address'] = address;
    if (addressIds != null) {
      map['address_ids'] = addressIds?.toJson();
    }
    map['country'] = country;
    map['state'] = state;
    map['city'] = city;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['postal_code'] = postalCode;
    return map;
  }
}

class AddressIds {
  AddressIds({
    this.countryId,
    this.stateId,
    this.cityId,
  });

  AddressIds.fromJson(dynamic json) {
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
  }
  String? countryId;
  String? stateId;
  String? cityId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country_id'] = countryId;
    map['state_id'] = stateId;
    map['city_id'] = cityId;
    return map;
  }
}

class BillingAddress {
  BillingAddress({
    this.id,
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
  });

  BillingAddress.fromJson(dynamic json) {
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone_no'] = phoneNo;
    map['address'] = address;
    if (addressIds != null) {
      map['address_ids'] = addressIds?.toJson();
    }
    map['country'] = country;
    map['state'] = state;
    map['city'] = city;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['postal_code'] = postalCode;
    return map;
  }
}

class OrderHistory {
  String? createdAt;
  String? event;

  OrderHistory({this.createdAt, this.event});

  OrderHistory.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    event = json['event'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['event'] = event;
    return data;
  }
}
