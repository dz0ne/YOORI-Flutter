import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerHomeContent extends StatelessWidget {
  const ShimmerHomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 100;

    return SafeArea(
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 1000 + offset;
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Shimmer.fromColors(
                highlightColor: Colors.grey[400]!,
                baseColor: Colors.grey[300]!,
                period: Duration(milliseconds: time),
                child: const ShimmerLayout(),
              )
          );
        },
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  const ShimmerLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 30.h,
                width: 30.w,
                decoration: BoxDecoration(
                    color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(4.r))
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 30.h,
                    width: 140.w,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(4.r))
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Container(
                    height: 30.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(4.r))

                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Container(
                    height: 30.h,
                    width: 30.w,
                    decoration:  BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(4.r))

                    ),
                  ),
                ],
              ),

            ],
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 20.h,
                width: 40.w,
                decoration:  BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4.r))

                ),
              ),
              Container(
                height: 20.h,
                width: 40.w,
                decoration:  BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4.r))

                ),
              ),
              Container(
                height: 20.h,
                width: 40.w,
                decoration:  BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4.r))

                ),
              ),
              Container(
                height: 20.h,
                width: 40.w,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4.r))

                ),
              ),
              Container(
                height: 20.h,
                width: 40.w,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4.r))

                ),
              ),
              Container(
                height: 20.h,
                width: 40.w,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4.r))
                ),
              )
            ],
          ),
          SizedBox(height: 30.h),
          Container(
            height: 120.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(4.r))

            ),
          ),
          SizedBox(height: 30.h),
          Container(
            height: 20.h,
            width: 170.w,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(4.r))

            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 60.h,
                width: 60.w,
                decoration:  BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4.r))

                ),
              ),
              Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4.r))

                ),
              ),
              Container(
                height: 60.h,
                width: 60.w,
                decoration:  BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4.r))

                ),
              ),
              Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4.r))
                ),
              ),

            ],
          ),

          SizedBox(height: 30.h),
          Container(
            height: 20.h,
            width: 140.w,
            decoration:  BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(4.r))

            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 60.h,
                width: 90.w,
                decoration:  BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4.r))

                ),
              ),
              Container(
                height: 60.h,
                width: 90.w,
                decoration:  BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4.r))

                ),
              ),
              Container(
                height: 60.h,
                width: 90.w,
                decoration:  BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(8.r))
                ),
              ),

            ],
          ),
          SizedBox(height: 30.h),
          Container(
            height: 20.h,
            width: 140.w,
            decoration:  BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(4.r))

            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 70.h,
                width: 150.w,
                decoration:  BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4.r))
                ),
              ),
              Container(
                height: 70.h,
                width: 165.w,
                decoration:  BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4.r))
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
