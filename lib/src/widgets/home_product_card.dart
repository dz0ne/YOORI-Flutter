import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ribbon_widget/ribbon_widget.dart';
import 'package:yoori_ecommerce/src/controllers/currency_converter_controller.dart';
import 'package:yoori_ecommerce/src/controllers/home_screen_controller.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';

import '../utils/app_tags.dart';
import '../utils/responsive.dart';

class HomeProductCard extends StatelessWidget {
  HomeProductCard({
    Key? key,
    required this.dataModel,
    required this.index,
  }) : super(key: key);
  final dynamic dataModel;
  final int index;
  final currencyConverterController = Get.find<CurrencyConverterController>();

  @override
  Widget build(BuildContext context) {
    final homeScreenContentController = Get.put(HomeScreenController());
    return Ribbon(
      farLength: dataModel![index].isNew! ? isMobile(context)?20:40 : 1,
      nearLength: dataModel![index].isNew! ? isMobile(context)?40:80 : 1,
      title: AppTags.neW.tr,
      titleStyle: TextStyle(
        fontSize: 10.sp,
        fontFamily: 'Poppins',
      ),
      color: const Color(0xFFFAB75A),
      location: RibbonLocation.topEnd,
      child: Container(
        width:isMobile(context)? 165.w:120.w,
        height: 230.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(7.r),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff404040).withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 20.r,
              offset: const Offset(0, 10), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5.0.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      dataModel![index].specialDiscountType == 'flat'
                          ? double.parse(dataModel![index].specialDiscount) ==
                                  0.000
                              ? const SizedBox()
                              : Container(
                                  // width: 66.w,
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
                                      "${currencyConverterController.convertCurrency(dataModel![index].specialDiscount!)} OFF",
                                      style:isMobile(context)? AppThemeData.todayDealNewStyle:AppThemeData.todayDealNewStyleTab,
                                    ),
                                  ),
                                )
                          : dataModel![index].specialDiscountType ==
                                  'percentage'
                              ? double.parse(
                                          dataModel![index].specialDiscount) ==
                                      0.000
                                  ? const SizedBox()
                                  : Container(
                                      // width: 50.w,
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
                                          "${homeScreenContentController.removeTrailingZeros(dataModel![index].specialDiscount)}% OFF",
                                          textAlign: TextAlign.center,
                                          style:isMobile(context)? AppThemeData.todayDealNewStyle:AppThemeData.todayDealNewStyleTab,
                                        ),
                                      ),
                                    )
                              : Container(),
                      dataModel![index].specialDiscount == 0
                          ? const SizedBox()
                          : SizedBox(width: 5.w),
                      dataModel![index].currentStock == 0
                          ? Container(
                              width: 65.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFF51E46).withOpacity(0.06),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3.r)),
                              ),
                              child: Center(
                                child: Text(
                                  AppTags.stockOut.tr,
                                  style: isMobile(context)? AppThemeData.todayDealNewStyle:AppThemeData.todayDealNewStyleTab,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0.r),
                child: CachedNetworkImage(
                  imageUrl: dataModel![index].image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            dataModel![index].reward == 0
                ? SizedBox(height: 14.h)
                : Container(
                    width: double.infinity,
                    color: Colors.yellow.withOpacity(0.3),
                    padding: EdgeInsets.all(2.r),
                    child: Center(
                      child: Text(
                        "${AppTags.reward.tr}: ${dataModel![index].reward}",
                        style: AppThemeData.rewardStyle,
                      ),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: Text(dataModel![index].title!,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: isMobile(context)? AppThemeData.todayDealTitleStyle:AppThemeData.todayDealTitleStyleTab),
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Center(
                child: double.parse(dataModel![index].specialDiscount) == 0.000
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currencyConverterController
                                .convertCurrency(dataModel![index].price!),
                            style: isMobile(context)? AppThemeData.todayDealDiscountPriceStyle:AppThemeData.todayDealDiscountPriceStyleTab,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currencyConverterController.convertCurrency(
                              dataModel![index].price!,
                            ),
                            style: isMobile(context)? AppThemeData.todayDealOriginalPriceStyle:AppThemeData.todayDealOriginalPriceStyleTab,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            currencyConverterController.convertCurrency(
                                dataModel![index].discountPrice!),
                            style: isMobile(context)? AppThemeData.todayDealDiscountPriceStyle:AppThemeData.todayDealDiscountPriceStyleTab,
                          ),
                        ],
                      ),
              ),
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }
}
