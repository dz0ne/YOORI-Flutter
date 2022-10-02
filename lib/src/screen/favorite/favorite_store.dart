import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';

import '../../models/favorite_product_model.dart';
import '../../utils/responsive.dart';
import '../home/campaign/shop/shop_screen.dart';



class FavoriteStore extends StatelessWidget {
  const FavoriteStore({Key? key, required this.favouriteData})
      : super(key: key);
  final FavouriteData favouriteData;

  @override
  Widget build(BuildContext context) {
    return favouriteData.data!.favouriteShop.isNotEmpty
        ? Padding(
            padding:  EdgeInsets.only(top: 20.h),
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
              shrinkWrap: true,
              itemCount: favouriteData.data!.favouriteShop.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile(context) ? 2 : 3,
                crossAxisSpacing: 15.h,
                mainAxisSpacing: 15.w,
                childAspectRatio: isMobile(context)?0.75:0.70,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ShopScreen(
                          shopId: favouriteData.data!.favouriteShop[index].id,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    // width: 165,
                    // height: 220,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:  BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                      border: Border.all(
                        color: const Color(0xFFEEEEEE),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.r),
                                topRight: Radius.circular(10.r),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  favouriteData
                                      .data!.favouriteShop[index].banner
                                      .toString(),
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          height: isMobile(context)? 100.h:120.h,
                                          color: const Color(0xFF333333)
                                              .withOpacity(0.85),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height:isMobile(context)? 30.h:45.h,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                        horizontal: 10.w),
                                                child: Center(
                                                  child: Text(
                                                    favouriteData
                                                        .data!
                                                        .favouriteShop[index]
                                                        .shopName!,
                                                    style:  TextStyle(
                                                      fontSize: isMobile(context)? 13.sp:10.sp,
                                                      color: Colors.white,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                               SizedBox(height: 5.h),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  RatingBarIndicator(
                                                    rating: double.parse(
                                                      favouriteData
                                                          .data!
                                                          .favouriteShop[index]
                                                          .ratingCount
                                                          .toString(),
                                                    ),
                                                    itemBuilder:
                                                        (context, index) =>
                                                            const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    itemCount: 5,
                                                    itemSize:isMobile(context)? 18:25,
                                                    direction: Axis.horizontal,
                                                  ),
                                                  Text(
                                                    "(${favouriteData.data!.favouriteShop[index].reviewsCount.toString()} ${AppTags.review.tr})",
                                                    style:  TextStyle(
                                                      fontSize: isMobile(context)? 10.sp:8.sp,
                                                      color: const Color(0xFF999999),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "${AppTags.products.tr}: ${favouriteData.data!.favouriteShop[index].totalProduct.toString()}",
                                                    style: TextStyle(
                                                      fontSize: isMobile(context)? 9.sp:6.sp,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${AppTags.joined.tr}: ${favouriteData.data!.favouriteShop[index].joinDate.toString()}",
                                                    style:  TextStyle(
                                                      fontSize:isMobile(context)? 9.sp:6.sp,
                                                      color: Colors.white,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: -25.h,
                                          child: Container(
                                            width: 50.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  favouriteData.data!
                                                      .favouriteShop[index].logo
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
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 14.w),
                                child: Text(
                                  AppTags.visitStore.tr,
                                  style: TextStyle(
                                    fontSize: isMobile(context)?12.sp:9.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4.w),
                                child: SvgPicture.asset(
                                  "assets/icons/campaign_shop_arrow.svg",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        : Center(
            child: Text(AppTags.noFavStore.tr,
                style:  TextStyle(
                  fontSize:isMobile(context)? 14.sp:12.sp,
                  color: const Color(0xFF666666),
                  fontFamily: "Poppins",
                ),
            ),
          );
  }
}
