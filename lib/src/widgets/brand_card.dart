import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ribbon_widget/ribbon_widget.dart';
import 'package:yoori_ecommerce/src/controllers/home_screen_controller.dart';
import 'package:yoori_ecommerce/src/models/product_by_brand_model.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';

import '../utils/app_tags.dart';

import '../_route/routes.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Data data;

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeScreenController());
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
                            ? data.specialDiscount == 0
                                ? const SizedBox()
                                : Container(
                                    width: 56.w,
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
                                        "\$ ${homeController.removeTrailingZeros(data.specialDiscount.toString())} OFF",
                                        style: AppThemeData.todayDealNewStyle,
                                      ),
                                    ),
                                  )
                            : data.specialDiscountType == 'percentage'
                                ? data.specialDiscount == 0
                                    ? const SizedBox()
                                    : Container(
                                        width: 60.w,
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
                                            "${homeController.removeTrailingZeros(data.specialDiscount.toString())}% OFF",
                                            textAlign: TextAlign.center,
                                            style:
                                                AppThemeData.todayDealNewStyle,
                                          ),
                                        ),
                                      )
                                : Container(),
                      ],
                    ),
                    data.specialDiscount == 0
                        ? const SizedBox()
                        : SizedBox(width: 5.w),
                    data.currentStock == 0
                        ? Container(
                            width: 65.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF51E46).withOpacity(0.06),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.r)),
                            ),
                            child: Center(
                              child: Text(
                                AppTags.stockOut.tr,
                                style: AppThemeData.todayDealNewStyle,
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
                  style: AppThemeData.todayDealTitleStyle,
                ),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Center(
                  child: data.specialDiscount == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "\$${data.price!.toString()}",
                              style: AppThemeData.todayDealDiscountPriceStyle,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "\$${data.price!}",
                              style: AppThemeData.todayDealOriginalPriceStyle,
                            ),
                            SizedBox(width: 15.w),
                            Text(
                              "\$${data.discountPrice!.toString()}",
                              style: AppThemeData.todayDealDiscountPriceStyle,
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
