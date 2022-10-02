class MyWalletModel {
  bool? success;
  String? message;
  Data? data;

  MyWalletModel({this.success, this.message, this.data});

  MyWalletModel.fromJson(Map<String, dynamic> json) {
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
  List<Recharges>? recharges;
  Balance? balance;

  Data({this.recharges, this.balance});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['recharges'] != null) {
      recharges = <Recharges>[];
      json['recharges'].forEach((v) {
        recharges!.add(Recharges.fromJson(v));
      });
    }
    balance =
    json['balance'] != null ? Balance.fromJson(json['balance']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recharges != null) {
      data['recharges'] = recharges!.map((v) => v.toJson()).toList();
    }
    if (balance != null) {
      data['balance'] = balance!.toJson();
    }
    return data;
  }
}

class Recharges {
  int? id;
  dynamic amount;
  int? userId;
  String? type;
  String? paymentMethod;
  String? status;
  String? transactionId;
  String? date;

  Recharges(
      {this.id,
        this.amount,
        this.userId,
        this.type,
        this.paymentMethod,
        this.status,
        this.transactionId,
        this.date,
      });

  Recharges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    userId = json['user_id'];
    type = json['type'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    transactionId = json['transaction_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['user_id'] = userId;
    data['type'] = type;
    data['payment_method'] = paymentMethod;
    data['status'] = status;
    data['transaction_id'] = transactionId;
    data['date'] = date;
    return data;
  }
}

class Balance {
  int? id;
  String? fullName;
  dynamic balance;

  Balance({this.id, this.fullName, this.balance});

  Balance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['balance'] = balance;
    return data;
  }
}
