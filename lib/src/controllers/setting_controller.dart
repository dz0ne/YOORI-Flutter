import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yoori_ecommerce/src/models/config_model.dart';
import 'package:yoori_ecommerce/src/servers/repository.dart';
import 'package:yoori_ecommerce/src/data/local_data_helper.dart';

class SettingController extends GetxController {
  RxBool isToggle = false.obs;

  var box = GetStorage();
  var selectedCurrency = "".obs;
  var selectedCurrencyName = "".obs;

  PackageInfo? packageInfo;

  List<Currencies>? curr;

  getIndex(value) {
    return curr!.indexWhere(((currIndex) => currIndex.code == value));
  }

  void updateCurrency(value) {
    selectedCurrency.value = value;
  }

  void updateCurrencyName(value) {
    selectedCurrencyName.value = curr![value].name!;
  }

  void toggle() {
    isToggle.value = isToggle.value ? false : true;
  }

  void handleConfigData() async {
    return Repository().getConfigData().then((configModel) {
      LocalDataHelper().saveConfigData(configModel).then((value) {});
    });
  }

  @override
  void onInit() async {
    curr = LocalDataHelper().getConfigData().data!.currencies!;
    selectedCurrency.value = LocalDataHelper().getCurrCode() ?? "USD";
    selectedCurrencyName.value = selectedCurrencyName.isEmpty
        ? "US Dollar"
        : curr![getIndex(selectedCurrencyName)].name.toString();
    packageInfo = await PackageInfo.fromPlatform();
    super.onInit();
  }
}
