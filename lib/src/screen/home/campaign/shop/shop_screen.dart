import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/models/visit_shop_model.dart';
import 'package:yoori_ecommerce/src/servers/repository.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';

import '../../../../utils/app_tags.dart';
import '../../../../utils/responsive.dart';
import '../../../../widgets/loader/shimmer_visit_shop.dart';
import 'coupon_screen.dart';
import 'product_screen.dart';
import 'store_screen.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({
    Key? key,
    this.shopId,
  }) : super(key: key);
  final int? shopId;

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  VisitShopModel visitShopModel = VisitShopModel();
  int page = 1;

  Future getVisitShop() async {
    visitShopModel = await Repository().getVisitShop(widget.shopId!);
    setState(() {});
  }

  @override
  void initState() {
    getVisitShop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return visitShopModel.data != null
        ? Scaffold(
            appBar: isMobile(context)? AppBar(
              backgroundColor: Colors.white,
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
                visitShopModel.data!.shop!.shopName.toString(),
                style: isMobile(context)? AppThemeData.headerTextStyle_16:AppThemeData.headerTextStyleTab,
              ),
            ):AppBar(
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
                visitShopModel.data!.shop!.shopName.toString(),
                style: isMobile(context)? AppThemeData.headerTextStyle_14:AppThemeData.titleTextStyle_11Tab,
              ),
            ),
            body: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 150.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        visitShopModel.data!.shop!.image1905x350!.toString(),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 75.h,
                            color: const Color(0xFF333333).withOpacity(0.85),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30.h,
                                ),
                                Center(
                                  child: Text(
                                    visitShopModel.data!.shop!.shopName
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: isMobile(context)? 13.sp:10.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RatingBarIndicator(
                                      rating: double.parse(
                                        visitShopModel.data!.shop!.ratingCount
                                            .toString(),
                                      ),
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 18.r,
                                      direction: Axis.horizontal,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "(${visitShopModel.data!.shop!.reviewsCount!.toString()})",
                                      style: TextStyle(
                                        fontSize:  isMobile(context)? 10.sp:8.sp,
                                        color: const Color(0xFF999999),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: -25.h,
                            child: Container(
                              width: isMobile(context)? 50.w:35.w,
                              height:  50.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.w,
                                ),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    visitShopModel.data!.shop!.image82x82!
                                        .toString(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 3, // length of tabs
                    initialIndex: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: isMobile(context)? 230.w:200.w,
                          height:  isMobile(context)? 25.h:35.h,
                          child: TabBar(
                            labelColor: Colors.red,
                            unselectedLabelColor: Colors.black,
                            indicatorColor: Colors.red,
                            indicatorSize: TabBarIndicatorSize.label,
                            padding: EdgeInsets.zero,
                            indicatorPadding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.zero,
                            labelStyle: TextStyle(
                              fontFamily: "Poppins Medium",
                              fontSize: isMobile(context)? 13.sp:10.sp,
                            ),
                            tabs: [
                              Tab(text: AppTags.store.tr),
                              Tab(text: AppTags.coupon.tr),
                              Tab(text: AppTags.products.tr),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              StoreScreen(visitShopModel: visitShopModel),
                              CouponScreen(visitShopModel: visitShopModel),
                              ProductScreen(visitShopModel: visitShopModel),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : const ShimmerVisitShop();
  }
}
