class MyRewardModel {
  MyRewardModel({
      this.success, 
      this.message, 
      this.data,});

  MyRewardModel.fromJson(dynamic json) {
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
      this.reward, 
      this.rewardDetails,});

  Data.fromJson(dynamic json) {
    reward = json['reward'] != null ? Reward.fromJson(json['reward']) : null;
    if (json['reward_details'] != null) {
      rewardDetails = [];
      json['reward_details'].forEach((v) {
        rewardDetails?.add(RewardDetails.fromJson(v));
      });
    }
  }
  Reward? reward;
  List<RewardDetails>? rewardDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (reward != null) {
      map['reward'] = reward?.toJson();
    }
    if (rewardDetails != null) {
      map['reward_details'] = rewardDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class RewardDetails {
  RewardDetails({
      this.reward, 
      this.productQty, 
      this.productName,});

  RewardDetails.fromJson(dynamic json) {
    reward = json['reward'];
    productQty = json['product_qty'];
    productName = json['product_name'];
  }
  int? reward;
  int? productQty;
  String? productName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reward'] = reward;
    map['product_qty'] = productQty;
    map['product_name'] = productName;
    return map;
  }

}

class Reward {
  Reward({
      this.id, 
      this.userId, 
      this.rewards, 
      this.lastConverted, 
      this.createdAt, 
      this.updatedAt, 
      this.lastConversion, 
      this.rewardSum,});

  Reward.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    rewards = json['rewards'];
    lastConverted = json['last_converted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastConversion = json['last_conversion'];
    rewardSum = json['reward_sum'];
  }
  int? id;
  int? userId;
  int? rewards;
  dynamic lastConverted;
  String? createdAt;
  String? updatedAt;
  String? lastConversion;
  dynamic rewardSum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['rewards'] = rewards;
    map['last_converted'] = lastConverted;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['last_conversion'] = lastConversion;
    map['reward_sum'] = rewardSum;
    return map;
  }

}