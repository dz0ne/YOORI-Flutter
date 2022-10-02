import 'package:get/get.dart';

import '../models/coupon_list_model.dart';
import '../servers/repository.dart';

class VoucherController extends GetxController {
  Rx<CouponListModel?> couponListModel = CouponListModel().obs;

  @override
  void onInit() async {
    await Repository().getVoucherList().then((value) {
      couponListModel.value = value;
    });
    super.onInit();
  }
}
