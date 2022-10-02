import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/config.dart';
import 'package:yoori_ecommerce/src/_route/routes.dart';
import 'package:yoori_ecommerce/src/controllers/auth_controller.dart';
import 'package:yoori_ecommerce/src/controllers/details_screen_controller.dart';
import 'package:yoori_ecommerce/src/controllers/dashboard_controller.dart';
import 'package:yoori_ecommerce/src/servers/social_auth_service.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/data/local_data_helper.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yoori_ecommerce/src/widgets/button_widget.dart';

import '../../utils/responsive.dart';
import '../../widgets/loader/loader_widget.dart';
import '../../widgets/login_edit_textform_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final homeScreenController = Get.put<DashboardController>;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Obx(
          () => Stack(
            alignment: Alignment.center,
            children: [
              _ui(context),
              authController.isLoggingIn
                  ? Positioned(
                      height: 50.h,
                      width: 50.w,
                      child: const LoaderWidget(),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget _ui(context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 50.h,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 115.w,
              height: 43.h,
              child: Image.asset("assets/logos/logo.png"),
            ),
            SizedBox(
              height: 42.h,
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
              style: AppThemeData.titleTextStyle_13,
            )
          ],
        ),
        Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              LoginEditTextField(
                myController: authController.emailController,
                keyboardType: TextInputType.text,
                hintText: AppTags.emailAddress.tr,
                fieldIcon: Icons.email,
                myobscureText: false,
              ),
              SizedBox(
                height: 5.h,
              ),
              Obx(
                () => LoginEditTextField(
                  myController: authController.passwordController,
                  keyboardType: TextInputType.text,
                  hintText: AppTags.password.tr,
                  fieldIcon: Icons.lock,
                  myobscureText: authController.isVisible.value,
                  sufficon: InkWell(
                    onTap: () {
                      authController.isVisibleUpdate();
                    },
                    child: Icon(
                      authController.isVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color(0xFF666666),
                    ),
                  ),
                ),
              ),
              Container(
                padding:  EdgeInsets.only(right: 30.w, left: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Obx(() => Row(
                          children: [
                            Checkbox(
                              value: authController.isValue.value,
                              checkColor: Colors.white,
                              activeColor: Colors.green,
                              focusColor: const Color(0xff333333),
                              onChanged: (value) {
                                authController.isValueUpdate(value);
                              },
                            ),
                            Text(
                              AppTags.rememberMe.tr,
                                style: isMobile(context)? AppThemeData.categoryTitleTextStyle_12:AppThemeData.categoryTitleTextStyle_9Tab

                            )
                          ],
                        )),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.forgetPassword);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Text(
                          AppTags.forgotPassword.tr,
                          style: isMobile(context)? AppThemeData.forgotTextStyle_12:AppThemeData.todayDealNewStyle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: InkWell(
                  onTap: () async {
                    authController.loginWithEmailPassword(
                        email: authController.emailController!.text,
                        password: authController.passwordController!.text);

                    if (authController.isValue.value) {
                      LocalDataHelper().saveRememberMail(
                          authController.emailController!.text.toString());
                      LocalDataHelper().saveRememberPass(
                          authController.passwordController!.text.toString());
                    } else {
                      LocalDataHelper().box.remove("mail");
                      LocalDataHelper().box.remove("pass");
                    }
                    Get.delete<DetailsPageController>();
                  },
                  child: ButtonWidget(buttonTittle: AppTags.signIn.tr),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.dashboardScreen);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/arrow_back.svg",height: 10.h,width: 10.w,),
                     SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      AppTags.backToShopping.tr,
                      style: isMobile(context)? AppThemeData.backToHomeTextStyle_12:AppThemeData.categoryTitleTextStyle_9Tab,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 53.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
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
                              onTap: () {
                                authController.signInWithGoogle();
                              },
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

                    //apple login
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
                        : Container(
                            color: Colors.red,
                            height: 10.h,
                          ),
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
                              child: SvgPicture.asset(
                                  "assets/icons/facebook.svg"),
                            ),
                          ),
                        )
                        : const SizedBox(),
                    LocalDataHelper().isPhoneLoginEnabled()
                        ? Container(
                          height: 48.h,
                          width: 48.w,
                          margin: EdgeInsets.only(right: 15.w),
                          decoration: BoxDecoration(
                            color: const Color(0xffF7F7F7),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,

                            onTap: () {
                              Get.toNamed(
                                Routes.phoneLoginScreen,
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(12.r),
                              child: SvgPicture.asset(
                                  "assets/icons/phn_login.svg"),
                            ),
                          ),
                        )
                        : const SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppTags.newUser.tr,
                    style: AppThemeData.qsTextStyle_12,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.signUp);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 10.w,
                        top: 10.h,
                        bottom: 10.h,
                      ),
                      child: Text(
                        " ${AppTags.signUp.tr}",
                        style: AppThemeData.qsboldTextStyle_12,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  AppTags.signInTermsAndCondition.tr,
                  textAlign: TextAlign.center,
                  style: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
