import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerShippingAddress extends StatelessWidget {
  const ShimmerShippingAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 17, bottom: 17, right: 5),
          child: Shimmer.fromColors(
            highlightColor: Colors.grey[300]!,
            baseColor: Colors.grey[200]!,
            child: Container(
              height: 10.h,
              width: 30.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.all(
                  Radius.circular(
                      4.r),),),
            ),
          ),
        ),
        centerTitle: true,
        title: Shimmer.fromColors(
          highlightColor: Colors.grey[300]!,
          baseColor: Colors.grey[200]!,
          child: Container(
            height: 25.h,
            width: 150.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.all(
                Radius.circular(
                    4.r),),),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
          child: Column(
            children: [
              Container(
                height: size.height/3.05,
                width: size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(7.r)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff404040).withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 10.r,
                      offset: const Offset(
                          0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h),
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
                                height: 22.h,
                                width: 160.w,
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
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
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
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Shimmer.fromColors(
                          highlightColor: Colors.grey[300]!,
                          baseColor: Colors.grey[200]!,
                          child: Container(
                            height: 20.h,
                            width: 180.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(4.r))),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Shimmer.fromColors(
                          highlightColor: Colors.grey[300]!,
                          baseColor: Colors.grey[200]!,
                          child: Container(
                            height: 20.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(4.r))),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Shimmer.fromColors(
                          highlightColor: Colors.grey[300]!,
                          baseColor: Colors.grey[200]!,
                          child: Container(
                            height: 20.h,
                            width: 220.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(4.r))),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                width: 80.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFFFFF),
                                  borderRadius:  BorderRadius.all(
                                    Radius.circular(7.r),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                        color: Colors.grey
                                            .withOpacity(0.2),
                                        offset: const Offset(0, 4))
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.0.w),
                                  child: Shimmer.fromColors(
                                    highlightColor: Colors.grey[300]!,
                                    baseColor: Colors.grey[200]!,
                                    child: Container(
                                      height: 15.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(4.r))),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: 15.w,
                            ),
                            Container(
                                width: 80.w,
                                //   height: 42,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFFFFF),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                        color: Colors.grey
                                            .withOpacity(0.2),
                                        offset: const Offset(0, 7))
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.w),
                                  child: Shimmer.fromColors(
                                    highlightColor: Colors.grey[300]!,
                                    baseColor: Colors.grey[200]!,
                                    child: Container(
                                      height: 15.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(4.r))),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Shimmer.fromColors(
                      highlightColor: Colors.grey[300]!,
                      baseColor: Colors.grey[200]!,
                      child: Container(
                        height: 22.h,
                        width: 22.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(22.r))),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 8.0.w),
                      child: Shimmer.fromColors(
                        highlightColor: Colors.grey[300]!,
                        baseColor: Colors.grey[200]!,
                        child: Container(
                          height: 20.h,
                          width: 140.w,
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

              SizedBox(
                height: size.height/8,
              ),

              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 30,
                        blurRadius: 5,
                        color: const Color(0xff404040).withOpacity(0.01),
                        offset: const Offset(0, 15))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 20.h,
                              width: 100.w,
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
                              width: 50.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4.r))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 20.h,
                              width: 90.w,
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
                              width: 50.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4.r))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 20.h,
                              width: 150.w,
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
                              width: 30.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4.r))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 20.h,
                              width: 70.w,
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
                              width: 30.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4.r))),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 20.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4.r))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: Shimmer.fromColors(
                          highlightColor: Colors.grey[300]!,
                          baseColor: Colors.grey[200]!,
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width / 1.6,
                            height: size.height / 18,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
