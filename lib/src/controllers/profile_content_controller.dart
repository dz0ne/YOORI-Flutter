import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/models/user_data_model.dart';
import 'package:yoori_ecommerce/src/data/local_data_helper.dart';

import '../models/profile_data_model.dart';
import '../servers/repository.dart';

class ProfileContentController extends GetxController {
  Rx<UserDataModel>? user = UserDataModel().obs;
  final LocalDataHelper _helper = LocalDataHelper();
  final isUserLoggedIn = false.obs;

  @override
  void onInit() {
    getUserData();
    getProfileData();
    super.onInit();
  }

  Rx<ProfileDataModel> profileDataModel = ProfileDataModel().obs;
  Future getProfileData() async {
    Repository().getProfileData().then((homeData) {
      if (homeData != null) {
        profileDataModel.value = homeData;
      }
    });
  }

  getUserData() {
    UserDataModel? dataModel = _helper.getUserAllData();
    if (dataModel != null) {
      user?.value = dataModel;
    }
    isUserLoggedIn.value = _helper.getUserToken() != null;
  }

  updateUserData(UserDataModel userDataModel) {
    _helper.saveUserAllData(userDataModel);
    user!.value = userDataModel;
    update();
  }

  removeUserData() {
    _helper.box.remove("userModel");
    _helper.box.remove("userToken");
    _helper.box.remove("trxId");
    _helper.box.remove("phoneUser");
    getUserData();
    update();
  }
}
