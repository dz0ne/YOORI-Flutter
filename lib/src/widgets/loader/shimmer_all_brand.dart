import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/responsive.dart';

class ShimmerAllBrand extends StatelessWidget {
  const ShimmerAllBrand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding:  EdgeInsets.all(15.r),
          child: SizedBox(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile(context)? 3:5,
                crossAxisSpacing: isMobile(context)? 16:20,
                mainAxisSpacing: isMobile(context)?16:20,
                childAspectRatio: 1,
              ),
              itemBuilder: (_, __) => Shimmer.fromColors(
                highlightColor: Colors.grey[300]!,
                baseColor: Colors.grey[200]!,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.all(Radius.circular(4.r))),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
