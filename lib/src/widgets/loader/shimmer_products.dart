import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/responsive.dart';

class ShimmerProducts extends StatefulWidget {
  const ShimmerProducts({Key? key}) : super(key: key);

  @override
  State<ShimmerProducts> createState() => _ShimmerProductsState();
}

class _ShimmerProductsState extends State<ShimmerProducts> {

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
          child: SizedBox(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 15,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile(context)? 2:3,
                crossAxisSpacing: isMobile(context)?15:20,
                mainAxisSpacing: isMobile(context)?15:20,
                childAspectRatio: 0.74,
              ),
              itemBuilder: (_, __) => Container(
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
                        padding: EdgeInsets.all(22.r),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Shimmer.fromColors(
                              highlightColor: Colors.grey[300]!,
                              baseColor: Colors.grey[200]!,
                              child: Container(
                                height: 15.h,
                                width: isMobile(context)? 50.w:35.w,
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
                                width: isMobile(context)? 50.w:35.w,
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
