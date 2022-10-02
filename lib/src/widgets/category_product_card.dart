import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ribbon_widget/ribbon_widget.dart';
import 'package:yoori_ecommerce/src/controllers/currency_converter_controller.dart';
import 'package:yoori_ecommerce/src/controllers/home_screen_controller.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';

import '../utils/app_tags.dart';

import '../_route/routes.dart';
import '../utils/responsive.dart';

class CategoryProductCard extends StatelessWidget {
  CategoryProductCard({
    Key? key,
    required this.dataModel,
    required this.index,
  }) : super(key: key);
  final dynamic dataModel;
  final int index;
  final currencyConverterController = Get.find<CurrencyConverterController>();
  final homeController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Ribbon(
      farLength: dataModel.isNew! ? isMobile(context)?20:30 : 1,
      nearLength: dataModel.isNew! ? isMobile(context)?40:60 : 1,
      title: AppTags.neW.tr,
      titleStyle: TextStyle(
        fontSize: isMobile(context)? 10.sp:8.sp,
        fontFamily: 'Poppins',
      ),
      color: const Color(0xFFFAB75A),
      location: RibbonLocation.topEnd,
      child: Container(
        height: 230.h,
        width: 165.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(7.r)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff404040).withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 20.r,
              offset: const Offset(0, 10), // changes position of shadow
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Get.toNamed(
              Routes.detailsPage,
              parameters: {
                'productId': dataModel
                    .id!
                    .toString(),
              },
            );
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        dataModel.specialDiscountType == 'flat'
                            ? double.parse(dataModel.specialDiscount) == 0.000
                                ? const SizedBox()
                                : Container(
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
                                        "${currencyConverterController.convertCurrency(dataModel.specialDiscount)} OFF",
                                        style: isMobile(context)? AppThemeData.todayDealNewStyle :AppThemeData.todayDealNewStyleTab,
                                      ),
                                    ),
                                  )
                            : dataModel.specialDiscountType == 'percentage'
                                ? double.parse(dataModel.specialDiscount) ==
                                        0.000
                                    ? const SizedBox()
                                    : Container(
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
                                            "${homeController.removeTrailingZeros(dataModel.specialDiscount)}% OFF",
                                            textAlign: TextAlign.center,
                                            style:
                                                isMobile(context)?AppThemeData.todayDealNewStyle:AppThemeData.todayDealNewStyleTab,
                                          ),
                                        ),
                                      )
                                : Container(),
                      ],
                    ),
                    double.parse(dataModel.specialDiscount) == 0.000
                        ? const SizedBox()
                        : SizedBox(width: 5.w),
                    dataModel.currentStock == 0
                        ? Container(
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF51E46).withOpacity(0.06),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.r)),
                            ),
                            child: Center(
                              child: Text(
                                AppTags.stockOut.tr,
                                style:  isMobile(context)?AppThemeData.todayDealNewStyle:AppThemeData.todayDealNewStyleTab,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Image.network(
                    dataModel.image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Text(
                  dataModel.title!,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: isMobile(context)? AppThemeData.todayDealTitleStyle:AppThemeData.todayDealTitleStyleTab,
                ),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile(context)?18.w:8.w),
                child: Center(
                  child: double.parse(dataModel.specialDiscount) == 0.000
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currencyConverterController
                                  .convertCurrency(dataModel.price!),
                              style: isMobile(context)? AppThemeData.todayDealDiscountPriceStyle:AppThemeData.todayDealDiscountPriceStyleTab,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currencyConverterController
                                  .convertCurrency(dataModel.price!),
                              style: isMobile(context)? AppThemeData.todayDealOriginalPriceStyle:AppThemeData.todayDealOriginalPriceStyleTab,
                            ),
                            SizedBox(width: isMobile(context)? 15.w:5.w),
                            Text(
                              currencyConverterController
                                  .convertCurrency(dataModel.discountPrice!),
                              style: isMobile(context)? AppThemeData.todayDealDiscountPriceStyle:AppThemeData.todayDealDiscountPriceStyleTab,
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
