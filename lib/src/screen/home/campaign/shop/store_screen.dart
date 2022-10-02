import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/controllers/home_screen_controller.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:yoori_ecommerce/src/widgets/product_card_list.dart';

import '../../../../models/visit_shop_model.dart';
import '../../../../utils/app_tags.dart';
import '../../../../utils/responsive.dart';

class StoreScreen extends StatelessWidget {
  StoreScreen({Key? key, this.visitShopModel}) : super(key: key);
  final homeScreenContentController = Get.put(HomeScreenController());
  final VisitShopModel? visitShopModel;

  @override
  Widget build(BuildContext context) {
    return visitShopModel!.data!.store != null
        ? Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: visitShopModel!.data!.store!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  child: categoryCheck(
                    index,context
                  ),
                );
              },
            ),
          )
        : Center(
            child: Text(
              AppTags.noStoreFound.tr,
              style: isMobile(context)? AppThemeData.headerTextStyle_16:AppThemeData.headerTextStyleTab,
            ),
          );
  }

  newArrival(itemIndex , context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.0.w),
              child: Text(
                visitShopModel!.data!.store![itemIndex].title.toString(),
                style: TextStyle(
                  fontSize: isMobile(context)?13.sp:10.sp,
                  fontFamily: "Poppins Medium",
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 220.h,
          child: ListView.builder(
            padding: EdgeInsets.only(right: 15.w),
            itemCount: visitShopModel!.data!.store![itemIndex].products!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: ProductCardList(
                  dataModel: visitShopModel!.data!.store![itemIndex].products!,
                  index: index,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  bestSelling(itemIndex,context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.0.w),
              child: Text(
                visitShopModel!.data!.store![itemIndex].title.toString(),
                style: TextStyle(
                  fontSize: isMobile(context)?13.sp:10.sp,
                  fontFamily: "Poppins Medium",
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 220.h,
          child: ListView.builder(
            padding: EdgeInsets.only(right: 15.w),
            itemCount: visitShopModel!.data!.store![itemIndex].products!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: ProductCardList(
                  dataModel: visitShopModel!.data!.store![itemIndex].products!,
                  index: index,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  offerEnding(itemIndex,context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Text(
                visitShopModel!.data!.store![itemIndex].title.toString(),
                style: TextStyle(
                  fontSize: isMobile(context)?13.sp:10.sp,
                  fontFamily: "Poppins Medium",
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 220.h,
          child: ListView.builder(
            padding: EdgeInsets.only(right: 15.w),
            itemCount: visitShopModel!.data!.store![itemIndex].products!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: ProductCardList(
                  dataModel: visitShopModel!.data!.store![itemIndex].products!,
                  index: index,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  bestRatedProducts(itemIndex,context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Text(
                visitShopModel!.data!.store![itemIndex].title.toString(),
                style: TextStyle(
                  fontSize: isMobile(context)?13.sp:10.sp,
                  fontFamily: "Poppins Medium",
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 220.h,
          child: ListView.builder(
            padding: EdgeInsets.only(right: 15.w),
            itemCount: visitShopModel!.data!.store![itemIndex].products!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: ProductCardList(
                  dataModel: visitShopModel!.data!.store![itemIndex].products!,
                  index: index,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  featuredProducts(itemIndex, context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Text(
                visitShopModel!.data!.store![itemIndex].title.toString(),
                style: TextStyle(
                  fontSize: isMobile(context)?13.sp:10.sp,
                  fontFamily: "Poppins Medium",
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 220.h,
          child: ListView.builder(
            padding: EdgeInsets.only(right: 15.w),
            itemCount: visitShopModel!.data!.store![itemIndex].products!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: ProductCardList(
                  dataModel: visitShopModel!.data!.store![itemIndex].products!,
                  index: index,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget categoryCheck(index,context) {
    switch (visitShopModel!.data!.store![index].sectionType) {
      case 'best_selling':
        return bestSelling(index,context);
      case 'best_rated_products':
        return bestRatedProducts(index,context);
      case 'offer_ending_soon':
        return offerEnding(index,context);
      case 'new_arrival':
        return newArrival(index,context);
      case 'featured_product':
        return featuredProducts(index,context);
      default:
        return const SizedBox();
    }
  }
}
