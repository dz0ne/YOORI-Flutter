import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/models/favorite_product_model.dart';
import 'package:yoori_ecommerce/src/servers/repository.dart';
import 'package:yoori_ecommerce/src/utils/analytics_helper.dart';

import '../data/local_data_helper.dart';

class FavouriteController extends GetxController {
  final _isLoading = true.obs;
  Rx<FavouriteData>? _data = FavouriteData().obs;
  FavouriteData? get data => _data?.value;
  bool get isLoading => _isLoading.value;
  final _isInFavList = false.obs;
  bool get isInFavList => _isInFavList.value;
  late String? token;

  @override
  void onInit() {
    super.onInit();
    token = LocalDataHelper().getUserToken();
    fetchData();
  }

  Future<bool> addOrRemoveFromFav(var productId) async {
    await Repository().addOrRemoveFromFavoriteList(productId).then((value) {
      fetchData();
      AnalyticsHelper().setAnalyticsData(
          screenName: "FavouriteScreen",
          eventTitle: "AddOrRemoveProductToFavouriteList",
          additionalData: {
            "productId": productId,
          });
      return value;
    });
    return false;
  }

  Future<bool> followOrUnfollowShopFromFav(var shopId) async {
    await Repository().followOrUnfollowShopList(shopId).then((value) {
      fetchData();
      AnalyticsHelper().setAnalyticsData(
          screenName: "FavouriteScreen",
          eventTitle: "AddOrRemoveShop",
          additionalData: {
            "shopId": shopId,
          });
      return value;
    });
    return false;
  }

  Future<void> fetchData() async {
    return Repository().getFavoriteProduct().then((value) {
      if (value == null) {
        _data = null;
        return;
      }
      _data?.value = value;
      _isLoading(false);
    }).onError((error, stackTrace) {
      _isLoading(false);
    });
  }
}
