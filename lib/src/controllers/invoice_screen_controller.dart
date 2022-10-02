import 'package:get/get.dart';
import '../models/track_order_model.dart';
import '../servers/repository.dart';

class InvoiceScreenController extends GetxController{
  var isLoading = false.obs;
  final trackingId = Get.parameters['trackingId'];

  TrackingOrderModel? trackingOrderModel =TrackingOrderModel();
  Future getAllCampaign() async {
    trackingOrderModel =
    await Repository().getTrackingOrder(trackId: trackingId);
    isLoading.value = true;
  }

  @override
  void onInit() {
    getAllCampaign();
    super.onInit();
  }
}