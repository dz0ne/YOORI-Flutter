import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/responsive.dart';

class ShimmerFavorite extends StatelessWidget {
  const ShimmerFavorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile(context)? 2:3,
                crossAxisSpacing: 16.h,
                mainAxisSpacing: 16.w,
                childAspectRatio: isMobile(context)? 0.8:0.7,
              ),
              itemBuilder: (_, __) => Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff404040).withOpacity(0.05),
                      spreadRadius: 0,
                      blurRadius: 30.r,
                      offset: const Offset(0, 15), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Shimmer.fromColors(
                        highlightColor: Colors.grey[300]!,
                        baseColor: Colors.grey[200]!,
                        child: Padding(
                          padding:  EdgeInsets.all(8.r),
                          child: Container(
                            height: 150.h,
                            // width: 80.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(4.r))),
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h,),
                      Shimmer.fromColors(
                        highlightColor: Colors.grey[300]!,
                        baseColor: Colors.grey[200]!,
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 8.w),
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
