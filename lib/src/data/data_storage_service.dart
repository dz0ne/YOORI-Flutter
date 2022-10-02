import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  String? languageCode;
  String? countryCode;

  Future<StorageService> init() async {
    await GetStorage.init();
    languageCode = GetStorage().read('languageCode');
    countryCode = GetStorage().read('countryCode');
    return this;
  }
  void write(String key, dynamic value) {
    GetStorage().write(key, value);
  }
}