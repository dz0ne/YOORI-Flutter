import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:yoori_ecommerce/src/widgets/button_widget.dart';

import '../../controllers/forgot_password_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/login_edit_textform_field.dart';


class SetNewPasswordScreen extends StatelessWidget {
  final String? email;
  final String? code;
  final String? otp;
  SetNewPasswordScreen({Key? key,this.email, this.code,this.otp}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final ForgotPasswordController setForgotPassController = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar:isMobile(context)? AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        title: Text(
          AppTags.setPassword.tr,
          style: AppThemeData.headerTextStyle_16,
        ),
      ): AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60.h,
        leadingWidth: 40.w,
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
        title: Text(
          AppTags.setPassword.tr,
          style: AppThemeData.headerTextStyle_14,
        ),
      ),
      body:Obx(()=>Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    LoginEditTextField(
                      isReadonly: true,
                      myController: emailController,
                      keyboardType: TextInputType.text,
                      hintText: email,
                      fieldIcon: Icons.email,
                      myobscureText: false,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    LoginEditTextField(
                      myController: passwordController,
                      keyboardType: TextInputType.text,
                      hintText: AppTags.password.tr,
                      fieldIcon: Icons.lock,
                      myobscureText: setForgotPassController.isVisibleA.value,
                      sufficon: InkWell(
                        onTap: () {
                          setForgotPassController.isVisibleA();
                        },
                        child: Icon(
                          setForgotPassController.isVisibleA.value ? Icons.visibility:Icons.visibility_off,
                          color: const Color(0xFF666666),
                          //size: defaultIconSize,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    LoginEditTextField(
                      myController: confirmPassController,
                      keyboardType: TextInputType.text,
                      hintText: AppTags.confirmPassword.tr,
                      fieldIcon: Icons.lock,
                      myobscureText: setForgotPassController.isVisibleB.value,
                      sufficon: InkWell(
                        onTap: () {
                          setForgotPassController.isVisibleB();
                        },
                        child: Icon(
                          setForgotPassController.isVisibleB.value ? Icons.visibility:Icons.visibility_off,
                          color: const Color(0xFF666666),
                          //size: defaultIconSize,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: InkWell(
                        onTap: () async {
                          setForgotPassController.isLoader.value;
                          setForgotPassController.setNewPassword(code: code,
                            email: email,
                            otp: otp,
                            password: passwordController.text,
                            confirmPassword: confirmPassController.text);
                        },
                        child: ButtonWidget(buttonTittle: AppTags.saveAndChange.tr),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
          setForgotPassController.isLoader.value?const SizedBox():
          const Positioned(
              child: CircularProgressIndicator()
          )
        ],
      )),
    );
  }
}

