import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yoori_ecommerce/src/models/config_model.dart';
import 'package:yoori_ecommerce/src/models/home_data_model.dart';
import 'package:yoori_ecommerce/src/models/user_data_model.dart';
import '../models/profile_data_model.dart';
import '../widgets/network_image_checker.dart';


class LocalDataHelper {
  var box = GetStorage();

  saveUserAllData(UserDataModel userDataModel) async {
    await box.write('userModel', userDataModel.toJson());
  }

  UserDataModel? getUserAllData() {
    var userDataModel = box.read('userModel');
    return userDataModel != null ? UserDataModel.fromJson(userDataModel) : null;
  }

  void saveUserToken(String userToken) async {
    await box.write('userToken', userToken);
    //_profileContentController.update();
  }


  String? getUserToken() {
    String? getData = box.read("userToken");
    return getData;
  }

  Future<void> saveConfigData(ConfigModel data) async {
    await box.write("config_model", data.toJson());
  }

  ConfigModel getConfigData() {
    return ConfigModel.fromJson(box.read("config_model"));
  }

  bool isPhoneLoginEnabled() {
    if (getConfigData().data!.addons != null) {
      ConfigModel config = getConfigData();
      for (var addon in config.data!.addons!) {
        if (addon.addonIdentifier == "otp_system") {
          return true;
        }
      }
    }
    return false;
  }

  bool isRefundAddonAvailable() {
    if (getConfigData().data!.addons != null) {
      ConfigModel config = getConfigData();
      for (var addon in config.data!.addons!) {
        if (addon.addonIdentifier == "refund" &&
            addon.status == true &&
            addon.addonData != null) {
          return true;
        }
      }
    }
    return false;
  }

  Widget getRefundIcon(){
    return NetworkImageCheckerWidget(image: getRefundAddon() != null &&
                getRefundAddon()!.addonData != null &&
               getRefundAddon()!.addonData!.sticker != null
            ? getRefundAddon()!.addonData!.sticker!
            : "");
  }

  Addons? getRefundAddon() {
    if (getConfigData().data!.addons != null) {
      ConfigModel config = getConfigData();
      for (var addon in config.data!.addons!) {
        if (addon.addonIdentifier == "refund" && addon.addonData != null) {
          return addon;
        }
      }
    }
    return null;
  }

  //currency
  void saveCurrency(String currCode) {
    box.write('currCode', currCode);
  }

  getCurrCode() {
    String? getData = box.read("currCode");
    return getData;
  }

  //Language code save/get
  void saveLanguageServer(String langCode) {
    box.write('langCode', langCode);
  }

  getLangCode() {
    var getData = box.read("langCode");
    return getData;
  }

  // Remember email and password
  void saveRememberMail(String mail) {
    box.write('mail', mail);
  }

  getRememberMail() {
    var getData = box.read("mail");
    return getData;
  }

  void saveRememberPass(String pass) {
    box.write('pass', pass);
  }

  getRememberPass() {
    var getData = box.read("pass");
    return getData;
  }

  //Home Data
  void saveHomeContent(HomeDataModel data) {
    box.write("home_content", data.toJson());
  }

  HomeDataModel? getHomeData() {
    Map<String, dynamic>? stringData = box.read("home_content");
    if (stringData != null) {
      HomeDataModel data = HomeDataModel.fromJson(stringData);
      return data;
    }
    return null;
  }

  void saveCartTrxId(String trxId) async {
    await box.write("trxId", trxId);
  }

  String? getCartTrxId() {
    String? getTrxId = box.read("trxId");
    return getTrxId != "" ? getTrxId : null;
  }

  Future saveUser(ProfileDataModel user) async {
    await box.write('user', user);
  }

  void saveForgotPasswordCode(String code) async {
    await box.write('code', code);
    //_profileContentController.update();
  }

  String? getForgotPasswordCode() {
    String? getData = box.read("code");
    return getData;
  }
}
