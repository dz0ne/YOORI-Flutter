class OrderListModel {
  OrderListModel({
      this.success, 
      this.message, 
      this.data,});

  OrderListModel.fromJson(dynamic json) {
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
      this.orders,});

  Data.fromJson(dynamic json) {
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders?.add(Orders.fromJson(v));
      });
    }
  }
  List<Orders>? orders;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (orders != null) {
      map['orders'] = orders?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Orders {
  Orders({
      this.id, 
      this.trxId, 
      this.orderCode, 
      this.totalPayable, 
      this.paymentStatus, 
      this.date,});

  Orders.fromJson(dynamic json) {
    id = json['id'];
    trxId = json['trx_id'];
    orderCode = json['order_code'];
    totalPayable = json['total_payable'];
    paymentStatus = json['payment_status'];
    date = json['date'];
  }
  int? id;
  String? trxId;
  String? orderCode;
  String? totalPayable;
  String? paymentStatus;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['trx_id'] = trxId;
    map['order_code'] = orderCode;
    map['total_payable'] = totalPayable;
    map['payment_status'] = paymentStatus;
    map['date'] = date;
    return map;
  }

}