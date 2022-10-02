import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/models/my_reward_model.dart';
import '../servers/repository.dart';

class MyRewardController extends GetxController {
  late Rx<MyRewardModel> myRewardModel = MyRewardModel().obs;
  final TextEditingController?  convertRewardController = TextEditingController();
  var convertedReward = '0.0'.obs;


  var isLoading=false.obs;

  Future getMyReward() async {
    await Repository().getMyReward().then((value) {
      myRewardModel.value = value!;
    });
    update();
  }

  Future postConvertReward(String reward) async {
    await Repository().postConvertReward(reward: reward).then((value) {
      isLoading.value = value;
    });
    update();
  }

  @override
  void onInit() {
    convertRewardController!.addListener(() {
      convertedReward.value=convertRewardController!.text;
    });
    getMyReward();
    super.onInit();
  }
}
