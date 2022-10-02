class AddToCartListModel {
  AddToCartListModel({
    this.success,
    this.message,
    this.data,
  });

  AddToCartListModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'] ?? "";
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
    this.carts,
    this.trxId,
    this.calculations,
  });

  Data.fromJson(dynamic json) {
    if (json['carts'] != null) {
      carts = [];
      json['carts'].forEach((v) {
        carts?.add(Carts.fromJson(v));
      });
    }
    trxId = json['trx_id'];
    calculations = json['calculations'] != null
        ? Calculations.fromJson(json['calculations'])
        : null;
  }
  List<Carts>? carts;
  String? trxId;
  Calculations? calculations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (carts != null) {
      map['carts'] = carts?.map((v) => v.toJson()).toList();
    }
    map['trx_id'] = trxId;
    if (calculations != null) {
      map['calculations'] = calculations?.toJson();
    }
    return map;
  }
}

class Calculations {
  Calculations({
    this.subTotal,
    this.formattedSubTotal,
    this.discount,
    this.formattedDiscount,
    this.shippingCost,
    this.formattedShippingCost,
    this.tax,
    this.formattedTax,
    this.couponDiscount,
    this.formattedCouponDiscount,
    this.total,
    this.formattedTotal,
  });

  Calculations.fromJson(dynamic json) {
    subTotal = json['sub_total'];
    formattedSubTotal = json['formatted_sub_total'];
    discount = json['discount'];
    formattedDiscount = json['formatted_discount'];
    shippingCost = json['shipping_cost'];
    formattedShippingCost = json['formatted_shipping_cost'];
    tax = json['tax'];
    formattedTax = json['formatted_tax'];
    couponDiscount = json['coupon_discount'];
    formattedCouponDiscount = json['formatted_coupon_discount'];
    total = json['total'];
    formattedTotal = json['formatted_total'];
  }
  dynamic subTotal;
  String? formattedSubTotal;
  dynamic discount;
  String? formattedDiscount;
  String? shippingCost;
  String? formattedShippingCost;
  String? tax;
  String? formattedTax;
  String? couponDiscount;
  String? formattedCouponDiscount;
  dynamic total;
  String? formattedTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sub_total'] = subTotal;
    map['formatted_sub_total'] = formattedSubTotal;
    map['discount'] = discount;
    map['formatted_discount'] = formattedDiscount;
    map['shipping_cost'] = shippingCost;
    map['formatted_shipping_cost'] = formattedShippingCost;
    map['tax'] = tax;
    map['formatted_tax'] = formattedTax;
    map['coupon_discount'] = couponDiscount;
    map['formatted_coupon_discount'] = formattedCouponDiscount;
    map['total'] = total;
    map['formatted_total'] = formattedTotal;
    return map;
  }
}

class Carts {
  Carts(
      {this.id,
      this.sellerId,
      this.productId,
      this.productName,
      this.productImage,
      this.shopName,
      this.shopImage,
      this.variant,
      this.quantity,
      this.price,
      this.formattedPrice,
      this.discount,
      this.subTotal,
      this.formattedDiscount,
      this.formattedSubTotal,
      this.minimumOrder,
      this.stock});

  Carts.fromJson(dynamic json) {
    id = json['id'] ?? 0;
    sellerId = json['seller_id'] ?? 0;
    productId = json['product_id'] ?? 0;
    productName = json['product_name'] ?? "";
    productImage = json['product_image'] ?? "";
    shopName = json['shop_name'] ?? "";
    shopImage = json['shop_image'] ?? "";
    variant = json['variant'] ?? "";
    quantity = json['quantity'] ?? 0;
    price = json['price'];
    formattedPrice = json['formatted_price'] ?? "";
    discount = json['discount'] ?? 0;
    subTotal = json['sub_total'];
    minimumOrder = json['minimum_order_quantity'];
    stock = json['stock'];
    formattedDiscount = json['formatted_discount'] ?? "";
    formattedSubTotal = json['formatted_sub_total'] ?? "";
  }
  int? id;
  int? sellerId;
  int? productId;
  String? productName;
  String? productImage;
  String? shopName;
  String? shopImage;
  String? variant;
  int? quantity;
  dynamic price;
  String? formattedPrice;
  dynamic discount;
  dynamic subTotal;
  String? formattedDiscount;
  String? formattedSubTotal;
  int? minimumOrder;
  int? stock;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['seller_id'] = sellerId;
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['product_image'] = productImage;
    map['shop_name'] = shopName;
    map['shop_image'] = shopImage;
    map['variant'] = variant;
    map['quantity'] = quantity;
    map['price'] = price;
    map['formatted_price'] = formattedPrice;
    map['discount'] = discount;
    map['sub_total'] = subTotal;
    map['formatted_discount'] = formattedDiscount;
    map['formatted_sub_total'] = formattedSubTotal;
    map['minimum_order_quantity'] = minimumOrder;
    map['stock'] = stock;
    return map;
  }
}
