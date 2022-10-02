import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:yoori_ecommerce/src/models/all_category_product_model.dart';
import 'package:yoori_ecommerce/src/servers/repository.dart';

class CategoryContentController extends GetxController {
  final categoryList = <Categories>[].obs;
  final Rx<FeaturedCategory> featuredCategory = FeaturedCategory().obs;
  bool get isLoading => _isLoading.value;
  final _isLoading = true.obs;
  int page = 1;
  ScrollController scrollController = ScrollController();
  var isMoreDataAvailable = true.obs;
  var isMoreDataLoading = false.obs;
  var featuredIndex = true.obs;
  var index = 1.obs;

  updateIndex(int value) {
    index.value = value;
    update();
  }

  updateFeaturedIndexData(bool value) {
    featuredIndex(value);
    update();
  }

  @override
  void onInit() {
    getCatProducts();
    paginateTask();
    super.onInit();
  }

  void paginateTask() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (isMoreDataAvailable.value) {
          page++;
          getMoreData(page);
        }
      }
    });
  }

  getCatProducts() async {
    _isLoading(true);
    await Repository().getAllCategoryContent(page: page).then((value) {
      if (value != null && value.data != null) {
        featuredCategory.value = value.data!.featuredCategory!;
        categoryList.clear();
        categoryList.addAll(value.data!.categories!);
      }
    });

    _isLoading(false);
  }

  Future<void> getMoreData(int page) async {
    isMoreDataLoading(true);
    await Repository().getAllCategoryContent(page: page).then((value) {
      if (value != null && value.data != null) {
        if (value.data!.categories!.isNotEmpty) {
          categoryList.addAll(value.data!.categories!);
          isMoreDataAvailable(true);
          isMoreDataLoading(true);
        } else {
          isMoreDataAvailable(false);
          isMoreDataLoading(false);
        }
      } else {
        isMoreDataAvailable(false);
        isMoreDataLoading(false);
      }
    });
  }
}
