import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/controllers/phone_auth_controller.dart';
import 'package:yoori_ecommerce/src/servers/repository.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';

class PhoneLoginScreen extends StatelessWidget {
  PhoneLoginScreen({Key? key}) : super(key: key);

  final TextEditingController phoneController = TextEditingController();

  final PhoneAuthController phoneAuthController = Get.put(PhoneAuthController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String phoneCode = "880";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 22.5.h,
            ),
            SizedBox(
              width: 92.w,
              height: 36.h,
              child: Image.asset("assets/logos/logo.png"),
            ),
            SizedBox(
              height: 74.4.h,
            ),
            Text(
              AppTags.welcome.tr,
              style: AppThemeData.welComeTextStyle_24,
            ),
            SizedBox(
              height: 6.h,
            ),
             Text(
             AppTags.loginToContinue.tr,
              style: AppThemeData.headerPhoneTextStyle_16,
            ),
            SizedBox(
              height: 33.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
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
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: CountryPickerDropdown(
                          isFirstDefaultIfInitialValueNotProvided: false,
                          initialValue: 'BD',
                          isExpanded: true,
                          itemBuilder: (Country country) => Row(
                            children: <Widget>[
                              CountryPickerUtils.getDefaultFlagImage(country),
                              SizedBox(width: 2.w),
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
              height: 20.h,
            ),
            Obx(() => Padding(
              padding: EdgeInsets.only(right: 30.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      await phoneAuthController.phoneLogin(phoneNumber: "+$phoneCode${phoneController.text}");
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    child: SizedBox(
                      width: 48.w,
                      height: 48.h,
                      child:  CircleAvatar(
                        backgroundColor: AppThemeData.buttonColor,
                        child: phoneAuthController.isLoading.value? SvgPicture.asset("assets/icons/arrow_forward.svg"):const CircularProgressIndicator(),
                      )
                    ),
                  ),
                ],
              ),
            )
            ),
          ],
        ),
      ),
    );
  }
}
