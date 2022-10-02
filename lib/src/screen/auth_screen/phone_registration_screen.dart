import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/servers/repository.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';

import '../../controllers/phone_auth_controller.dart';
import '../../widgets/login_edit_textform_field.dart';


class PhoneRegistrationScreen extends StatelessWidget {
  PhoneRegistrationScreen({Key? key}) : super(key: key);
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final PhoneAuthController phoneAuthController = Get.put(PhoneAuthController());

  @override
  Widget build(BuildContext context) {
    String phoneCode = "880";
    return Scaffold(
      body: SizedBox(
        width: 375.w,
        height: 812.h,
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            SizedBox(
              width: 115.w,
              height: 43.h,
              child: Image.asset("assets/logos/logo.png"),
            ),
            SizedBox(
              height: 50.h,
            ),
            LoginEditTextField(
              myController: firstNameController,
              keyboardType: TextInputType.text,
              hintText: AppTags.firstName.tr,
              fieldIcon: Icons.person,
              myobscureText: false,
            ),
            SizedBox(
              height: 5.h,
            ),
            LoginEditTextField(
              myController: lastNameController,
              keyboardType: TextInputType.text,
              hintText: AppTags.lastName.tr,
              fieldIcon: Icons.person,
              myobscureText: false,
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF404040).withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 30,
                      offset: const Offset(0, 15), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: CountryPickerDropdown(
                          isFirstDefaultIfInitialValueNotProvided: false,
                          initialValue: 'BD',
                          isExpanded: true,
                          itemBuilder: (Country country) => Row(
                            children: <Widget>[
                              CountryPickerUtils.getDefaultFlagImage(country),
                              Text("+${country.phoneCode}"),
                            ],
                          ),
                          onValuePicked: (Country country) {
                            phoneCode = country.phoneCode;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 11,
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppTags.phone.tr,
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Obx(() =>  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () async {
                    await phoneAuthController.phoneRegistration(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        phoneNumber: "+$phoneCode${phoneController.text}");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppThemeData.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: phoneAuthController.isLoading.value? Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      AppTags.getOTP.tr,
                      style: AppThemeData.buttonTextStyle_14,
                    ),
                  ): const CircularProgressIndicator(),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
