import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoori_ecommerce/src/utils/responsive.dart';

import '../screen/home/campaign/shop/shop_screen.dart';
import '../utils/app_theme_data.dart';

class ShopCardWidget extends StatefulWidget {
  final dynamic shop;
  const ShopCardWidget({Key? key, this.shop}) : super(key: key);

  @override
  State<ShopCardWidget> createState() => _ShopCardWidgetState();
}

class _ShopCardWidgetState extends State<ShopCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ShopScreen(
              shopId: widget.shop.id,
            ),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 200.h,
            width: isMobile(context)?165.w:120.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(7.r)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff404040).withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10.r,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          widget.shop.banner.toString(),
                        ),
                      ),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: Colors.green,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 4, top: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 35.h,
                        ),
                        RatingBarIndicator(
                          rating: double.parse(
                            widget.shop.rating!.toString(),
                          ),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 18.r,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          widget.shop.shopName!,
                          style: isMobile(context)? AppThemeData.titleTextStyle_14:AppThemeData.titleTextStyle_11Tab,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: isMobile(context)? 55.w:42.w,
            child: Container(
              height: 60.h,
              width: isMobile(context)?60.w:38.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(35.r)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff404040).withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 6,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                height: 60.h,
                width: isMobile(context)?60.w:38.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.shop.logo!.toString(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
