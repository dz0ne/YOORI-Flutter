import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
