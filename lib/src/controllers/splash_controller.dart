import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yoori_ecommerce/src/_route/routes.dart';
import 'package:yoori_ecommerce/src/servers/repository.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/data/local_data_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashController extends GetxController {
  var isLoading = true.obs;
  PackageInfo? packageInfo;
  String? appName;
  String? packageName;
  String? appVersion;
  String? configVersion;
  String? buildNumber;
  String? whatsNew;
  bool? updateSkippable;
  String? url;

  @override
  void onInit() async {
    super.onInit();
    packageInfo = await PackageInfo.fromPlatform().then(
      (value) {
        appName = value.appName;
        packageName = value.packageName;
        appVersion = value.version;
        buildNumber = value.buildNumber;
        return null;
      },
    );
    handleConfigData();
  }

  void handleConfigData() async {
    return Repository().getConfigData().then((configModel) {
      configVersion = Platform.isAndroid
          ? configModel.data!.androidVersion!.apkVersion
          : Platform.isIOS
              ? configModel.data!.iosVersion!.ipaVersion
              : "";

      whatsNew = Platform.isAndroid
          ? configModel.data!.androidVersion!.whatsNew
          : Platform.isIOS
              ? configModel.data!.iosVersion!.whatsNew
              : "";

      if (Platform.isAndroid) {
        if (configModel.data!.androidVersion!.apkFileUrl != null) {
          url = configModel.data!.androidVersion!.apkFileUrl!;
        }
      } else if (Platform.isIOS) {
        if (configModel.data!.iosVersion!.ipaFileUrl != null) {
          url = configModel.data!.iosVersion!.ipaFileUrl!;
        }
      }
      updateSkippable = Platform.isAndroid
          ? configModel.data!.androidVersion!.isSkippable!
          : Platform.isIOS
              ? configModel.data!.iosVersion!.isSkippable!
              : true;
      LocalDataHelper().saveConfigData(configModel).then((value) {
        showDialogue();
        isLoading(false);
      });
    });
  }

  Future<void> navigate() async {
    Timer(
      const Duration(seconds: 1),
      () {
        LocalDataHelper().getConfigData().data!.appConfig!.loginMandatory!
            ? LocalDataHelper().getUserToken() != null
                ? Get.offAllNamed(
                    Routes.dashboardScreen,
                  )
                : Get.offAllNamed(
                    Routes.dashboardScreen,
                  )
            : Get.offAllNamed(
                Routes.dashboardScreen,
              );
      },
    );
  }

  showDialogue() {
    if (configVersion == null) {
      navigate();
    } else {
      if (appVersion != configVersion) {
        Platform.isIOS ? appUpdateDialogueIos() : appUpdateDialogueAndroid();
      } else {
        navigate();
      }
    }
  }

  appUpdateDialogueIos() {
    showCupertinoDialog(
      context: Get.context!,
      builder: (context) => CupertinoAlertDialog(
        title: const Center(
          child: Text('Update Available'),
        ),
        content: Column(
          children: [
            Text(
                "You can now update this app from $appVersion to $configVersion"),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                whatsNew != null
                    ? const Text(
                        "What's New",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                whatsNew != null
                    ? Text(
                        whatsNew!,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child:
                      Text(updateSkippable != null ? 'May be Later' : 'Cancel'),
                  onPressed: () {
                    if (updateSkippable != null) {
                      updateSkippable!
                          ? navigate()
                          : SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop');
                    } else {
                      navigate();
                    }
                  },
                ),
                SizedBox(
                  width: 10.w,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () {
                    if (url != null) {
                      launchUrl(Uri.parse(url!));
                    } else {
                      Get.showSnackbar(GetSnackBar(
                        backgroundColor: Colors.red,
                        message: AppTags.somethingWentWrong.tr,
                        maxWidth: 200,
                        duration: const Duration(seconds: 3),
                        snackStyle: SnackStyle.FLOATING,
                        margin: const EdgeInsets.all(10),
                        borderRadius: 5,
                        isDismissible: true,
                        dismissDirection: DismissDirection.horizontal,
                      ));
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  appUpdateDialogueAndroid() {
    showCupertinoDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text('Update Available'),
        ),
        content: SizedBox(
          height: 250.h,
          child: Column(
            children: [
              Text(
                  "You can now update this app from $appVersion to $configVersion"),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  whatsNew != null
                      ? const Text(
                          "What's New",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  whatsNew != null
                      ? Text(
                          whatsNew!,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: Text(
                        updateSkippable != null ? 'May be Later' : 'Cancel'),
                    onPressed: () {
                      if (updateSkippable != null) {
                        updateSkippable!
                            ? navigate()
                            : SystemChannels.platform
                                .invokeMethod('SystemNavigator.pop');
                      } else {
                        navigate();
                      }
                    },
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () {
                      if (url != null) {
                        launchUrl(Uri.parse(url!));
                      } else {
                        Get.showSnackbar(GetSnackBar(
                          backgroundColor: Colors.red,
                          message: AppTags.somethingWentWrong.tr,
                          maxWidth: 200,
                          duration: const Duration(seconds: 3),
                          snackStyle: SnackStyle.FLOATING,
                          margin: const EdgeInsets.all(10),
                          borderRadius: 5,
                          isDismissible: true,
                          dismissDirection: DismissDirection.horizontal,
                        ));
                      }
                    },
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
