import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yoori_ecommerce/src/models/track_order_model.dart';
import 'package:yoori_ecommerce/src/servers/repository.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';

class TrackingOrderController extends GetxController {
  final trackingController = TextEditingController();
  final stepsText = ["A", "B", "C", "D"];
  final stepCircleRadius = 10.0;
  final stepProgressViewHeight = 150.0;
  final Color activeColor = AppThemeData.actColor;
  final Color inactiveColor = AppThemeData.inActColor;
  final TextStyle headerStyle = AppThemeData.headerTextStyle_16reg;
  final TextStyle stepStyle = AppThemeData.stepTextStyle_12;
  var currentPage = 1.obs;
  var isLoading = false.obs;
  var loadData = false.obs;
  final dateFormat = DateFormat('dd-MM-yyyy hh:mm aa');

  TrackingOrderModel? trackingOrderModel;
  Future getTrackingOrder(String trackId) async {
    await Repository().getTrackingOrder(trackId: trackId).then(
      (value) {
        if (value != null) {
          trackingOrderModel = value;
        }
      },
    );
  }

  isLoadingUpdate(value) {
    isLoading.value = value;
  }

  currentPageUpdate(value) {
    currentPage.value = value;
  }

  loadDataUpdate(value) {
    loadData.value = value;
  }

   textFieldEmptySnackBar() {
    Get.snackbar(
      'Order ID Required!',
      'Please enter order Id',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
      isDismissible: false,
      forwardAnimationCurve: Curves.decelerate,
      reverseAnimationCurve: Curves.easeInBack,
    );
  }

  @override
  void onClose() {
    trackingController.dispose();
    super.onClose();
  }
}
//YR-6568297663
