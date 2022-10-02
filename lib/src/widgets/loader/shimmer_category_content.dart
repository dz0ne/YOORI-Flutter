import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCategoryContent extends StatelessWidget {
  const ShimmerCategoryContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 20,
                        itemBuilder: (_,index){
                          return Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 8.w),
                            child: Column(
                              children: [
                                Shimmer.fromColors(
                                  highlightColor: Colors.grey[300]!,
                                  baseColor: Colors.grey[200]!,
                                  child: Container(
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.circular(0.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF404040).withOpacity(0.1),
                                          spreadRadius: 0,
                                          blurRadius: 30,
                                          offset: const Offset(
                                              0, 15), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                 SizedBox(height: 4.h,)
                              ],
                            ),
                          );
                        }
                    )
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 120.h,
                              decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF404040)
                                        .withOpacity(0.1),
                                    spreadRadius: 0,
                                    blurRadius: 30,
                                    offset: const Offset(
                                        0, 15), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Shimmer.fromColors(
                            highlightColor: Colors.grey[300]!,
                            baseColor: Colors.grey[200]!,
                            child: Container(
                              height: 24.h,
                              width: 160.w,
                              decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(4.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF404040)
                                        .withOpacity(0.1),
                                    spreadRadius: 0,
                                    blurRadius: 30,
                                    offset: const Offset(
                                        0, 15), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          GridView.builder(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.h,
                            ),
                            shrinkWrap: true,
                            itemCount: 20,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.73,
                            ),
                            itemBuilder: (_, index) {
                              return Shimmer.fromColors(
                                highlightColor: Colors.grey[300]!,
                                baseColor: Colors.grey[200]!,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xffFFFFFF),
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF404040)
                                            .withOpacity(0.1),
                                        spreadRadius: 0,
                                        blurRadius: 30,
                                        offset: const Offset(0,
                                            15), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
