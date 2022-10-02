import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/controllers/currency_converter_controller.dart';
import 'package:yoori_ecommerce/src/controllers/voucher_controller.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';

import '../../utils/responsive.dart';
import '../../widgets/loader/shimmer_voucher_list.dart';



class VoucherList extends StatefulWidget {
  const VoucherList({Key? key}) : super(key: key);
  @override
  State<VoucherList> createState() => _VoucherListState();
}
class _VoucherListState extends State<VoucherList> {
  final voucherController = Get.put(VoucherController());

  final currencyConverterController = Get.find<CurrencyConverterController>();
  final List fixedColor = const [
    Color(0xFF6DBEA3),
    Color(0xFFFAB75A),
    Color(0xFF4179E0),
    Color(0xFFD16D86),
    Color(0xFF56A8C7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar:isMobile(context)? AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          title: Text(
            AppTags.voucherList.tr,
            style: AppThemeData.headerTextStyle_16,
          ),
        ): AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 60.h,
          leadingWidth: 40.w,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25.r,
            ),

            onPressed: () {
              Get.back();
            }, // null disables the button
          ),
          centerTitle: true,
          title: Text(
            AppTags.voucherList.tr,
            style: AppThemeData.headerTextStyle_14,
          ),
        ),
        body: Obx(
          () => voucherController.couponListModel.value!.data != null
              ? ListView.builder(
                  itemCount: voucherController.couponListModel.value!.data!.coupons!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:  EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 8.h),
                      child: Container(
                        height: isMobile(context)? 100.h:120.h,
                        decoration: BoxDecoration(
                          color: fixedColor[index % fixedColor.length]
                              .withOpacity(0.1),
                          border: Border.all(
                              color: fixedColor[index % fixedColor.length]),
                          borderRadius:
                               BorderRadius.all(Radius.circular(10.r)),
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 12.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        voucherController.couponListModel.value!
                                            .data!.coupons![index].title!,
                                        style: TextStyle(
                                          color: fixedColor[
                                              index % fixedColor.length],
                                          fontFamily: "Poppins",
                                          fontSize: isMobile(context)? 14.sp:10.sp,
                                        )),
                                    Text(
                                        voucherController.couponListModel.value!
                                            .data!.coupons![index].endTime
                                            .toString(),
                                        style: TextStyle(
                                          color: const Color(0xFF666666),
                                          fontFamily: "Poppins",
                                          fontSize:isMobile(context)? 13.sp:9.sp,
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: 15.w, top: 3.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 86.w,
                                            height: 28.h,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Clipboard.setData(
                                                  ClipboardData(
                                                      text: voucherController
                                                          .couponListModel
                                                          .value!
                                                          .data!
                                                          .coupons![index]
                                                          .code),
                                                ).then(
                                                  (value) =>
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                    SnackBar(
                                                      content: Text(AppTags
                                                          .couponCodeCopied.tr),
                                                    ),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: fixedColor[
                                                    index % fixedColor.length],
                                                elevation: 6,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4.r),
                                                ),
                                                shadowColor:
                                                    const Color(0xFF404040)
                                                        .withOpacity(0.10),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    AppTags.copy.tr,
                                                    //couponListModel!.data!.coupons![index].code!,
                                                    style: TextStyle(
                                                      color: const Color(0xFFFFFFFF),
                                                      fontFamily: "Poppins",
                                                      fontSize: isMobile(context)? 12.sp:9.sp,
                                                    ),
                                                  ),
                                                  SvgPicture.asset(
                                                      "assets/icons/copy_.svg"),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: isMobile(context)? 100.w:75.w,
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              voucherController
                                                  .couponListModel
                                                  .value!
                                                  .data!.coupons![index].code!
                                                  .toString(),
                                              style: TextStyle(
                                                  color: fixedColor[index %
                                                      fixedColor.length],
                                                  fontFamily: "Poppins Medium",
                                                  fontSize: isMobile(context)? 14.sp:10.sp),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15.h),
                                child: CustomPaint(
                                  size:  Size(isMobile(context)?3.r:0.r, double.infinity),
                                  painter: DashedLineVerticalPainter(
                                      fixedColor[index % fixedColor.length]),
                                ),
                              ),
                              SizedBox(
                                width: 90.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    voucherController
                                                .couponListModel
                                                .value!.data!.coupons![index]
                                                .discountType ==
                                            "percent"
                                        ? Text(
                                            "${voucherController.couponListModel.value!.data!.coupons![index].discount!.toString()}%",
                                            style: TextStyle(
                                              color: fixedColor[
                                                  index % fixedColor.length],
                                              fontFamily: "Poppins Medium",
                                              fontSize: isMobile(context)? 18.sp:13.sp,
                                            ),
                                            maxLines: 1,
                                          )
                                        : Text(
                                            currencyConverterController
                                                .convertCurrency(
                                                    voucherController
                                                        .couponListModel
                                                        .value!
                                                        .data!
                                                        .coupons![index]
                                                        .discount!
                                                        .toString()),
                                            style: TextStyle(
                                                color: fixedColor[
                                                    index % fixedColor.length],
                                                fontFamily: "Poppins Medium",
                                                fontSize: isMobile(context)? 18.sp:13.sp),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    Text(
                                      AppTags.off.tr,
                                      style: TextStyle(
                                          color: fixedColor[
                                              index % fixedColor.length],
                                          fontFamily: "Poppins Medium",
                                          fontSize:isMobile(context)? 14.sp:11.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const ShimmerVoucherList(),
        ));
  }
}

class DashedLineVerticalPainter extends CustomPainter {
  final Color color;
  DashedLineVerticalPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 5, startY = -15;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
