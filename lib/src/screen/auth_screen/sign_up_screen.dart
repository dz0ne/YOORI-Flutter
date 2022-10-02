import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoori_ecommerce/config.dart';
import 'package:yoori_ecommerce/src/data/local_data_helper.dart';
import 'package:yoori_ecommerce/src/_route/routes.dart';
import 'package:yoori_ecommerce/src/controllers/auth_controller.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yoori_ecommerce/src/widgets/button_widget.dart';

import '../../servers/social_auth_service.dart';
import '../../utils/responsive.dart';
import '../../widgets/loader/loader_widget.dart';
import '../../widgets/login_edit_textform_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _ui(context),
              Obx(() => authController.isLoggingIn
                  ? const Positioned(
                  height: 50, width: 50, child: LoaderWidget())
                  : const SizedBox()),
            ],
          ),
      ),
    );
  }
  Widget _ui(context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 40.h,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 115.w,
              height: 43.h,
              //color: Colors.green,
              child: Image.asset("assets/logos/logo.png"),
            ),
            SizedBox(
              height: 32.h,
            ),
            Text(
              AppTags.welcome.tr,
              style: AppThemeData.welComeTextStyle_24,
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              AppTags.signUpToContinue.tr,
              style: AppThemeData.titleTextStyle_13,
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.h,
            ),
            LoginEditTextField(
              myController: authController.firstNameController,
              keyboardType: TextInputType.text,
              hintText: AppTags.firstName.tr,
              fieldIcon: Icons.person,
              myobscureText: false,
            ),
            SizedBox(
              height: 5.h,
            ),
            LoginEditTextField(
              myController: authController.lastNameController,
              keyboardType: TextInputType.text,
              hintText: AppTags.lastName.tr,
              fieldIcon: Icons.person,
              myobscureText: false,
            ),
            SizedBox(
              height: 5.h,
            ),
            LoginEditTextField(
              myController: authController.emailControllers,
              keyboardType: TextInputType.text,
              hintText: AppTags.emailAddress.tr,
              fieldIcon: Icons.email,
              myobscureText: false,
            ),
            SizedBox(
              height: 5.h,
            ),
            Obx(() => LoginEditTextField(
              myController: authController.passwordControllers,
              keyboardType: TextInputType.text,
              hintText: AppTags.password.tr,
              fieldIcon: Icons.lock,
              myobscureText: authController.passwordVisible.value,
              sufficon: InkWell(
                onTap: () {
                  authController.isVisiblePasswordUpdate();
                },
                child: Icon(
                  authController.passwordVisible.value ?Icons.visibility
                      : Icons.visibility_off,
                  color: const Color(0xFF666666),
                  //size: defaultIconSize,
                ),
              ),
            ),),

            SizedBox(
              height: 5.h,
            ),
            Obx(() => LoginEditTextField(
              myController: authController.confirmPasswordController,
              keyboardType: TextInputType.text,
              hintText: AppTags.confirmPassword.tr,
              fieldIcon: Icons.lock,
              myobscureText: authController.confirmPasswordVisible.value,
              sufficon: InkWell(
                onTap: () {
                  authController.isVisibleConfirmPasswordUpdate();
                },
                child: Icon(
                  authController.confirmPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: const Color(0xFF666666),
                  //size: defaultIconSize,
                ),
              ),
            )),

            SizedBox(
              height: 34.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: InkWell(
                onTap: () {
                  authController.signUp(
                    firstName: authController.firstNameController.text,
                    lastName: authController.lastNameController.text,
                    email: authController.emailControllers.text,
                    password: authController.passwordControllers.text,
                    confirmPassword: authController.confirmPasswordController.text,
                  );
                },
                child: ButtonWidget(buttonTittle: AppTags.signUp.tr),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.dashboardScreen);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/arrow_back.svg"),
                  SizedBox(
                    width: 5.h,
                  ),
                  Text(
                    AppTags.backToShopping.tr,
                    style: isMobile(context)? AppThemeData.categoryTitleTextStyle_12:AppThemeData.categoryTitleTextStyle_9Tab,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google login button
                  Config.enableGoogleLogin
                      ? Container(
                        height: 48.h,
                        width: 48.w,
                        margin: EdgeInsets.only(right: 15.w),
                        decoration: BoxDecoration(
                          color: const Color(0xffF7F7F7),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: InkWell(
                          onTap: () => authController.signInWithGoogle(),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.all(12.r),
                            child:
                            SvgPicture.asset("assets/icons/google.svg"),
                          ),
                        ),
                      )
                      : const SizedBox(),
                  //facebook login button
                  Config.enableFacebookLogin
                      ? Container(
                        height: 48.h,
                        width: 48.w,
                        margin: EdgeInsets.only(right: 15.w),
                        decoration: BoxDecoration(
                          color: const Color(0xffF7F7F7),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: InkWell(
                          onTap: () {
                            authController.facebookLogin();
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.all(12.r),
                            child:
                            SvgPicture.asset("assets/icons/facebook.svg"),
                          ),
                        ),
                      )
                      : const SizedBox(),
                  Platform.isIOS
                      ? Container(
                        height: 48.h,
                        width: 48.w,
                        margin: EdgeInsets.only(right: 15.w),
                        decoration: BoxDecoration(
                          color: const Color(0xffF7F7F7),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: InkWell(
                          onTap: () {
                            SocialAuth().signInWithApple();
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.all(12.r),
                            child: SvgPicture.asset(
                                "assets/icons/apple_logo.svg"),
                          ),
                        ),
                      )
                      : Container(),
                      LocalDataHelper().isPhoneLoginEnabled()
                      ? Container(
                        height: 48.h,
                        width: 48.w,
                        decoration: BoxDecoration(
                            color: const Color(0xffF7F7F7),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.phoneRegistration);
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.all(12.r),
                            child: SvgPicture.asset(
                                "assets/icons/phone_login.svg"),
                          ),
                        ),
                      ): const SizedBox(),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppTags.iHaveAnAccount.tr,
                  style: AppThemeData.qsTextStyle_12,
                ),
                InkWell(
                    onTap: () {
                      Get.toNamed(Routes.logIn);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 10.w,
                        top: 10.h,
                        bottom: 10.h,
                      ),
                      child: Text(
                        AppTags.signIn.tr,
                        style: AppThemeData.qsboldTextStyle_12,
                      ),
                    ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                AppTags.signUpTermsAndCondition.tr,
                textAlign: TextAlign.center,
                style: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ],
    );
  }
}

