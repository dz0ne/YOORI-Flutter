import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerShopLoad extends StatelessWidget {
  const ShimmerShopLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        child: Container(
          // height: 130,
          // width: 110,
          alignment: Alignment.center,
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
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Shimmer.fromColors(
                    highlightColor: Colors.grey[300]!,
                    baseColor: Colors.grey[200]!,
                    child: Container(
                      height: 70.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(7.r),
                          topLeft: Radius.circular(7.r),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Shimmer.fromColors(
                    highlightColor: Colors.grey[300]!,
                    baseColor: Colors.grey[200]!,
                    child: SizedBox(
                      height: 15.h,
                      width: 70.w,
                      child: RatingBarIndicator(
                        rating: 5.0,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 18.0,
                        direction: Axis.horizontal,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                Center(
                  child: Shimmer.fromColors(
                    highlightColor: Colors.grey[300]!,
                    baseColor: Colors.grey[200]!,
                    child: Container(
                      height: 20.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(4.r))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
