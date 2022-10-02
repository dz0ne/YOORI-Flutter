import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:shimmer/shimmer.dart';


class ShimmerProfileScreen extends StatefulWidget {
  const ShimmerProfileScreen({Key? key}) : super(key: key);

  @override
  State<ShimmerProfileScreen> createState() => _ShimmerProfileScreenState();
}

class _ShimmerProfileScreenState extends State<ShimmerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
               SizedBox(height: 20.h),
              Column(
                children: [
                  Shimmer.fromColors(
                    highlightColor: Colors.grey[300]!,
                    baseColor: Colors.grey[200]!,
                    child: CircleAvatar(
                        foregroundColor: Colors.blue,
                        backgroundColor: Colors.white,
                        radius: 40.r,
                        child: ClipOval(
                            child: SizedBox(
                              height: 64.h,
                              width: 64.w,
                            )
                        )
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Shimmer.fromColors(
                    highlightColor: Colors.grey[300]!,
                    baseColor: Colors.grey[200]!,
                    child: Container(
                      height: 20.h,
                      width: 200.w,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(height: 30.r),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Shimmer.fromColors(
                  highlightColor: Colors.grey[300]!,
                  baseColor: Colors.grey[200]!,
                  child: Container(
                    height: 80.h,
                   // width: 200,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      highlightColor: Colors.grey[300]!,
                      baseColor: Colors.grey[200]!,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 45.h,
                              //width: 300,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(5.r)
                              ),
                            ),
                             SizedBox(height: 2.h)
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )

    );
  }
}
