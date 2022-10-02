import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/controllers/auth_controller.dart';
import 'package:yoori_ecommerce/src/controllers/currency_converter_controller.dart';
import 'package:yoori_ecommerce/src/controllers/phone_auth_controller.dart';
import 'package:yoori_ecommerce/src/data/data_storage_service.dart';

class InitBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
    Get.put<PhoneAuthController>(PhoneAuthController());
    Get.put(StorageService());
    Get.lazyPut(() => CurrencyConverterController(), fenix: true);
  }
}
