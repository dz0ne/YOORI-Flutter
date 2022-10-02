import 'package:get/get.dart';
import '../screen/dashboard/dashboard_screen.dart';
import '../servers/repository.dart';

class PhoneAuthController extends GetxController{
  var isLoading = true.obs;

  
  Future phoneLogin({String? phoneNumber})async{
    isLoading.value = false;
    await Repository().postPhoneLogin(phoneNumber: phoneNumber)
        .then((value){
      isLoading.value = value!;
    });
    isLoading.value = true;
  }

  Future phoneRegistration({String? firstName, String? lastName,String? phoneNumber})async {
    isLoading.value = false;
    await Repository().postPhoneRegistration(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    ).then((value) {
      isLoading.value = value!;
    });
    isLoading.value = true;
  }

  Future phoneLoginSendOtp({String? phoneNumber,String? otp}) async{
    isLoading.value= false;
    await Repository().postPhoneLoginOTP(
        phoneNumber: phoneNumber, otp: otp)
        .then((value){
      if(value!){
        Get.offAll(() => DashboardScreen());
      }
      isLoading.value = true;
    });
  }

  Future phoneRegistrationSendOtp({String? phoneNumber,String? otp})async{
    isLoading.value= false;
    await Repository().postPhoneRegistrationOTP(
    phoneNumber: phoneNumber, otp: otp) .then((value){

        isLoading.value = true;
    });
  }
}