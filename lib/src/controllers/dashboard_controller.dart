import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/_route/routes.dart';
import 'package:yoori_ecommerce/src/data/local_data_helper.dart';
import 'package:yoori_ecommerce/src/utils/analytics_helper.dart';
import 'package:yoori_ecommerce/src/utils/constants.dart';
import '../models/add_to_cart_list_model.dart';
import '../servers/repository.dart';

class DashboardController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    if (index == 3 || index == 4) {
      if (LocalDataHelper().getUserToken() == null) {
        if(index==3){
          Get.toNamed(Routes.logIn);
        }else{
          Get.toNamed(Routes.withOutLoginPage);
        }

      } else {
        printLog(tabIndex);
        tabIndex.value = index;
      }
    } else {
      tabIndex.value = index;
    }
  }

  AddToCartListModel? addToCartListModel = AddToCartListModel();
  Future getAddToCartList() async {
    addToCartListModel = await Repository().getCartItemList();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    AnalyticsHelper().setAnalyticsData(screenName: "HomeScreen");
    getAddToCartList();
  }
}
