import 'package:get/get.dart';

import '../data/local_data_helper.dart';
import '../screen/auth_screen/login_screen.dart';
import '../screen/auth_screen/set_new_password_screen.dart';
import '../servers/repository.dart';

class ForgotPasswordController extends GetxController {
  var isValue = false.obs;
  var isLoader = true.obs;

  var isVisibleA = true.obs;
  var isVisibleB = true.obs;


  isVisibleUpdateA() {
    isVisibleA.value = !isVisibleA.value;
  }
  isVisibleUpdateB() {
    isVisibleB.value = !isVisibleB.value;
  }

  Future forgotPasswordSendOtp({String? email}) async {
    isLoader.value=false;
    await Repository().postForgetPasswordGetData(email: email).then((value) {
      isValue.value = value.success!;
      isLoader.value = true;
    });
  }

  Future forgotPasswordConfirmSentOtp({String? email, String? otp}) async {
    isLoader.value=false;
    await Repository()
        .postForgetPasswordConfirmOTP(email: email, otp: otp)
        .then((value) {
      if (value!) {
        Get.off(SetNewPasswordScreen(
            email: email,
            otp: otp,
            code: LocalDataHelper().getForgotPasswordCode()));
        isLoader.value = true;
      }else{
        isLoader.value = true;
      }
    });
  }

  Future setNewPassword({
    String? code,
    String? email,
    String? password,
    String? confirmPassword,
    String? otp
  }) async{
    isLoader.value=false;
    await Repository()
        .postForgetPassword(
      code: code,
      email: email,
      otp: otp,
      password: password,
      confirmPassword: confirmPassword)
        .then((value) {
      if(value!=true){
        Get.off(LoginScreen());
        isLoader.value = true;
      }else{
        isLoader.value = true;
      }
    });
  }
}