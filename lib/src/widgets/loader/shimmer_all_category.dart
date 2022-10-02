import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAllCategory extends StatelessWidget {
  const ShimmerAllCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 15,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (_, __) => Container(
                // height: 130,
                // width: 110,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff404040).withOpacity(0.05),
                      spreadRadius: 0,
                      blurRadius: 30,
                      offset: const Offset(0, 15), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h),
                      Shimmer.fromColors(
                        highlightColor: Colors.grey[300]!,
                        baseColor: Colors.grey[200]!,
                        child: Container(
                          height: 60.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(4.r))),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Shimmer.fromColors(
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

