import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/responsive.dart';

class ShimmerAllCampaign extends StatelessWidget {
  const ShimmerAllCampaign({Key? key}) : super(key: key);

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
                crossAxisCount: isMobile(context) ? 2 : 3,
                crossAxisSpacing:isMobile(context) ? 15:20,
                mainAxisSpacing:isMobile(context) ? 15:20,
                childAspectRatio: 1.6,
              ),
              itemBuilder: (_, __) => Shimmer.fromColors(
                highlightColor: Colors.grey[300]!,
                baseColor: Colors.grey[200]!,
                child: Container(
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
                        blurRadius: 30,
                        offset: const Offset(0, 15), // changes position of shadow
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
