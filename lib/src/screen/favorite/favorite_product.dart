import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:yoori_ecommerce/src/models/favorite_product_model.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/widgets/product_card_list.dart';

import '../../utils/responsive.dart';

class FavoriteProduct extends StatelessWidget {
  const FavoriteProduct({
    Key? key,
    required this.favouriteData,
  }) : super(key: key);

  final FavouriteData favouriteData;

  @override
  Widget build(BuildContext context) {
    return favouriteData.data!.favouriteProducts.isEmpty
        ? Center(
            child: Text(AppTags.noFavProduct.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF666666),
                  fontFamily: "Poppins",
                )),
          )
        : Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              itemCount: favouriteData.data!.favouriteProducts.length,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile(context)? 2:3,
                  childAspectRatio: .75,
                  mainAxisSpacing: isMobile(context)? 15:25,
                  crossAxisSpacing: isMobile(context)?15:25),
              itemBuilder: (context, index) {
                return ProductCardList(
                  dataModel: favouriteData.data!.favouriteProducts,
                  index: index,
                );
              },
            ),
          );
  }
}
