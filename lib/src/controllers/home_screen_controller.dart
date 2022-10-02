import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/models/home_data_model.dart';
import 'package:yoori_ecommerce/src/servers/repository.dart';
import 'package:yoori_ecommerce/src/data/local_data_helper.dart';

class HomeScreenController extends GetxController {
  PageController pageController = PageController();
  final CarouselController controller = CarouselController();
  var current = 1.obs;
  bool isVisible = true;
  var index = 2;
  bool isFavourite = false;
  Rx<HomeDataModel> homeDataModel = HomeDataModel().obs;
  var isLoadingFromServer = false.obs;

  Future<HomeDataModel> getHomeScreenData() async {
    HomeDataModel? data = LocalDataHelper().getHomeData();
    if (data != null) {
      homeDataModel.value = data;
    }
    await Repository().getHomeScreenData().then(
      (homeData) {
        homeDataModel.value = homeData;
        LocalDataHelper().saveHomeContent(homeData);
      },
    );
    return homeDataModel.value;
  }

  Future<HomeDataModel> getHomeDataFromServer() async {
    isLoadingFromServer(true);
    return await Repository().getHomeScreenData().then(
      (homeData) {
        homeDataModel.value = homeData;
        LocalDataHelper().saveHomeContent(homeData);
        isLoadingFromServer(false);
        return homeDataModel.value;
      },
    );
  }

  removeTrailingZeros(String n) {
    return n.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
  }

  @override
  void onInit() {
    super.onInit();
    getHomeScreenData();
  }

  isVisibleUpdate(bool value) {
    isVisible = value;
    update();
  }

  currentUpdate(int value) {
    current.value = value;
    update();
  }

  isFavouriteUpdate() {
    isFavourite = !isFavourite;
    update();
  }
}
