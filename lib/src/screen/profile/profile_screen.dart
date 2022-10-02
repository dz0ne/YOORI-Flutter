import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/_route/routes.dart';
import 'package:yoori_ecommerce/src/controllers/dashboard_controller.dart';
import 'package:yoori_ecommerce/src/controllers/profile_content_controller.dart';
import 'package:yoori_ecommerce/src/screen/profile/my_reward_screen.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/validators.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../controllers/auth_controller.dart';
import '../../data/local_data_helper.dart';
import '../../models/user_data_model.dart';
import '../../servers/repository.dart';
import '../../utils/responsive.dart';
import '../../widgets/loader/shimmer_profile_screen.dart';
import 'edit_profile_screen.dart';
import 'my_download_screen.dart';
import 'wallet/my_wallet_screen.dart';
import 'order_history_screen.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({Key? key}) : super(key: key);

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  final homeScreenController = Get.put(DashboardController());
  var emailPhoneController = TextEditingController();
  final ProfileContentController _profileContentController =
      Get.put(ProfileContentController());
  String? user=LocalDataHelper().getUserToken();

  @override
  Widget build(BuildContext context) {
    return Obx(() => _profileWithLogin(_profileContentController.user!.value));
  }

  Widget _profileWithLogin(UserDataModel userDataModel) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: userDataModel.data != null &&
                _profileContentController.profileDataModel.value.data != null
            ? ListView(
                children: [
                  SizedBox(
                    height: isMobile(context) ? 20.h : 25.h,
                  ),
                  Container(
                    height: 160.h,
                    width: MediaQuery.of(context).size.width,
                    color: const Color(0xffF8F8F8),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //SizedBox(height: 5,),
                          Container(
                            width: isMobile(context) ? 74.w : 50.w,
                            height: 74.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.w,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2.r,
                                    blurRadius: 10.r,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 5))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  userDataModel.data!.image!.toString(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "${userDataModel.data!.firstName!.toString()} ${userDataModel.data!.lastName!.toString()}",
                            style: isMobile(context)
                                ? AppThemeData.headerTextStyle_16
                                : AppThemeData.headerTextStyle_14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  userDataModel.data!.email == "" &&
                          userDataModel.data!.phone == ""
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Container(
                            transform:
                                Matrix4.translationValues(0.0, -20.0, 0.0),
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                              color: AppThemeData.lightBackgroundColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppThemeData.headlineTextColor.withOpacity(0.1),
                                  spreadRadius: 0.r,
                                  blurRadius: 30.r,
                                  offset: const Offset(
                                      0, 15), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20.r),
                              child: Column(
                                children: [
                                  userDataModel.data!.phone == ""
                                      ? const SizedBox()
                                      : Row(
                                          children: [
                                            SizedBox(
                                              height: 20.h,
                                              width: 20.w,
                                              child: SvgPicture.asset(
                                                "assets/icons/phone_color.svg",
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                                userDataModel.data!.phone!
                                                    .toString(),
                                                style: isMobile(context)
                                                    ? AppThemeData
                                                        .titleTextStyle_14
                                                    : AppThemeData
                                                        .titleTextStyle_11Tab),
                                          ],
                                        ),
                                  SizedBox(
                                    height: userDataModel.data!.phone == ""
                                        ? 0.h
                                        : 10.h,
                                  ),
                                  userDataModel.data!.email == ""
                                      ? const SizedBox()
                                      : Row(
                                          children: [
                                            SizedBox(
                                                height: 20.h,
                                                width: 20.w,
                                                child: SvgPicture.asset(
                                                    "assets/icons/email.svg")),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              userDataModel.data!.email!
                                                  .toString(),
                                              style: isMobile(context)
                                                  ? AppThemeData
                                                      .titleTextStyle_14
                                                  : AppThemeData
                                                      .titleTextStyle_11Tab,
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(7.r)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff404040).withOpacity(0.1),
                            spreadRadius: 0.r,
                            blurRadius: 6.r,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          LocalDataHelper()
                                      .getConfigData()
                                      .data!
                                      .appConfig!
                                      .walletSystem !=
                                  false
                              ? InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => MyWalletScreen(
                                          userDataModel: userDataModel,
                                        ),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    horizontalTitleGap: 0.0,
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: -4),
                                    leading: SizedBox(
                                      height: 20.h,
                                      width: 20.w,
                                      child: SvgPicture.asset(
                                          "assets/icons/wallet.svg"),
                                    ),
                                    title: Text(
                                      AppTags.myWallet.tr,
                                      style: TextStyle(
                                        fontSize:
                                            isMobile(context) ? 16.sp : 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppThemeData.descriptionTextColor,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),

                          LocalDataHelper()
                                      .getConfigData()
                                      .data!
                                      .appConfig!
                                      .walletSystem !=
                                  false
                              ? Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: const Divider(
                                    color: AppThemeData.dividerColor,
                                    thickness: 1,
                                  ),
                                )
                              : const SizedBox(),
                          //Digital Product
                          _profileContentController.profileDataModel.value.data!
                                      .isOrderedDigitalProduct !=
                                  false
                              ? InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => MyDownload(),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    horizontalTitleGap: 0.0,
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: -4),
                                    leading: SizedBox(
                                      height: 20.h,
                                      width: 20.w,
                                      child: SvgPicture.asset(
                                          "assets/icons/download.svg"),
                                    ),
                                    title: Text(
                                      AppTags.myDownload.tr,
                                      style: TextStyle(
                                        fontSize:
                                            isMobile(context) ? 16.sp : 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppThemeData.descriptionTextColor,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),

                          _profileContentController.profileDataModel.value.data!
                                      .isOrderedDigitalProduct !=
                                  false
                              ? Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: const Divider(
                                    color: AppThemeData.dividerColor,
                                    thickness: 1,
                                  ),
                                )
                              : const SizedBox(),
                          //My reward
                          for (int i = 0;
                              i <
                                  LocalDataHelper()
                                      .getConfigData()
                                      .data!
                                      .addons!
                                      .length;
                              i++)
                            LocalDataHelper()
                                            .getConfigData()
                                            .data!
                                            .addons![i]
                                            .addonIdentifier ==
                                        "reward" &&
                                    LocalDataHelper()
                                            .getConfigData()
                                            .data!
                                            .addons![i]
                                            .status ==
                                        true
                                ? InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => MyRewardScreen(
                                            userDataModel: userDataModel,
                                            conversionRate: LocalDataHelper()
                                                .getConfigData()
                                                .data!
                                                .addons![i]
                                                .addonData!
                                                .conversionRate
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      horizontalTitleGap: 0.0,
                                      visualDensity: const VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      leading: SizedBox(
                                        height: 20.h,
                                        width: 20.w,
                                        child: SvgPicture.asset(
                                            "assets/icons/reward.svg"),
                                      ),
                                      title: Text(
                                        AppTags.myRewards.tr,
                                        style: TextStyle(
                                          fontSize:
                                              isMobile(context) ? 16.sp : 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppThemeData.descriptionTextColor,
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          for (int i = 0;
                              i <
                                  LocalDataHelper()
                                      .getConfigData()
                                      .data!
                                      .addons!
                                      .length;
                              i++)
                            LocalDataHelper()
                                            .getConfigData()
                                            .data!
                                            .addons![i]
                                            .addonIdentifier ==
                                        "reward" &&
                                    LocalDataHelper()
                                            .getConfigData()
                                            .data!
                                            .addons![i]
                                            .status ==
                                        true
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    child: const Divider(
                                      color: AppThemeData.dividerColor,
                                      thickness: 1,
                                    ),
                                  )
                                : const SizedBox(),

                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                    userDataModel: _profileContentController
                                        .profileDataModel.value,
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              horizontalTitleGap: 0.0,
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              leading: SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: SvgPicture.asset(
                                    "assets/icons/edit_profile.svg"),
                              ),
                              title: Text(
                                AppTags.editProfile.tr,
                                style: TextStyle(
                                  fontSize: isMobile(context) ? 16.sp : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppThemeData.descriptionTextColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: const Divider(
                              color: AppThemeData.dividerColor,
                              thickness: 1,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              homeScreenController.changeTabIndex(3);
                            },
                            child: ListTile(
                              horizontalTitleGap: 0.0,
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              leading: SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: SvgPicture.asset(
                                    "assets/icons/favourites.svg"),
                              ),
                              title: Text(
                                AppTags.favorites.tr,
                                style: TextStyle(
                                  fontSize: isMobile(context) ? 16.sp : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppThemeData.descriptionTextColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: const Divider(
                                color: AppThemeData.dividerColor, thickness: 1),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.notificationContent);
                            },
                            child: ListTile(
                              horizontalTitleGap: 0.0,
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              leading: SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: SvgPicture.asset(
                                    "assets/icons/notification.svg"),
                              ),
                              title: Text(
                                AppTags.notification.tr,
                                style: TextStyle(
                                  fontSize: isMobile(context) ? 16.sp : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppThemeData.descriptionTextColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: const Divider(
                                color: AppThemeData.dividerColor, thickness: 1),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.trackingOrder);
                            },
                            child: ListTile(
                              horizontalTitleGap: 0.0,
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              leading: SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: SvgPicture.asset(
                                    "assets/icons/track_order.svg"),
                              ),
                              title: Text(
                                AppTags.trackOrder.tr,
                                style: TextStyle(
                                  fontSize: isMobile(context) ? 16.sp : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppThemeData.descriptionTextColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: const Divider(
                                color: AppThemeData.dividerColor, thickness: 1),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(
                                Routes.orderHistory,
                                parameters: {
                                  'routeName': RouteCheckofOrderHistory
                                      .profileScreen
                                      .toString(),
                                },
                              );
                            },
                            child: ListTile(
                              horizontalTitleGap: 0.0,
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              leading: SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: SvgPicture.asset(
                                    "assets/icons/order_history.svg"),
                              ),
                              title: Text(
                                AppTags.orderHistory.tr,
                                style: TextStyle(
                                  fontSize: isMobile(context) ? 16.sp : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppThemeData.descriptionTextColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: const Divider(
                                color: AppThemeData.dividerColor, thickness: 1),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.voucherList);
                            },
                            child: ListTile(
                              horizontalTitleGap: 0.0,
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              leading: SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: SvgPicture.asset(
                                    "assets/icons/voucher_color.svg"),
                              ),
                              title: Text(
                                AppTags.voucher.tr,
                                style: TextStyle(
                                  fontSize: isMobile(context) ? 16.sp : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppThemeData.descriptionTextColor
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: const Divider(
                                color: AppThemeData.dividerColor, thickness: 1),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.changePassword);
                            },
                            child: ListTile(
                              horizontalTitleGap: 0.0,
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              leading: SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: SvgPicture.asset(
                                    "assets/icons/change_password.svg"),
                              ),
                              title: Text(
                                AppTags.changePassword.tr,
                                style: TextStyle(
                                  fontSize: isMobile(context) ? 16.sp : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppThemeData.descriptionTextColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: const Divider(
                                color: AppThemeData.dividerColor, thickness: 1),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.settings);
                            },
                            child: ListTile(
                              horizontalTitleGap: 0.0,
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              leading: SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: SvgPicture.asset(
                                    "assets/icons/setting.svg"),
                              ),
                              title: Text(
                                AppTags.settings.tr,
                                style: TextStyle(
                                  fontSize: isMobile(context) ? 16.sp : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppThemeData.descriptionTextColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: const Divider(
                                color: AppThemeData.dividerColor, thickness: 1),
                          ),
                          InkWell(
                            onTap: () {
                              logoutDialogue();
                            },
                            child: ListTile(
                              horizontalTitleGap: 0.0,
                              visualDensity: const VisualDensity(
                                horizontal: 0,
                                vertical: -4,
                              ),
                              leading: SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child:
                                    SvgPicture.asset("assets/icons/logout.svg"),
                              ),
                              title: Text(
                                AppTags.logOut.tr,
                                style: TextStyle(
                                  fontSize: isMobile(context) ? 16.sp : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppThemeData.descriptionTextColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                    child: InkWell(
                      onTap: () {
                        accountDeleteDialogue(userDataModel);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppTags.deleteYourAccount.tr,
                            style: TextStyle(
                                fontSize: isMobile(context) ? 12.sp : 8.sp,
                                fontFamily: "Poppins",
                                color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const ShimmerProfileScreen(),
      ),
    );
  }

  logoutDialogue() {
    return AwesomeDialog(
      width: isMobile(context)
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width - 100.w,
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.NO_HEADER,
      btnOkColor: AppThemeData.okButton,
      btnCancelColor: AppThemeData.cancelButton,
      buttonsTextStyle: TextStyle(fontSize: isMobile(context) ? 13.sp : 10.sp),
      body: Center(
        child: Text(
          AppTags.doYouReallyWantToLogout.tr,
          style: isMobile(context)
              ? AppThemeData.priceTextStyle_14
              : AppThemeData.titleTextStyle_11Tab,
        ),
      ),
      btnOkOnPress: () {
        homeScreenController.changeTabIndex(0);
        AuthController.authInstance.signOut();
      },
      btnCancelOnPress: () {
        Get.back();
      },
    ).show();
  }

  accountDeleteDialogue(userDataModel) {
    return AwesomeDialog(
      width: isMobile(context)
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width - 100.w,
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.NO_HEADER,
      btnOkColor: AppThemeData.okButton,
      btnCancelColor: AppThemeData.cancelButton,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                AppTags.enterYourEmailPhoneNumberToContinue.tr,
                style: isMobile(context)
                    ? AppThemeData.priceTextStyle_14
                    : AppThemeData.titleTextStyle_11Tab,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: isMobile(context) ? 42.h : 48.h,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xffF4F4F4)),
                borderRadius: BorderRadius.all(Radius.circular(5.r)),
              ),
              child: TextField(
                style: isMobile(context)
                    ? AppThemeData.titleTextStyle_13
                    : AppThemeData.titleTextStyleTab,
                controller: emailPhoneController,
                maxLines: 1,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppTags.enterYourEmailPhone.tr,
                  hintStyle: isMobile(context)
                      ? AppThemeData.hintTextStyle_13
                      : AppThemeData.hintTextStyle_10Tab,
                  contentPadding: EdgeInsets.only(
                    left: 8.w,
                    right: 8.w,
                    bottom: 8.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      btnOkOnPress: () {
        if (emailPhoneController.text == userDataModel.data!.email! ||
            emailPhoneController.text == userDataModel.data!.phone) {
          Repository().deleteAccount().then((value) {
            if (value) {
              _profileContentController.removeUserData();
              AuthController.authInstance.signOut();
              Get.offAllNamed(Routes.logIn);
            }
          });
        } else {
          showErrorToast(AppTags.pleaseEnterCorrectEmailPhone.tr);
        }
      },
      btnCancelOnPress: () {
        Get.back();
      },
    ).show();
  }
}
