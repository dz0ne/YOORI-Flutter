import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PaymentCartWidget extends StatelessWidget {
  final String? icon;
  final String? tittle;
  final int index;

  const PaymentCartWidget({
    Key? key,
    this.icon,
    this.tittle,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Column(
        children: [
          Container(
            height: 88.h,
            width: 82.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: index == index
                  ? const Color(0xffFFFFFF)
                  : const Color(0xffF0F4F7),
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 30,
                    blurRadius: 5,
                    color: const Color(0xff404040).withOpacity(0.01),
                    offset: const Offset(0, 15))
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2, child: SvgPicture.asset("assets/icons/$icon.svg")),
                Expanded(child: Text(tittle!))
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
              height: 20.h,
              width: 20.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: index == index
                    ? const Color(0xff333333)
                    : const Color(0xffFFFFFF),
                borderRadius: BorderRadius.all(
                  Radius.circular(30.r),
                ),
                border: Border.all(color: Colors.grey),
              ),
              child: index == index
                  ? Padding(
                      padding: EdgeInsets.all(2.5.r),
                      child: Icon(
                        Icons.check,
                        size: 14.r,
                        color: Colors.white,
                      ),
                    )
                  : Container()),
        ],
      ),
    );
  }
}
