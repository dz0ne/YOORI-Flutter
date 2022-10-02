import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ribbon_widget/ribbon_widget.dart';
import 'package:yoori_ecommerce/src/models/search_product_model.dart';

import '../_route/routes.dart';
import '../controllers/currency_converter_controller.dart';
import '../controllers/home_screen_controller.dart';
import '../utils/app_tags.dart';
import '../utils/app_theme_data.dart';
import '../utils/responsive.dart';

class SearchProductCard extends StatelessWidget {
  SearchProductCard({required this.data, Key? key}) : super(key: key);
  late final SearchProductData data;
  final currencyConverterController = Get.find<CurrencyConverterController>();
  final homeController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Ribbon(
      farLength: data.isNew! ? 20 : 1,
      nearLength: data.isNew! ? 40 : 1,
      title: AppTags.neW.tr,
      titleStyle: const TextStyle(
        fontSize: 10,
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
                'productId': data.id!.toString(),
              },
            );
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5.0.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        data.specialDiscountType == 'flat'
                            ? double.parse(data.specialDiscount ?? "0") == 0.000
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
                                        "${currencyConverterController.convertCurrency(data.specialDiscount)} OFF",
                                        style: isMobile(context)? AppThemeData.todayDealNewStyle:AppThemeData.todayDealNewStyleTab,
                                      ),
                                    ),
                                  )
                            : data.specialDiscountType == 'percentage'
                                ? double.parse(data.specialDiscount ?? "0") ==
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
                                            "${homeController.removeTrailingZeros(data.specialDiscount ?? "0")}% OFF",
                                            textAlign: TextAlign.center,
                                            style:
                                            isMobile(context)? AppThemeData.todayDealNewStyle:AppThemeData.todayDealNewStyleTab,
                                          ),
                                        ),
                                      )
                                : Container(),
                      ],
                    ),
                    data.specialDiscount == null
                        ? const SizedBox()
                        : SizedBox(width: 5.w),
                    data.currentStock == 0
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
                                style:  isMobile(context)? AppThemeData.todayDealNewStyle:AppThemeData.todayDealNewStyleTab,
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
                    data.image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Text(
                  data.title!,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: isMobile(context)? AppThemeData.todayDealTitleStyle:AppThemeData.todayDealTitleStyleTab,
                ),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile(context)?18.w:10.w),
                child: Center(
                  child: double.parse(data.specialDiscount ?? "0") == 0.000
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currencyConverterController
                                  .convertCurrency(data.price!),
                              style: isMobile(context)? AppThemeData.todayDealDiscountPriceStyle:AppThemeData.todayDealDiscountPriceStyleTab,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currencyConverterController
                                  .convertCurrency(data.price!),
                              style: AppThemeData.todayDealOriginalPriceStyle,
                            ),
                            SizedBox(width:isMobile(context)? 15.w:5.w),
                            Text(
                              currencyConverterController
                                  .convertCurrency(data.discountPrice!),
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
