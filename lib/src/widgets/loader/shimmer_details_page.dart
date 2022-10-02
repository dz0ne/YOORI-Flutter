import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/responsive.dart';

class ShimmerDetailsPage extends StatelessWidget {
  const ShimmerDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.only(left: 15.w, top: 15.h, bottom: 15.h, right: 5.w),
            child: Shimmer.fromColors(
              highlightColor: Colors.grey[300]!,
              baseColor: Colors.grey[200]!,
              child: Container(
                height: 15.h,
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
              height: 30.h,
              width: 150.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.all(
                  Radius.circular(
                      4.r),),),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only( top: 10.h, bottom: 10.h, right: 15.w),
              child: Shimmer.fromColors(
                highlightColor: Colors.grey[300]!,
                baseColor: Colors.grey[200]!,
                child: Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.all(
                          Radius.circular(15.r),
                      ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
            child: SizedBox(
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
                          height:isMobile(context)? size.height /  4.5.h:size.height / 3.h,
                          width: size.width - 80.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(4.r))),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: Shimmer.fromColors(
                        highlightColor: Colors.grey[300]!,
                        baseColor: Colors.grey[200]!,
                        child: Container(
                          height: isMobile(context)? size.height / 15.h:size.height / 13.h,
                          width: size.width - 120.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(4.r))),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0.w, vertical: 7.5.h),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffFFFFFF),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 30.r,
                                blurRadius: 5.r,
                                color:
                                const Color(0xff404040).withOpacity(0.01),
                                offset: const Offset(0, 15))
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Shimmer.fromColors(
                                    highlightColor: Colors.grey[300]!,
                                    baseColor: Colors.grey[200]!,
                                    child: Container(
                                      height:isMobile(context)? 20.h:25.h,
                                      width: 150.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.r))),
                                    ),
                                  ),
                                  Shimmer.fromColors(
                                    highlightColor: Colors.grey[300]!,
                                    baseColor: Colors.grey[200]!,
                                    child: Container(
                                        height: 20.h,
                                        width: 30.w,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffFFFFFF),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 0,
                                                blurRadius: 10,
                                                color: const Color(0xff404040)
                                                    .withOpacity(0.1),
                                                offset: const Offset(0, 1))
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Shimmer.fromColors(
                                              highlightColor: Colors.grey[300]!,
                                              baseColor: Colors.grey[200]!,
                                              child: Container(
                                                height: 30.h,
                                                width: 30.w,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(4.r),
                                                    ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(height: 13.h),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Shimmer.fromColors(
                                        highlightColor: Colors.grey[300]!,
                                        baseColor: Colors.grey[200]!,
                                        child: Container(
                                          height: 25.h,
                                          width: 120.w,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.r),
                                              ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 65.w,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Shimmer.fromColors(
                                          highlightColor: Colors.grey[300]!,
                                          baseColor: Colors.grey[200]!,
                                          child: Container(
                                            height: 23.h,
                                            width: 23.w,
                                            alignment: Alignment.center,
                                            decoration:  BoxDecoration(
                                              color: const Color(0xffF4F4F4),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(3.r),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Shimmer.fromColors(
                                          highlightColor: Colors.grey[300]!,
                                          baseColor: Colors.grey[200]!,
                                          child: Container(
                                            height: 23.h,
                                            width: 23.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffF4F4F4),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(3.r),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: isMobile(context)?20.h:25.h,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xffF4F4F4),
                                    ),
                                    color: const Color(0xffFFFFFF),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(3.r),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10.w, top: 10.h, bottom: 10.h),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Shimmer.fromColors(
                                              highlightColor: Colors.grey[300]!,
                                              baseColor: Colors.grey[200]!,
                                              child: Container(
                                                height: isMobile(context)?20.h:25.h,
                                                width: 180.w,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(4.r),
                                                    ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // const Icon(Icons.arrow_forward_ios_rounded,size: 16,color:  Color(0xff999999))
                                      ],
                                    ),
                                  )),
                              SizedBox(height: 15.h),
                              Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xffF4F4F4),
                                    ),
                                    color: const Color(0xffFFFFFF),
                                    borderRadius:  BorderRadius.all(
                                      Radius.circular(3.r),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10.w, top: 10.h, bottom: 10.h),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Shimmer.fromColors(
                                              highlightColor: Colors.grey[300]!,
                                              baseColor: Colors.grey[200]!,
                                              child: Container(
                                                height: isMobile(context)?20.h:25.h,
                                                width: 140.w,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(4.r),
                                                    ),
                                                ),
                                              ),
                                            ),
                                            Shimmer.fromColors(
                                              highlightColor: Colors.grey[300]!,
                                              baseColor: Colors.grey[200]!,
                                              child: Container(
                                                height:isMobile(context)?20.h:25.h,
                                                width: 15.w,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(4.r),
                                                    ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(height: isMobile(context)?10.h:25.h),
                              Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xffF4F4F4),
                                    ),
                                    color: const Color(0xffFFFFFF),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(3.r),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10.w, top: 10.h, bottom: 10.h),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Shimmer.fromColors(
                                              highlightColor: Colors.grey[300]!,
                                              baseColor: Colors.grey[200]!,
                                              child: Container(
                                                height: 25.h,
                                                width: 120.w,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(4.r),
                                                    ),
                                                ),
                                              ),
                                            ),
                                            Shimmer.fromColors(
                                              highlightColor: Colors.grey[300]!,
                                              baseColor: Colors.grey[200]!,
                                              child: Container(
                                                height: 25.h,
                                                width: 15.w,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(4.r),
                                                    ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(height: isMobile(context)?15.h:20.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile(context)?15.h:25.h),
                    Center(
                      child: Shimmer.fromColors(
                        highlightColor: Colors.grey[300]!,
                        baseColor: Colors.grey[200]!,
                        child: Container(
                          alignment: Alignment.center,
                          width: size.width / 1.6.w,
                          height: isMobile(context)? size.height / 18.h: size.height / 15.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
