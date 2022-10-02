

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yoori_ecommerce/src/_route/routes.dart';
import 'package:yoori_ecommerce/src/controllers/cart_content_controller.dart';
import 'package:yoori_ecommerce/src/controllers/color_selection_controller.dart';
import 'package:yoori_ecommerce/src/controllers/currency_converter_controller.dart';
import 'package:yoori_ecommerce/src/controllers/details_screen_controller.dart';
import 'package:yoori_ecommerce/src/controllers/favourite_controller.dart';
import 'package:yoori_ecommerce/src/controllers/home_screen_controller.dart';
import 'package:yoori_ecommerce/src/controllers/dashboard_controller.dart';
import 'package:yoori_ecommerce/src/models/product_details_model.dart';
import 'package:yoori_ecommerce/src/screen/home/product_details/details_image_view_screen.dart';
import 'package:yoori_ecommerce/src/servers/repository.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yoori_ecommerce/src/data/local_data_helper.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:yoori_ecommerce/src/utils/validators.dart';
import 'package:yoori_ecommerce/src/widgets/wholesale_data_widget.dart';

import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/loader/shimmer_details_page.dart';
import '../../dashboard/dashboard_screen.dart';
import 'product_description.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({Key? key}) : super(key: key);
  final titleController = TextEditingController();
  final writeReviewController = TextEditingController();
  final writeReviewReplyController = TextEditingController();
  final currencyConverterController = Get.find<CurrencyConverterController>();
  final cartContentController = Get.find<CartContentController>();
  final homeScreenContentController = Get.put(HomeScreenController());
  final homeScreenController = Get.put(DashboardController());
  final detailsController = Get.put(DetailsPageController());
  final _favouriteController = Get.find<FavouriteController>();
  final _cartController = Get.find<CartContentController>();
  final _colorSelectionController = Get.put(ColorSelectionController());

  final productId = Get.parameters['productId'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<DetailsPageController>(
      builder: (controller) {
        return controller.isLoading.value
            ? const Center(child: ShimmerDetailsPage())
            : _detailsPageUI(controller.productDetail.value, context);
      },
    ));
  }

  mobileAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          if (detailsController.isFavorite.value !=
              detailsController.isFavoriteLocal.value) {
            _favouriteController.addOrRemoveFromFav(productId);
          }
          Get.back();
        },
      ),
      centerTitle: true,
      title: Text(
        AppTags.productDetails.tr,
        style: AppThemeData.headerTextStyle_16,
      ),
      actions: [
        Row(
          children: [
            SizedBox(
              height: 30.h,
              width: 30.w,
              child: Obx(
                () => InkWell(
                  onTap: () {
                    homeScreenController.changeTabIndex(2);
                    Get.offAll(
                      DashboardScreen(),
                      transition: Transition.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 700),
                    );
                    if (_favouriteController.token != null) {
                      if (detailsController.isFavorite.value !=
                          detailsController.isFavoriteLocal.value) {
                        _favouriteController.addOrRemoveFromFav(productId);
                        printLog('favourite added');
                      }
                    }
                  },
                  child: Badge(
                    animationDuration: const Duration(milliseconds: 300),
                    animationType: BadgeAnimationType.slide,
                    badgeContent: Text(
                      cartContentController
                          .addToCartListModel.data!.carts!.length
                          .toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/shopping_bag.svg",
                      color: AppThemeData.headlineTextColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Obx(
              () => Material(
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () async {
                    if (_favouriteController.token != null) {
                      detailsController.isFavoriteLocalUpdate();
                    } else {
                      Get.snackbar(
                        AppTags.login.tr,
                        AppTags.pleaseLoginFirst.tr,
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 3),
                        colorText: Colors.white,
                        backgroundColor: Colors.black,
                        forwardAnimationCurve: Curves.decelerate,
                        shouldIconPulse: false,
                      );
                    }
                  },
                  child: Container(
                    height: 30.h,
                    width: 30.w,
                    margin: EdgeInsets.all(7.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppThemeData.boxShadowColor.withOpacity(0.13),
                          spreadRadius: 1,
                          blurRadius: 10.r,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(7.r),
                      child: detailsController.isFavoriteLocal.value
                          ? SvgPicture.asset("assets/icons/heart_on.svg")
                          : SvgPicture.asset("assets/icons/heart_off.svg"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  tabAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      toolbarHeight: 60.h,
      leadingWidth: 40.w,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: 25.r,
          color: Colors.black,
        ),
        onPressed: () {
          if (detailsController.isFavorite.value !=
              detailsController.isFavoriteLocal.value) {
            _favouriteController.addOrRemoveFromFav(productId);
          }
          Get.back();
        },
      ),
      centerTitle: true,
      title: Text(
        AppTags.productDetails.tr,
        style: AppThemeData.whyUsTextStyle_13,
      ),
      actions: [
        Row(
          children: [
            SizedBox(
              height: 30.h,
              width: 30.w,
              child: Obx(
                () => InkWell(
                  onTap: () {
                    homeScreenController.changeTabIndex(2);
                    Get.offAll(
                      DashboardScreen(),
                      transition: Transition.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 700),
                    );
                    if (_favouriteController.token != null) {
                      if (detailsController.isFavorite.value !=
                          detailsController.isFavoriteLocal.value) {
                        _favouriteController.addOrRemoveFromFav(productId);
                        printLog('favourite added');
                      }
                    }
                  },
                  child: Badge(
                    padding: EdgeInsets.all(4.r),
                    animationDuration: const Duration(milliseconds: 300),
                    animationType: BadgeAnimationType.slide,
                    badgeContent: Text(
                      cartContentController
                          .addToCartListModel.data!.carts!.length
                          .toString(),
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/shopping_bag.svg",
                      height: 20.h,
                      width: 20.w,
                      color: AppThemeData.headlineTextColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 5.w),
            Obx(
              () => Material(
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () async {
                    if (_favouriteController.token != null) {
                      detailsController.isFavoriteLocalUpdate();
                    } else {
                      Get.snackbar(
                        AppTags.login.tr,
                        AppTags.pleaseLoginFirst.tr,
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 3),
                        colorText: Colors.white,
                        backgroundColor: Colors.black,
                        forwardAnimationCurve: Curves.decelerate,
                        shouldIconPulse: false,
                      );
                    }
                  },
                  child: Container(
                    height: 30.h,
                    width: 30.w,
                    margin: EdgeInsets.all(7.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppThemeData.boxShadowColor.withOpacity(0.13),
                          spreadRadius: 1,
                          blurRadius: 10.r,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: detailsController.isFavoriteLocal.value
                          ? SvgPicture.asset("assets/icons/heart_on.svg")
                          : SvgPicture.asset("assets/icons/heart_off.svg"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _detailsPageUI(ProductDetailsModel detailsModel, context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: isMobile(context) ? mobileAppbar() : tabAppbar(),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  //image Slide
                  LimitedBox(
                    maxHeight: 200.h,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        InkWell(
                          onTap: (){
                            Get.to(DetailsImageViewScreen(productDetailsModel: detailsController.productDetail.value,));
                          },
                          child: PageView.builder(
                            itemCount: detailsModel.data!.images!.length,
                            controller: detailsController.pageController,
                            onPageChanged: (index) {
                              detailsController.itemCounterUpdate(index);
                            },
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: Image.network(
                                    detailsModel.data!.images![index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        //Discount Percentage
                        Positioned(
                          top: 0.h,
                          left: 20.w,
                          child: Padding(
                            padding: EdgeInsets.all(5.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    detailsModel.data!.specialDiscountType ==
                                            'flat'
                                        ? double.parse(detailsModel
                                                    .data!.specialDiscount) ==
                                                0.000
                                            ? const SizedBox()
                                            : Container(
                                                height: 20.h,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFF51E46)
                                                      .withOpacity(0.06),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(3.r),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "${currencyConverterController.convertCurrency(detailsModel.data!.specialDiscount)} OFF",
                                                    style: isMobile(context)
                                                        ? AppThemeData
                                                            .todayDealNewStyle
                                                        : AppThemeData
                                                            .todayDealNewStyleTab,
                                                  ),
                                                ),
                                              )
                                        : detailsModel.data!
                                                    .specialDiscountType ==
                                                'percentage'
                                            ? double.parse(detailsModel.data!
                                                        .specialDiscount) ==
                                                    0.000
                                                ? const SizedBox()
                                                : Container(
                                                    height: 20.h,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                              0xFFF51E46)
                                                          .withOpacity(0.06),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(3.r),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "${homeScreenContentController.removeTrailingZeros(detailsModel.data!.specialDiscount)}% OFF",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: isMobile(context)
                                                            ? AppThemeData
                                                                .todayDealNewStyle
                                                            : AppThemeData
                                                                .todayDealNewStyleTab,
                                                      ),
                                                    ),
                                                  )
                                            : Container(),
                                  ],
                                ),
                                detailsModel.data!.specialDiscount == 0
                                    ? const SizedBox()
                                    : SizedBox(width: 5.w),
                                detailsModel.data!.currentStock == 0
                                    ? Container(
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF51E46)
                                              .withOpacity(0.06),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(3.r),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            AppTags.stockOut.tr,
                                            style: isMobile(context)
                                                ? AppThemeData.todayDealNewStyle
                                                : AppThemeData
                                                    .todayDealNewStyleTab,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        Obx(
                          () => Positioned(
                            left: 20.w,
                            bottom: 0,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppThemeData.buttonTextColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.r),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 16.r,
                                    color: AppThemeData.headlineTextColor
                                        .withOpacity(0.01),
                                    offset: const Offset(0, 1),
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3.h, horizontal: 8.w),
                                child: Text(
                                  "${detailsController.productImageNumber.value + 1}/${detailsModel.data!.images!.length}",
                                  style: isMobile(context)
                                      ? AppThemeData.orderHistoryTextStyle_12
                                      : AppThemeData.orderHistoryTextStyle_9Tab,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  //Timer CountDown
                  Container(
                    child: detailsModel.data!.specialDiscountEnd!.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.h),
                            child: CountdownTimer(
                                endTime: detailsModel
                                            .data!.specialDiscountEnd !=
                                        null
                                    ? DateTime.now().millisecondsSinceEpoch +
                                        DateTime.parse(detailsModel
                                                .data!.specialDiscountEnd!)
                                            .difference(DateTime.now())
                                            .inMilliseconds
                                    : DateTime.now().microsecondsSinceEpoch,
                                widgetBuilder: (_, time) {
                                  if (time == null) {
                                    return Center(
                                      child: Text(
                                        AppTags.campaignOver.tr,
                                        style: isMobile(context)
                                            ? AppThemeData.timeDateTextStyle_12
                                            : AppThemeData.timeDateTextStyleTab,
                                      ),
                                    );
                                  } else {
                                    return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 44.w,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffF51E46)
                                                  .withOpacity(0.10),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(3.r)),
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${time.days ?? 0}"
                                                      .padLeft(2, "0"),
                                                  style: isMobile(context)
                                                      ? AppThemeData
                                                          .timeDateTextStyle_13
                                                      : AppThemeData
                                                          .timeDateTextStyle_10Tab,
                                                ),
                                                Text(
                                                  AppTags.days.tr,
                                                  style: isMobile(context)
                                                      ? AppThemeData
                                                          .timeDateTextStyle_10
                                                      : AppThemeData
                                                          .timeDateTextStyle_8Tab,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          Container(
                                            width: 44.w,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffF51E46)
                                                  .withOpacity(0.10),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(3.r)),
                                              boxShadow: [
                                                BoxShadow(
                                                  spreadRadius: 30.r,
                                                  blurRadius: 5.r,
                                                  color: AppThemeData
                                                      .boxShadowColor
                                                      .withOpacity(0.01),
                                                  offset: const Offset(0, 15),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${time.hours ?? 0}"
                                                      .padLeft(2, "0"),
                                                  style: isMobile(context)
                                                      ? AppThemeData
                                                          .timeDateTextStyle_13
                                                      : AppThemeData
                                                          .timeDateTextStyle_10Tab,
                                                ),
                                                Text(
                                                  AppTags.hrs.tr,
                                                  style: isMobile(context)
                                                      ? AppThemeData
                                                          .timeDateTextStyle_10
                                                      : AppThemeData
                                                          .timeDateTextStyle_8Tab,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          Container(
                                            width: 44.w,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffF51E46)
                                                  .withOpacity(0.10),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(3.r)),
                                              boxShadow: [
                                                BoxShadow(
                                                  spreadRadius: 30.r,
                                                  blurRadius: 5.r,
                                                  color: AppThemeData
                                                      .boxShadowColor
                                                      .withOpacity(0.01),
                                                  offset: const Offset(0, 15),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  " ${time.min ?? 0}"
                                                      .padLeft(2, "0"),
                                                  style: isMobile(context)
                                                      ? AppThemeData
                                                          .timeDateTextStyle_13
                                                      : AppThemeData
                                                          .timeDateTextStyle_10Tab,
                                                ),
                                                Text(
                                                  AppTags.minutes.tr,
                                                  style: isMobile(context)
                                                      ? AppThemeData
                                                          .timeDateTextStyle_10
                                                      : AppThemeData
                                                          .timeDateTextStyle_8Tab,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          Container(
                                            width: 44.w,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffF51E46)
                                                  .withOpacity(0.10),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(3.r)),
                                              boxShadow: [
                                                BoxShadow(
                                                  spreadRadius: 30.r,
                                                  blurRadius: 5.r,
                                                  color: AppThemeData
                                                      .boxShadowColor
                                                      .withOpacity(0.01),
                                                  offset: const Offset(0, 15),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${time.sec ?? 0}"
                                                      .padLeft(2, "0"),
                                                  style: isMobile(context)
                                                      ? AppThemeData
                                                          .timeDateTextStyle_13
                                                      : AppThemeData
                                                          .timeDateTextStyle_10Tab,
                                                ),
                                                Text(
                                                  AppTags.secs.tr,
                                                  style: isMobile(context)
                                                      ? AppThemeData
                                                          .timeDateTextStyle_10
                                                      : AppThemeData
                                                          .timeDateTextStyle_8Tab,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]);
                                  }
                                }),
                          )
                        : Container(),
                  ),
                  SizedBox(height: 20.h),

                  //Product Details
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.5.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 30.r,
                            blurRadius: 5.r,
                            color:
                                AppThemeData.boxShadowColor.withOpacity(0.01),
                            offset: const Offset(0, 15),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Resting Product Tittle
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    detailsModel.data!.title.toString(),
                                    maxLines: 2,
                                    style: isMobile(context)
                                        ? AppThemeData.labelTextStyle_16
                                        : AppThemeData.labelTextStyle_12tab,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  height: isMobile(context) ? 18.h : 28.h,
                                  width: isMobile(context) ? 40.w : 60.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffFFFFFF),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.r)),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 0,
                                          blurRadius: 10,
                                          color: AppThemeData.boxShadowColor
                                              .withOpacity(0.1),
                                          offset: const Offset(0, 1))
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      isMobile(context)
                                          ? SvgPicture.asset(
                                              "assets/icons/reting_icon.svg")
                                          : SvgPicture.asset(
                                              "assets/icons/reting_icon.svg",
                                              width: 15.w,
                                              height: 15.h),
                                      SizedBox(width: 4.w),
                                      Text(
                                        detailsModel.data!.rating.toString(),
                                        style: AppThemeData.reatingTextStyle_12,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 13.h),

                            // Price Increment/Decrement
                            detailsModel.data!.isClassified!
                                ? Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xffF4F4F4),
                                      ),
                                      color: const Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(3.r),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 10.w),
                                        SvgPicture.asset(
                                            "assets/icons/details_call_button.svg"),
                                        SizedBox(width: 32.w),
                                        Obx(
                                          () => InkWell(
                                            onTap: () {
                                              detailsController
                                                  .isObsecureUpdate();
                                            },
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    detailsController
                                                            .isObsecure.value
                                                        ? "XXXXXXXXXXX"
                                                        : detailsModel
                                                            .data!
                                                            .classifiedContactInfo!
                                                            .phone
                                                            .toString(),
                                                    style: AppThemeData
                                                        .detailsScreenPhoneNumber,
                                                  ),
                                                  Text(
                                                    AppTags
                                                        .clickHereToSeePhone.tr,
                                                    style: AppThemeData
                                                        .detailsScreenPhoneNumberShow,
                                                  ),
                                                ]),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      detailsModel.data!.specialDiscount ==
                                              "0.000"
                                          ? Row(
                                              children: [
                                                Text(
                                                  "${currencyConverterController.convertCurrency(detailsModel.data!.price)}",
                                                  style: isMobile(context)
                                                      ? AppThemeData
                                                          .seccessfulPayTextStyle_18
                                                      : AppThemeData
                                                          .headerTextStyle_14,
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Text(
                                                  "${currencyConverterController.convertCurrency(detailsModel.data!.discountPrice)}",
                                                  style: isMobile(context)
                                                      ? AppThemeData
                                                          .seccessfulPayTextStyle_18
                                                      : AppThemeData
                                                          .headerTextStyle_14,
                                                ),
                                                SizedBox(width: 5.w),
                                                Text(
                                                  "${currencyConverterController.convertCurrency(detailsModel.data!.price)}",
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: isMobile(context)
                                                        ? 14.sp
                                                        : 11.sp,
                                                    fontFamily: "Poppins",
                                                  ),
                                                ),
                                              ],
                                            ),
                                      detailsModel.data!.isCatalog!
                                          ? const SizedBox()
                                          : Obx(
                                              () => SizedBox(
                                                width: 75.w,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        detailsController
                                                            .decrementProductQuantity();
                                                      },
                                                      child: Container(
                                                        height: 23.h,
                                                        width: 23.w,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xffF4F4F4),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          3.r)),
                                                        ),
                                                        child: Icon(
                                                            Icons.remove,
                                                            size: 16.r),
                                                      ),
                                                    ),
                                                    AnimatedSwitcher(
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      transitionBuilder:
                                                          (Widget child,
                                                              Animation<double>
                                                                  animation) {
                                                        return ScaleTransition(
                                                          scale: animation,
                                                          child: child,
                                                        );
                                                      },
                                                      child: Text(
                                                        detailsController
                                                            .productQuantity
                                                            .value
                                                            .toString(),
                                                        style: isMobile(context)
                                                            ? const TextStyle()
                                                            : AppThemeData
                                                                .labelTextStyle_12tab
                                                                .copyWith(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontSize: 13.sp,
                                                              ),
                                                        key: ValueKey(
                                                            detailsController
                                                                .productQuantity
                                                                .value),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        detailsController
                                                            .incrementProductQuantity();
                                                      },
                                                      child: Container(
                                                          height: 23.h,
                                                          width: 23.w,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0xffF4F4F4),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  3.r),
                                                            ),
                                                          ),
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 16.r,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                            SizedBox(height: 20.h),

                            // Delivery Time
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xffF4F4F4),
                                ),
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3.r),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("${AppTags.delivery.tr}:",
                                            style: isMobile(context)
                                                ? AppThemeData.titleTextStyle_13
                                                : AppThemeData
                                                    .titleTextStyleTab),
                                        SizedBox(width: 5.w),
                                        Text(
                                          "${detailsModel.data!.delivery.toString()} days, ${detailsModel.data!.returnData.toString()} days return",
                                          style: isMobile(context)
                                              ? AppThemeData.titleTextStyle_13
                                              : AppThemeData.titleTextStyleTab,
                                        ),
                                      ],
                                    ),
                                    // const Icon(Icons.arrow_forward_ios_rounded,size: 16,color:  Color(0xff999999))
                                  ],
                                ),
                              ),
                            ),
                            detailsModel.data!.hasVariant!
                                ? SizedBox(height: 10.h)
                                : const SizedBox(),

                            //Color Attribute
                            detailsModel.data!.hasVariant!
                                ? Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xffF4F4F4),
                                          ),
                                          color: const Color(0xffFFFFFF),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(3.r),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.w),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${AppTags.color.tr}:",
                                                    style: isMobile(context)
                                                        ? AppThemeData
                                                            .whyUsTextStyle_13
                                                        : AppThemeData
                                                            .whyUsTextStyle_10Tab,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5.h),
                                              SizedBox(
                                                height: 35.h,
                                                child: ListView.builder(
                                                    itemCount: detailsModel
                                                        .data!.colors!.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          _colorSelectionController
                                                              .changeColorSelection(
                                                            index: index,
                                                            colorName:
                                                                detailsModel
                                                                    .data!
                                                                    .colors![
                                                                        index]
                                                                    .name
                                                                    .toString(),
                                                            colorId:
                                                                detailsModel
                                                                    .data!
                                                                    .colors![
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                          );
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10.w),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: Color(int.parse("0xff${detailsModel.data!.colors![index].hexCode.toString()}") == AppThemeData.colorWhite ?
                                                                AppThemeData.colorBlack: int.parse("0xff${detailsModel.data!.colors![index].hexCode.toString()}")),
                                                              ),
                                                              borderRadius: BorderRadius.all(
                                                                Radius.circular(5.r),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.all(4.r),
                                                              child: Obx(() =>
                                                                  Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            int.parse("0xff${detailsModel.data!.colors![index].hexCode.toString()}")),
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius.circular(
                                                                              5.r),
                                                                        ),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.4),
                                                                            spreadRadius:
                                                                                0.5,
                                                                            blurRadius:
                                                                                0.4,
                                                                            offset:
                                                                                const Offset(0, 0), // changes position of shadow
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      height:
                                                                          28.h,
                                                                      width: isMobile(
                                                                              context)
                                                                          ? 25.w
                                                                          : 18
                                                                              .w,
                                                                      child: _colorSelectionController.selectedIndex.value ==
                                                                              index
                                                                          ? Padding(
                                                                          padding: EdgeInsets.all(6.r),
                                                                          child: SvgPicture.asset(
                                                                          "assets/icons/confirm.svg",color: Color(
                                                                            int.parse("0xff${detailsModel.data!.colors![index].hexCode.toString()}")==
                                                                                AppThemeData.colorWhite ?
                                                                            AppThemeData.colorBlack:AppThemeData.colorWhite),
                                                                        ),
                                                                      )
                                                                          : const SizedBox())
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Container(
                                        alignment: Alignment.center,
                                        child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: detailsModel
                                              .data!.attributes!.length,
                                          itemBuilder: (context, i) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 8.h),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xffF4F4F4),
                                                  ),
                                                  color:
                                                      const Color(0xffFFFFFF),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(3.r),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8.h,
                                                      horizontal: 8.w),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${detailsModel.data!.attributes![i].title!.toString()}:",
                                                        style: AppThemeData
                                                            .whyUsTextStyle_13,
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      SizedBox(
                                                        height: 24.h,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 15.w),
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: detailsModel
                                                              .data!
                                                              .attributes![i]
                                                              .attributeValue!
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          8.w),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  _colorSelectionController
                                                                      .changeAttrSelection(
                                                                          attrIndex:
                                                                              i,
                                                                          value:
                                                                              index);
                                                                  _colorSelectionController.insertAttrNameToList(
                                                                      name: detailsModel
                                                                          .data!
                                                                          .attributes![
                                                                              i]
                                                                          .attributeValue![
                                                                              index]
                                                                          .value!,
                                                                      index: i);
                                                                  _colorSelectionController.insertAttrIdToList(
                                                                      id: detailsModel
                                                                          .data!
                                                                          .attributes![
                                                                              i]
                                                                          .attributeValue![
                                                                              index]
                                                                          .id!
                                                                          .toString(),
                                                                      index: i);
                                                                },
                                                                child: Obx(() =>
                                                                    Container(
                                                                        height: 24
                                                                            .h,
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border:
                                                                              Border.all(
                                                                            color: _colorSelectionController.selectedArray[i] == index
                                                                                ? const Color(0xffF51E46)
                                                                                : const Color(0xffF4F4F4),
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.all(
                                                                            Radius.circular(3.r),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 8.w),
                                                                          child:
                                                                              Text(
                                                                            detailsModel.data!.attributes![i].attributeValue![index].value!,
                                                                            style: _colorSelectionController.selectedArray[i] == index
                                                                                ? isMobile(context)
                                                                                    ? AppThemeData.detwailsScreenBottomSheetTitle.copyWith(color: const Color(0xffF51E46))
                                                                                    : AppThemeData.detailsScreenBottomSheetTitleTab.copyWith(color: const Color(0xffF51E46))
                                                                                : isMobile(context)
                                                                                    ? AppThemeData.detwailsScreenBottomSheetTitle
                                                                                    : AppThemeData.detailsScreenBottomSheetTitleTab,
                                                                          ),
                                                                        ))),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            SizedBox(height: 10.h),
                            //Specification
                            detailsModel.data!.isClassified!
                                ? const SizedBox()
                                : Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xffF4F4F4),
                                      ),
                                      color: const Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3.r)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.r),
                                      child: Column(
                                        children: [
                                          Obx(
                                            () => InkWell(
                                              onTap: () async {
                                                detailsController.openFile(
                                                    detailsModel
                                                        .data!.specifications);
                                                detailsController
                                                    .isSpecificUpdate();
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      "${AppTags.specifications.tr}:",
                                                      style: isMobile(context)
                                                          ? AppThemeData
                                                              .titleTextStyle_14
                                                          : AppThemeData
                                                              .titleTextStyle_11Tab),
                                                  detailsController
                                                          .isSpecific.value
                                                      ? Icon(Icons.remove,
                                                          size: 16.r,
                                                          color: const Color(
                                                              0xff999999))
                                                      : Icon(Icons.add,
                                                          size: 16.r,
                                                          color: const Color(
                                                              0xff999999))
                                                ],
                                              ),
                                            ),
                                          ),
                                          Obx(
                                            () => detailsController
                                                    .isSpecific.value
                                                ? Column(
                                                    children: [
                                                      detailsModel
                                                              .data!
                                                              .specifications!
                                                              .isNotEmpty
                                                          ? SizedBox(
                                                              height: 400.h,
                                                              child: SfPdfViewer
                                                                  .network(detailsModel
                                                                      .data!
                                                                      .specifications!
                                                                      .toString()),
                                                            )
                                                          : Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.r),
                                                              child: Text(
                                                                AppTags
                                                                    .noSpecifications
                                                                    .tr,
                                                                style: AppThemeData
                                                                    .labelTextStyle_12tab
                                                                    .copyWith(
                                                                        fontFamily:
                                                                            "Poppins"),
                                                              ),
                                                            )
                                                    ],
                                                  )
                                                : Row(),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                            SizedBox(height: 10.h),

                            //Description
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xffF4F4F4),
                                ),
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3.r),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Column(
                                  children: [
                                    Obx(
                                      () => InkWell(
                                        onTap: () {
                                          detailsController.isDeliveryUpdate();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${AppTags.description.tr}:",
                                              style: isMobile(context)
                                                  ? AppThemeData
                                                      .titleTextStyle_14
                                                  : AppThemeData
                                                      .titleTextStyle_11Tab,
                                            ),
                                            detailsController
                                                    .isDescription.value
                                                ? Icon(Icons.remove,
                                                    size: 16.r,
                                                    color:
                                                        const Color(0xff999999))
                                                : Icon(
                                                    Icons.add,
                                                    size: 16.r,
                                                    color:
                                                        const Color(0xff999999),
                                                  )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () =>
                                          detailsController.isDescription.value
                                              ? Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 4.h,
                                                    ),
                                                    detailsModel.data!.details!
                                                            .isNotEmpty
                                                        ? SizedBox(
                                                            height: 400.h,
                                                            child:
                                                                ProductDescription(
                                                              details:
                                                                  detailsModel
                                                                      .data!
                                                                      .details!,
                                                            ),
                                                          )
                                                        : Text(
                                                            AppTags
                                                                .noDescription
                                                                .tr,
                                                          ),
                                                  ],
                                                )
                                              : const SizedBox(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),

                            //wholesale Data Table
                            detailsController
                                    .productDetail.value.data!.isWholesale
                                ? Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xffF4F4F4),
                                      ),
                                      color: const Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(3.r),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.r),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(AppTags.minQtn.tr,
                                                      style: isMobile(context)
                                                          ? AppThemeData
                                                              .titleTextStyle_13
                                                          : AppThemeData
                                                              .titleTextStyleTab),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(AppTags.maxQtn.tr,
                                                      style: isMobile(context)
                                                          ? AppThemeData
                                                              .titleTextStyle_13
                                                          : AppThemeData
                                                              .titleTextStyleTab),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(AppTags.price.tr,
                                                      style: isMobile(context)
                                                          ? AppThemeData
                                                              .titleTextStyle_13
                                                          : AppThemeData
                                                              .titleTextStyleTab),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Flexible(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: detailsController
                                                  .productDetail
                                                  .value
                                                  .data!
                                                  .wholesalePrices!.length,
                                              itemBuilder: (context, index) =>
                                                  WholesaleDataWidget(
                                                wholesalePrice:
                                                    detailsController
                                                            .productDetail
                                                            .value
                                                            .data!
                                                            .wholesalePrices![
                                                        index],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            detailsController
                                    .productDetail.value.data!.isWholesale
                                ? SizedBox(height: 10.h)
                                : const SizedBox(),

                            //Why Us section
                            detailsController.hassleFree.value
                                ? Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xffF4F4F4),
                                      ),
                                      color: const Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(3.r),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.r),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 4.w,
                                                    right: 8.w,
                                                    top: 4.h),
                                                child: Container(
                                                    height: 16.h,
                                                    width: 16.w,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      //color: const Color(0xff56A8C7),
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xffD16D86)),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(20.r),
                                                      ),
                                                    ),
                                                    child: Icon(
                                                      Icons.check,
                                                      size: 12.r,
                                                      color: const Color(
                                                          0xffD16D86),
                                                    )),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      AppTags
                                                          .hassleFreeReturns.tr,
                                                      style: isMobile(context)
                                                          ? AppThemeData
                                                              .whyUsTextStyle_13
                                                          : AppThemeData
                                                              .whyUsTextStyle_10Tab,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  Text(AppTags.returnPolicy.tr,
                                                      style: isMobile(context)
                                                          ? AppThemeData
                                                              .titleTextStyle_13
                                                          : AppThemeData
                                                              .titleTextStyleTab,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 4.w,
                                                    right: 8.w,
                                                    top: 4.h),
                                                child: Container(
                                                    height: 16.h,
                                                    width: 16.w,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      //color: const Color(0xff56A8C7),
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xffD16D86)),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(20.r),
                                                      ),
                                                    ),
                                                    child: Icon(
                                                      Icons.check,
                                                      size: 12.r,
                                                      color: const Color(
                                                          0xffD16D86),
                                                    )),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      AppTags
                                                          .hassleFreeReturns.tr,
                                                      style: isMobile(context)
                                                          ? AppThemeData
                                                              .whyUsTextStyle_13
                                                          : AppThemeData
                                                              .whyUsTextStyle_10Tab,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  Text(AppTags.returnPolicy.tr,
                                                      style: isMobile(context)
                                                          ? AppThemeData
                                                              .titleTextStyle_13
                                                          : AppThemeData
                                                              .titleTextStyleTab,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            detailsController.hassleFree.value
                                ? SizedBox(
                                    height: 10.h,
                                  )
                                : const SizedBox(),

                            //Card section
                            detailsController.groupProduct.value
                                ? Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xffF4F4F4),
                                      ),
                                      color: const Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(3.r),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.r),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  height: 44.h,
                                                  width: 44.w,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffF5F5F5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5.r),
                                                    ),
                                                  ),
                                                  child: Icon(
                                                    Icons.image,
                                                    size: 30.r,
                                                  )),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.w),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "Classic T-shirt Sleeves and Formal",
                                                          style: isMobile(
                                                                  context)
                                                              ? AppThemeData
                                                                  .whyUsTextStyle_13
                                                              : AppThemeData
                                                                  .whyUsTextStyle_10Tab,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("\$230.00",
                                                              style: AppThemeData
                                                                  .priceTextStyle_13),
                                                          Container(
                                                              height: 24.h,
                                                              width: 80.w,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                //color: const Color(0xff56A8C7),
                                                                border: Border.all(
                                                                    color: const Color(
                                                                        0xffF4F4F4)),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          3.r),
                                                                ),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Icon(
                                                                      Icons
                                                                          .remove,
                                                                      size:
                                                                          14.r,
                                                                      color: AppThemeData.headlineTextColor,),
                                                                  const Text(
                                                                      "1"),
                                                                  Icon(
                                                                    Icons.add,
                                                                    size: 14.r,
                                                                    color: AppThemeData
                                                                        .headlineTextColor,
                                                                  ),
                                                                ],
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  height: 44.h,
                                                  width: 44.w,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffF5F5F5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5.r),
                                                    ),
                                                  ),
                                                  child: Icon(
                                                    Icons.image,
                                                    size: 30.r,
                                                  )),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.w),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "Classic T-shirt Sleeves and Formal",
                                                          style: isMobile(
                                                                  context)
                                                              ? AppThemeData
                                                                  .whyUsTextStyle_13
                                                              : AppThemeData
                                                                  .whyUsTextStyle_10Tab,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("\$230.00",
                                                              style: AppThemeData
                                                                  .priceTextStyle_13),
                                                          Container(
                                                              height: 24.h,
                                                              width: 80.w,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                //color: const Color(0xff56A8C7),
                                                                border: Border.all(
                                                                    color: const Color(
                                                                        0xffF4F4F4)),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          3.r),
                                                                ),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .remove,
                                                                    size: 14.r,
                                                                    color: AppThemeData
                                                                        .headlineTextColor,
                                                                  ),
                                                                  const Text(
                                                                      "1"),
                                                                  Icon(
                                                                    Icons.add,
                                                                    size: 14.r,
                                                                    color: AppThemeData
                                                                        .headlineTextColor,
                                                                  ),
                                                                ],
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            detailsController.groupProduct.value
                                ? SizedBox(height: 10.h)
                                : const SizedBox(),

                            //Refund section
                            LocalDataHelper().isRefundAddonAvailable()
                                ? Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xffF4F4F4),
                                      ),
                                      color: const Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(3.r),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.r),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 44.h,
                                                width: 44.w,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  //color: Color(0xffF5F5F5),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5.r),
                                                  ),
                                                ),
                                                child: LocalDataHelper()
                                                    .getRefundIcon(),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    LocalDataHelper()
                                                                    .getRefundAddon() !=
                                                                null &&
                                                            LocalDataHelper()
                                                                    .getRefundAddon()!
                                                                    .addonData !=
                                                                null
                                                        ? LocalDataHelper()
                                                            .getRefundAddon()!
                                                            .addonData!
                                                            .title!
                                                        : "",
                                                    style: isMobile(context)
                                                        ? AppThemeData
                                                            .titleTextStyle_13
                                                        : AppThemeData
                                                            .titleTextStyleTab,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                      LocalDataHelper()
                                                                      .getRefundAddon() !=
                                                                  null &&
                                                              LocalDataHelper()
                                                                      .getRefundAddon()!
                                                                      .addonData !=
                                                                  null
                                                          ? LocalDataHelper()
                                                              .getRefundAddon()!
                                                              .addonData!
                                                              .subTitle!
                                                          : "",
                                                      style: isMobile(context)
                                                          ? AppThemeData
                                                              .whyUsTextStyle_13
                                                          : AppThemeData
                                                              .whyUsTextStyle_10Tab,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            LocalDataHelper().isRefundAddonAvailable()
                                ? SizedBox(height: 10.h)
                                : const SizedBox(),
                            SizedBox(
                              height: 10.h,
                            ),
                            //Social shear
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xffF4F4F4),
                                ),
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3.r),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              Routes.wvScreen,
                                              parameters: {
                                                'url': detailsModel
                                                    .data!.links!.facebook
                                                    .toString(),
                                                'title': "Facebook",
                                              },
                                            );
                                          },
                                          child: Container(
                                            height:
                                                isMobile(context) ? 38.h : 40.h,
                                            width:
                                                isMobile(context) ? 38.w : 40.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffF5F5F5),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5.r),
                                              ),
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/icons/details/facebook.svg",
                                              height: 15.h,
                                              width: 8.w,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              Routes.wvScreen,
                                              parameters: {
                                                'url': detailsModel
                                                    .data!.links!.linkedin
                                                    .toString(),
                                                'title': "Linkedin",
                                              },
                                            );
                                          },
                                          child: Container(
                                            height:
                                                isMobile(context) ? 38.h : 40.h,
                                            width:
                                                isMobile(context) ? 38.w : 40.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffF5F5F5),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5.r),
                                              ),
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/icons/details/linkedin.svg",
                                              height: 14.h,
                                              width: 14.w,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.h),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              Routes.wvScreen,
                                              parameters: {
                                                'url': detailsModel
                                                    .data!.links!.twitter
                                                    .toString(),
                                                'title': "Twitter",
                                              },
                                            );
                                          },
                                          child: Container(
                                            height:
                                                isMobile(context) ? 38.h : 40.h,
                                            width:
                                                isMobile(context) ? 38.w : 40.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffF5F5F5),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5.r),
                                              ),
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/icons/details/twitter.svg",
                                              height: 14.h,
                                              width: 17.w,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              Routes.wvScreen,
                                              parameters: {
                                                'url': detailsModel
                                                    .data!.links!.whatsapp
                                                    .toString(),
                                                'title': "WhatsApp",
                                              },
                                            );
                                          },
                                          child: Container(
                                            height:
                                                isMobile(context) ? 38.h : 40.h,
                                            width:
                                                isMobile(context) ? 38.w : 40.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffF5F5F5),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5.r),
                                              ),
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/icons/details/whatsapp.svg",
                                              height: 17.h,
                                              width: 17.w,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //Review
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.5.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 30.r,
                              blurRadius: 5.r,
                              color:
                                  AppThemeData.boxShadowColor.withOpacity(0.01),
                              offset: const Offset(0, 15))
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${AppTags.review.tr} (${detailsModel.data!.reviews!.length})",
                                  style: isMobile(context)
                                      ? AppThemeData.priceTextStyle_14
                                      : AppThemeData.labelTextStyle_12tab,
                                ),
                                InkWell(
                                    onTap: () {
                                      if (_favouriteController.token != null) {
                                        showModalBottomSheet(
                                          //expand: true,
                                          context: context,
                                          enableDrag: true,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) => Material(
                                            child: SafeArea(
                                              top: false,
                                              child: Padding(
                                                padding: EdgeInsets.only(top: 20,  right: 20,  left: 20,
                                                    bottom: MediaQuery.of(context).viewInsets.bottom),
                                                child: buildSheet(
                                                    detailsModel, context),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        Get.snackbar(
                                          AppTags.login.tr,
                                          AppTags.pleaseLoginFirst.tr,
                                          snackPosition: SnackPosition.BOTTOM,
                                          duration: const Duration(seconds: 3),
                                          colorText: Colors.white,
                                          backgroundColor: Colors.black,
                                          forwardAnimationCurve: Curves.decelerate,
                                          shouldIconPulse: false,
                                        );
                                      }
                                    },
                                    child: Text(
                                      detailsModel.data!.isReviewed!? "Edit Review":AppTags.writeReview.tr,
                                      style: isMobile(context)
                                          ? AppThemeData.writeReviewTextStyle_13
                                          : AppThemeData
                                              .detailsScreenPhoneNumberShow,
                                    ),
                                ),
                              ],
                            ),
                            //Review Product
                            detailsModel.data!.reviews!.isNotEmpty
                                ? reviewWidget(detailsModel, context)
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Add to Cart Button

            detailsModel.data!.isClassified!
                ? const SizedBox()
                : detailsModel.data!.isCatalog!
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 7.5.h),
                        child: InkWell(
                          onTap: () {
                            launchUrl(
                              Uri.parse(
                                  detailsModel.data!.catalogExternalLink!),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: ButtonWidget(
                              buttonTittle: AppTags.learnMore.tr,
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 15.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 48.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                  border: Border.all(
                                    color: AppThemeData.headlineTextColor,
                                    width: 1.r,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4.r),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(() => RichText(
                                            text: TextSpan(
                                              text: "${AppTags.total.tr}: ",
                                              style: isMobile(context)
                                                  ? AppThemeData
                                                      .detailsScreenTotal
                                                  : AppThemeData
                                                      .detailsScreenTotalTab,
                                              children: [
                                                TextSpan(
                                                  text:
                                                      currencyConverterController
                                                          .convertCurrency(
                                                              detailsController
                                                                  .totalPrice
                                                                  .toString()),
                                                  style: isMobile(context)
                                                      ? AppThemeData
                                                          .detailsScreenTotalPrice
                                                      : AppThemeData
                                                          .detailsScreenTotalPriceTab,
                                                ),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15.w),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  if(detailsModel.data!.hasVariant!){
                                    if (_colorSelectionController
                                        .selectedAttrId.value !=
                                        "" &&
                                        _colorSelectionController
                                            .selectedAttrName.value !=
                                            "") {
                                      if (!_colorSelectionController
                                          .selectedAttrId.value
                                          .contains("**") &&
                                          !_colorSelectionController
                                              .selectedAttrName.value
                                              .contains("**")) {
                                        _cartController.addToCart(
                                          productId: productId.toString(),
                                          quantity: detailsController
                                              .productQuantity
                                              .toString(),
                                          variantsIds: _colorSelectionController
                                              .selectedAttrId.value,
                                          variantsNames: _colorSelectionController
                                              .selectedAttrName.value,
                                        );
                                      }else{
                                        showCustomSnackBar(AppTags.selectAttr.tr,
                                            isError: true);
                                      }
                                    } else {
                                      showCustomSnackBar(AppTags.selectAttr.tr,
                                          isError: true);
                                    }
                                  }else{
                                    _cartController.addToCart(
                                      productId: productId.toString(),
                                      quantity: detailsController
                                          .productQuantity
                                          .toString(),
                                      variantsIds: _colorSelectionController
                                          .selectedAttrId.value,
                                      variantsNames: _colorSelectionController
                                          .selectedAttrName.value,
                                    );
                                  }
                                },
                                child: Container(
                                  height: 48.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppThemeData.headlineTextColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.r),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(4.r),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10.r),
                                          child: SvgPicture.asset(
                                            "assets/icons/sopping_bag.svg",
                                            height: 15.h,
                                            width: 13.w,
                                          ),
                                        ),
                                        Text(
                                          AppTags.addToCart.tr,
                                          style: isMobile(context)
                                              ? AppThemeData.buttonTextStyle_14
                                              : AppThemeData
                                                  .buttonTextStyle_11Tab,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );
  }


  Widget reviewWidget(detailsModel, context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: detailsModel.data!.reviews!.length,
        itemBuilder: (_, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Row(
                children: [
                  Container(
                    width: 35.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.w,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 5))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(detailsModel
                                .data!.reviews![index].user!.image
                                .toString()))),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              detailsModel.data!.reviews![index].user!.name
                                  .toString(),
                              style: isMobile(context)
                                  ? AppThemeData.titleTextStyle_14
                                  : AppThemeData.titleTextStyle_11Tab,
                            ),
                            Text(
                              detailsModel.data!.reviews![index].date
                                  .toString(),
                              style: isMobile(context)
                                  ? AppThemeData.dateTextStyle_12
                                  : AppThemeData.dateTextStyle_9Tab,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        RatingBarIndicator(
                          rating: double.parse(
                            detailsModel.data!.reviews![index].rating
                                .toString(),
                          ),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 18.r,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                detailsModel.data!.reviews![index].comment.toString(),
                style: isMobile(context)
                    ? const TextStyle()
                    : AppThemeData.labelTextStyle_12tab.copyWith(
                        fontFamily: "Poppins",
                        fontSize: 10.sp,
                      ),
              ),
              SizedBox(height: 5.h),
              Wrap(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Container(
                          height: 65.h,
                          width: 65.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10.r,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 5))
                            ],
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(detailsModel
                                  .data!.reviews![index].image
                                  .toString()),
                              matchTextDirection: true,
                            ),
                          ),
                          //child: Image.asset("assets/images/_8.png")
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w, top: 8.h),
                child: replyReview(index, detailsModel, context),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () async {
                        if (_favouriteController.token != null) {
                          await detailsController.likeAndUnlike(reviewId: int.parse(detailsModel.data!.reviews![index].id.toString()))
                              .then((value) {
                            detailsController.getProductDetails(int.parse(productId!));
                          });
                        } else {
                          Get.snackbar(
                            AppTags.login.tr,
                            AppTags.pleaseLoginFirst.tr,
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 3),
                            colorText: Colors.white,
                            backgroundColor: Colors.black,
                            forwardAnimationCurve: Curves.decelerate,
                            shouldIconPulse: false,
                          );
                        }


                      },
                      child: detailsModel.data!.reviews![index].isLiked!
                          ? SvgPicture.asset(
                        "assets/icons/like.svg",
                        height: 13.h,
                        width: 14.w,
                        color: Colors.blue,
                      )
                          : SvgPicture.asset(
                        "assets/icons/like.svg",
                        height: 13.h,
                        width: 14.w,
                      )
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      if (_favouriteController.token != null) {
                        showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            actions: <Widget>[
                                buildReplyReview(index, detailsModel, context),
                            ],
                        ));
                    } else {
                    Get.snackbar(
                      AppTags.login.tr,
                      AppTags.pleaseLoginFirst.tr,
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 3),
                      colorText: Colors.white,
                      backgroundColor: Colors.black,
                      forwardAnimationCurve: Curves.decelerate,
                      shouldIconPulse: false,
                    );}},
                    child: SvgPicture.asset(
                      "assets/icons/comment.svg",
                      height: 14.h,
                      width: 15.w,
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

  Widget replyReview(int indexId, detailsModel, context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: detailsModel.data!.reviews![indexId].replies!.length,
        itemBuilder: (_, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 25.w,
                    height: 25.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 5))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(detailsModel.data!.reviews![indexId].replies![index].user!.image.toString()))),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              detailsModel.data!.reviews![indexId]
                                  .replies![index].user!.name
                                  .toString(),
                              style: isMobile(context)
                                  ? AppThemeData.titleTextStyle_14
                                  : AppThemeData.titleTextStyle_11Tab,
                            ),
                            Text(
                              detailsModel
                                  .data!.reviews![indexId].replies![index].date
                                  .toString(),
                              style: isMobile(context)
                                  ? AppThemeData.dateTextStyle_12
                                  : AppThemeData.dateTextStyle_9Tab,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(detailsModel.data!.reviews![indexId].replies![index].reply
                  .toString()),
              SizedBox(height: 5.h),
            ],
          );
        });
  }

  Widget buildSheet(detailsModel, context) {
   return Padding(
      padding: EdgeInsets.all(10.r),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTags.rating.tr,
                      style: AppThemeData.detwailsScreenBottomSheetTitle,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.close,
                        size: 15.r,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.7.h,
                ),
                RatingBar.builder(
                  initialRating: detailsModel.data!.isReviewed!? double.parse(detailsModel.data!.reviews![detailsController.userReviewIndex()!].rating.toString()):1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  unratedColor: Colors.amber.withAlpha(50),
                  itemCount: 5,
                  itemSize: 20.r,
                  itemPadding: EdgeInsets.symmetric(horizontal: 0.w),
                  itemBuilder: (context, _) => Icon(
                        detailsController.selectedIcon ?? Icons.star,
                        color: Colors.amber,
                      ),
                  onRatingUpdate: (rating) {
                    detailsController.ratingUpdate(rating);
                  },
                  updateOnDrag: true,
                ),
                SizedBox(height: 10.h),
                Text(
                  AppTags.uploadImage.tr,
                  style: isMobile(context)
                      ? AppThemeData.detwailsScreenBottomSheetTitle
                      : AppThemeData.detailsScreenPhoneNumberShow,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    SizedBox(
                        height: 53.h,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                detailsController.getImage();
                              },

                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              child: Container(
                                height: 60.h,
                                width: 60.w,
                                decoration: BoxDecoration(
                                    color: const Color(0xfff4f4f4),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.r))),
                                child: Padding(
                                  padding: EdgeInsets.all(15.r),
                                  child: SvgPicture.asset(
                                      "assets/icons/bx_camera.svg"),
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                    const SizedBox(width: 10,),
                     detailsController.image!=null? SizedBox(
                        height: 53.h,
                        child: Container(

                          width: 60.w,
                          decoration: BoxDecoration(
                              color: const Color(0xfff4f4f4),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.r))),
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.file(detailsController.image!,fit: BoxFit.fill,),
                          )
                        )
                    ):const SizedBox(),

                  ],
                ),

                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppTags.reviewTitle.tr,
                      style: isMobile(context)
                          ? AppThemeData.detwailsScreenBottomSheetTitle
                          : AppThemeData.detailsScreenPhoneNumberShow,
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                TextField(
                  controller: titleController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.r),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.greenAccent, width: 1.w),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color(0xfff4f4f4),
                        width: 1.w,
                      ),
                    ),
                    hintText: detailsModel.data!.isReviewed!? detailsModel.data!.reviews![detailsController.userReviewIndex()!].title.toString(): AppTags.reviewTitle.tr,
                    // pass the hint text parameter here
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                       AppTags.writeReview.tr,
                      style: isMobile(context)
                          ? AppThemeData.detwailsScreenBottomSheetTitle
                          : AppThemeData.detailsScreenPhoneNumberShow,
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                TextField(
                  controller: writeReviewController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.r),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.greenAccent, width: 1.w),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0xfff4f4f4), width: 1.w),
                    ),
                    hintText:
                      detailsModel.data!.isReviewed!? detailsModel.data!.reviews![detailsController.userReviewIndex()!].comment: AppTags.review.tr,
                    // pass the hint text parameter here
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                )

              ],
            ),
            SizedBox(height: 10.h),

            Obx(() =>
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.w, vertical: 0.h),
                  child: InkWell(
                    onTap: () async {

                        await detailsController.postReviewSubmit(
                            productId:
                            detailsModel.data!.form!.productId!.toString(),
                            title: titleController.text.isEmpty? detailsModel.data!.reviews![detailsController.userReviewIndex()!].title.toString(): titleController.text,
                            comment: writeReviewController.text.isEmpty? detailsModel.data!.reviews![detailsController.userReviewIndex()!].comment.toString(): writeReviewController.text,
                            rating: detailsController.rating.isNaN? detailsModel.data!.reviews![detailsController.userReviewIndex()!].rating.toString(): detailsController.rating.toString(),
                            image: detailsController.image
                          //image: image
                        ).then((
                            value) =>
                            detailsController.getProductDetails(
                                int.parse(productId!)));
                        Get.snackbar(
                          AppTags.login.tr,
                          AppTags.pleaseLoginFirst.tr,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 3),
                          colorText: Colors.white,
                          backgroundColor: Colors.black,
                          forwardAnimationCurve: Curves.decelerate,
                          shouldIconPulse: false,
                        );



                      Get.back();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 315.w,
                      decoration: BoxDecoration(
                        color: AppThemeData.headlineTextColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.r),
                        child: detailsController.isReviewLoading.value ? Text(
                          AppTags.postReview.tr,
                          style: AppThemeData.detwailsScreenBottomSheetTitle
                              .copyWith(color: Colors.white),
                        ) : const CircularProgressIndicator(
                          color: Colors.white,),
                      ),
                    ),
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildReplyReview(int index, detailsModel, context) => Padding(
        padding: EdgeInsets.all(10.r),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppTags.replyReview.tr,
                        style: isMobile(context)
                            ? AppThemeData.titleTextStyle_14
                            : AppThemeData.titleTextStyle_11Tab,
                      ),
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.close,
                            size: 22.r,
                          ))
                    ],
                  ),
                  SizedBox(height: 10.h),
                  TextField(
                    controller: writeReviewReplyController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.r),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 1.w),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0xfff4f4f4), width: 1.w),
                      ),
                      hintText: AppTags.writeSomething
                          .tr, // pass the hint text parameter here
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0.h),
                child: InkWell(
                  onTap: () async {
                    await Repository().postReviewReply(
                      reviewId: detailsModel.data!.reviews![index].id.toString(),
                      reply: writeReviewReplyController.text,
                    ).then((value) => detailsController.getProductDetails(int.parse(productId!)));
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 315.w,
                    decoration: BoxDecoration(
                      color: AppThemeData.headlineTextColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.r),
                      child: Text(
                        AppTags.replyReview.tr,
                        style: isMobile(context)
                            ? AppThemeData.buttonTextStyle_14
                            : AppThemeData.buttonTextStyle_11Tab,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
