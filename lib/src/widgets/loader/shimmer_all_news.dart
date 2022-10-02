import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/responsive.dart';

class ShimmerAllNews extends StatelessWidget {
  const ShimmerAllNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: SizedBox(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 15,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile(context) ? 2 : 3,
                crossAxisSpacing: isMobile(context) ? 15 : 20,
                mainAxisSpacing: isMobile(context) ? 15 : 20,
                childAspectRatio: 0.73,
              ),
              itemBuilder: (_, __) => Container(
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
                            height: 120.h,
                            //width: 110.w,
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
                              itemSize: 18.r,
                              direction: Axis.horizontal,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Center(
                          child: Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 20.h,
                              // width: 80.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.r))),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Center(
                          child: Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 20.h,
                              // width: 80.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.r))),
                            ),
                          ),
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
