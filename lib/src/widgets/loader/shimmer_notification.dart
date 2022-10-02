import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerNotification extends StatelessWidget {
  const ShimmerNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (_,index){
              return Padding(
                padding: EdgeInsets.all(8.r),
                child: Container(
                  height: 90.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          highlightColor: Colors.grey[300]!,
                          baseColor: Colors.grey[200]!,
                          child: CircleAvatar(
                            foregroundColor: Colors.blue,
                            backgroundColor: Colors.white,
                            radius: 25.r,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              highlightColor: Colors.grey[300]!,
                              baseColor: Colors.grey[200]!,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(4.r))),
                                height: 18.h,
                                width: 140.w,
                              ),
                            ),
                            SizedBox(height: 10.h,),
                            Shimmer.fromColors(
                              highlightColor: Colors.grey[300]!,
                              baseColor: Colors.grey[200]!,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(4.r))),
                                height: 18.h,
                                width: 110.w,
                              ),
                            ),
                            SizedBox(height: 10.h,),
                            Shimmer.fromColors(
                              highlightColor: Colors.grey[300]!,
                              baseColor: Colors.grey[200]!,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(4.r))),
                                height: 18.h,
                                width: 120.w,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              highlightColor: Colors.grey[300]!,
                              baseColor: Colors.grey[200]!,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(4.r),
                                    ),
                                ),
                                height: 20.h,
                                width: 80.w,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
