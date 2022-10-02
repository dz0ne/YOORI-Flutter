import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yoori_ecommerce/config.dart';
import 'package:yoori_ecommerce/src/_route/routes.dart';
import 'package:yoori_ecommerce/src/controllers/currency_converter_controller.dart';
import 'package:yoori_ecommerce/src/controllers/setting_controller.dart';
import 'package:yoori_ecommerce/src/controllers/language_controller.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../data/local_data_helper.dart';
import '../../../utils/responsive.dart';
import 'address_screen.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);
  final isUserLoggedIn = false;
  final isNotificationOn = false;
  final selectedLanguage = "English";
  final isDark = true;

  final controller = Get.put(LanguageController());
  final settingController = Get.put(SettingController());
  final currencyConverterController = Get.find<CurrencyConverterController>();

  @override
  Widget build(BuildContext context) {
    controller.getAppLanguageList();
    return Scaffold(
      appBar:isMobile(context)? AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          AppTags.settings.tr,
          style: AppThemeData.settingsTitleStyle,
        ),
      ): AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 60.h,
      leadingWidth: 40.w,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 25.r,
        ),

        onPressed: () {
          Get.back();
        }, // null disables the button
      ),
      centerTitle: true,
      title: Text(
        AppTags.settings.tr,
        style: AppThemeData.headerTextStyle_14,
      ),
    ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppTags.languages.tr,
                    style: isMobile(context)? AppThemeData.settingsTitleStyle:AppThemeData.settingsTitleStyleTab,
                  ),
                  Center(
                    child: Obx(
                      () => DropdownButton(
                        isExpanded: false,
                        value: controller.locale.value,
                        icon: const Icon(Icons.arrow_drop_down_outlined),
                        style:isMobile(context)? AppThemeData.settingsTitleStyle:AppThemeData.settingsTitleStyleTab,
                        iconSize: 24.r,
                        underline: const SizedBox(),
                        hint: SizedBox(
                          width: 100.w,
                          child: Center(
                            child: Text(
                              selectedLanguage,
                            ),
                          ),
                        ),
                        onChanged: (String? newValue) {
                          controller.updateLocale(newValue!);
                        },
                        items: controller.optionsLocales.entries.map(
                          (item) {
                            return DropdownMenuItem<String>(
                              value: item.key,
                              child: Text(
                                item.value['description'],
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppTags.notification.tr,
                    style: isMobile(context)? AppThemeData.settingsTitleStyle:AppThemeData.settingsTitleStyleTab,
                  ),
                  Center(
                    child: Obx(
                      () => FlutterSwitch(
                        width:  isMobile(context)? 40.w:25.w,
                        height: 20.h,
                        valueFontSize: 20,
                        toggleSize: 20.r,
                        borderRadius: 30.r,
                        padding: 1.0,
                        showOnOff: false,
                        toggleColor: settingController.isToggle.value
                            ? AppThemeData.lightBackgroundColor
                            : Colors.white,
                        activeColor: Colors.green,
                        inactiveColor: Colors.grey,
                        value: settingController.isToggle.value,
                        onToggle: (value) {
                          settingController.toggle();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTags.currency.tr,
                      style: isMobile(context)? AppThemeData.settingsTitleStyle:AppThemeData.settingsTitleStyleTab,
                    ),
                    Container(
                      height: 42.h,
                      alignment: Alignment.center,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          iconSize: isMobile(context)?18.r:25.r,
                          isExpanded: false,
                          style: isMobile(context)? AppThemeData.settingsTitleStyle:AppThemeData.settingsTitleStyleTab,
                          value: settingController.selectedCurrency.value,
                          onChanged: (newValue) {
                            int index = settingController.getIndex(newValue);
                            settingController.updateCurrency(newValue);
                            settingController.updateCurrencyName(index);
                            LocalDataHelper().saveCurrency(
                                settingController.selectedCurrency.value);
                            currencyConverterController.fetchCurrencyData();
                          },
                          items: settingController.curr!.map(
                            (curr) {
                              return DropdownMenuItem(
                                value: curr.code,
                                child: Text(curr.name.toString()),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const Divider(
                color: Color(0xffD8D8D8),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: isMobile(context)? 0.w:10.w,vertical: isMobile(context)? 0.h:8.h),
              child: InkWell(
                onTap: () {
                  if (Platform.isAndroid) {
                    Share.share(
                        "https://play.google.com/store/apps/details?id=${settingController.packageInfo!.packageName}");
                  } else if (Platform.isIOS) {
                    Share.share("https://google.com");
                  }
                },
                child: ListTile(
                  title: Text(
                    AppTags.shareThisApp.tr,
                    style: isMobile(context)? AppThemeData.settingsTitleStyle:AppThemeData.settingsTitleStyleTab,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 18.r,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile(context)? 0.w:10.w,vertical: isMobile(context)? 0.h:8.h),
              child: InkWell(
                onTap: () {
                 Get.to(const Addresses());
                },
                child:  ListTile(
                  title: Text(
                    AppTags.address.tr,
                    style: isMobile(context)? AppThemeData.settingsTitleStyle:AppThemeData.settingsTitleStyleTab,
                  ),
                  trailing:  Icon(
                    Icons.arrow_forward_ios,
                    size: 18.r,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile(context)? 0.w:10.w,vertical: isMobile(context)? 0.h:8.h),
              child: InkWell(
                onTap: () {
                  StoreRedirect.redirect(
                    androidAppId: settingController.packageInfo!.packageName,
                    iOSAppId: Config.iosAppId,
                  );
                },
                child: ListTile(
                  title: Text(
                    AppTags.rateThisApp.tr,
                    style: isMobile(context)? AppThemeData.settingsTitleStyle:AppThemeData.settingsTitleStyleTab,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 18.r,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const Divider(
                color:  Color(0xffD8D8D8),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile(context)? 0.w:10.w,vertical: isMobile(context)? 0.h:8.h),
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    Routes.wvScreen,
                    parameters: {
                      'url':
                          LocalDataHelper().getConfigData().data!.pages![3].link!,
                      'title': LocalDataHelper()
                          .getConfigData()
                          .data!
                          .pages![3]
                          .title!,
                    },
                  );
                },
                child: ListTile(
                  title: Text(
                    AppTags.termsCondition.tr,
                    style: isMobile(context)? AppThemeData.settingsTitleStyle:AppThemeData.settingsTitleStyleTab,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 18.r,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile(context)? 0.w:10.w,vertical: isMobile(context)? 0.h:8.h),
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    Routes.wvScreen,
                    parameters: {
                      'url':
                          LocalDataHelper().getConfigData().data!.pages![4].link!,
                      'title': LocalDataHelper()
                          .getConfigData()
                          .data!
                          .pages![4]
                          .title!,
                    },
                  );
                },
                child: ListTile(
                  title: Text(
                    AppTags.privacyPolicy.tr,
                    style: isMobile(context)? AppThemeData.settingsTitleStyle:AppThemeData.settingsTitleStyleTab,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 18.r,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile(context)? 0.w:10.w,vertical: isMobile(context)? 0.h:8.h),
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    Routes.wvScreen,
                    parameters: {
                      'url':
                          LocalDataHelper().getConfigData().data!.pages![5].link!,
                      'title': LocalDataHelper()
                          .getConfigData()
                          .data!
                          .pages![5]
                          .title!,
                    },
                  );
                },
                child: ListTile(
                  title: Text(
                    AppTags.aboutThisApp.tr,
                    style: isMobile(context)? AppThemeData.settingsTitleStyle:AppThemeData.settingsTitleStyleTab,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 18.r,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile(context)? 0.w:10.w,vertical: isMobile(context)? 0.h:8.h),
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    Routes.wvScreen,
                    parameters: {
                      'url':
                          LocalDataHelper().getConfigData().data!.pages![6].link!,
                      'title': LocalDataHelper()
                          .getConfigData()
                          .data!
                          .pages![6]
                          .title!,
                    },
                  );
                },
                child: ListTile(
                  title: Text(
                    AppTags.contactUS.tr,
                    style: isMobile(context)? AppThemeData.settingsTitleStyle:AppThemeData.settingsTitleStyleTab,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 18.r,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
