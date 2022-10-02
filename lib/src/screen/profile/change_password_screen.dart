import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/controllers/change_password_controller.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:yoori_ecommerce/src/utils/responsive.dart';
import 'package:yoori_ecommerce/src/widgets/button_widget.dart';

import '../../widgets/loader/loader_widget.dart';
import '../../widgets/login_edit_textform_field.dart';

class ChangePassword extends StatelessWidget {
 ChangePassword({Key? key}) : super(key: key);
 final currentPassController = TextEditingController();
 final newPassController = TextEditingController();
 final confirmPassController = TextEditingController();
 final ChangePasswordController _changePasswordController = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: isMobile(context)
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: const BackButton(color: Colors.black),
              centerTitle: true,
              title: Text(
                AppTags.changePassword.tr,
                style: AppThemeData.headerTextStyle_16,
              ),
            )
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 60.h,
              leadingWidth: 40.w,
              leading: const BackButton(color: Colors.black),
              centerTitle: true,
              title: Text(
                AppTags.changePassword.tr,
                style: AppThemeData.headerTextStyle_14,
              ),
            ),
      body: Obx(() =>  _changePasswordController.isLoading.value
          ? const LoaderWidget()
          : SizedBox(
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
                      Obx(() =>  LoginEditTextField(
                        myController: currentPassController,
                        keyboardType: TextInputType.text,
                        hintText: AppTags.currentPassword.tr,
                        fieldIcon: Icons.lock,
                        myobscureText: _changePasswordController.isVisibleA.value,
                        sufficon: InkWell(
                          onTap: () {
                            _changePasswordController.isVisibleUpdateA();
                          },
                          child: Icon(
                            _changePasswordController.isVisibleA.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppThemeData.iconColor,
                            //size: defaultIconSize,
                          ),
                        ),
                      )
                      ),

                      SizedBox(
                        height: 5.h,
                      ),
                      LoginEditTextField(
                        myController: newPassController,
                        keyboardType: TextInputType.text,
                        hintText: AppTags.newPassword.tr,
                        fieldIcon: Icons.lock,
                        myobscureText: _changePasswordController.isVisibleB.value,
                        sufficon: InkWell(
                          onTap: () {
                            _changePasswordController.isVisibleUpdateB();
                          },
                          child: Icon(
                            _changePasswordController.isVisibleB.value ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppThemeData.iconColor,
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
                        hintText: AppTags.confirmNewPassword.tr,
                        fieldIcon: Icons.lock,
                        myobscureText: _changePasswordController.isVisibleC.value,
                        sufficon: InkWell(
                          onTap: () {
                            _changePasswordController.isVisibleUpdateC();
                          },
                          child: Icon(
                            _changePasswordController.isVisibleC.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppThemeData.iconColor,
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
                            await _changePasswordController.changePassword(
                                currentPass: currentPassController.text,
                                newPass: newPassController.text,
                                confirmPass: confirmPassController.text);
                          },
                          child: ButtonWidget(
                              buttonTittle: AppTags.saveAndChange.tr),
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
      ),
    );
  }
}
