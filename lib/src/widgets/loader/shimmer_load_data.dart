import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/responsive.dart';

class ShimmerLoadData extends StatelessWidget {
  const ShimmerLoadData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    highlightColor: Colors.grey[300]!,
                    baseColor: Colors.grey[200]!,
                    child: Container(
                      height: 15.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(4.r))),
                    ),
                  ),
                  Shimmer.fromColors(
                    highlightColor: Colors.grey[300]!,
                    baseColor: Colors.grey[200]!,
                    child: Container(
                      height: 20.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.r))),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Shimmer.fromColors(
                highlightColor: Colors.grey[300]!,
                baseColor: Colors.grey[200]!,
                child: Container(
                  height: 80.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.all(Radius.circular(4.r))),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Shimmer.fromColors(
                highlightColor: Colors.grey[300]!,
                baseColor: Colors.grey[200]!,
                child: Container(
                  height: 20.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.all(Radius.circular(4.r))),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.all(22.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    highlightColor: Colors.grey[300]!,
                    baseColor: Colors.grey[200]!,
                    child: Container(
                      height: 15.h,
                      width: isMobile(context)? 50.w:30.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(4.r))),
                    ),
                  ),
                  Shimmer.fromColors(
                    highlightColor: Colors.grey[300]!,
                    baseColor: Colors.grey[200]!,
                    child: Container(
                      height: 15.h,
                      width: isMobile(context)? 50.w:30.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(4.r))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
