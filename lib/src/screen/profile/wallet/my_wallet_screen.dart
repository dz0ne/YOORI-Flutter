import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../_route/routes.dart';
import '../../../controllers/currency_converter_controller.dart';
import '../../../controllers/my_wallet_controller.dart';
import '../../../data/local_data_helper.dart';
import '../../../models/user_data_model.dart';
import '../../../utils/app_tags.dart';
import '../../../utils/app_theme_data.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/loader/loader_widget.dart';

class MyWalletScreen extends StatelessWidget {
  final MyWalletController myWalletController = Get.put(MyWalletController());
  final currencyConverterController = Get.find<CurrencyConverterController>();

  final UserDataModel userDataModel;
  MyWalletScreen({Key? key, required this.userDataModel}) : super(key: key);
  final TextEditingController amountController = TextEditingController();
  final List fixedColor = const [
    Color(0xFFD16D86),
    Color(0xFF6DBEA3),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: isMobile(context)
          ? AppBar(
              backgroundColor: const Color(0xffF8F8F8),
              elevation: 0,
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 22.r,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            )
          : AppBar(
              backgroundColor: const Color(0xffF8F8F8),
              elevation: 0,
              toolbarHeight: 60.h,
              leadingWidth: 40.w,
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 22.r,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
      body: Obx(
        () => myWalletController.myWalletModel.value.data != null
            ? Container(
                height: size.height,
                width: size.width,
                color: Colors.white,
                child: ListView(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: isMobile(context) ? 200.h : 220.h,
                          width: MediaQuery.of(context).size.width,
                          color: const Color(0xffF8F8F8),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0.h, horizontal: 10.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //SizedBox(height: 5,),
                                Container(
                                  width: isMobile(context) ? 74.w : 50.w,
                                  height: 74.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.w,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2.r,
                                          blurRadius: 10.r,
                                          color: Colors.black.withOpacity(0.1),
                                          offset: const Offset(0, 5))
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        userDataModel.data!.image!.toString(),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                    "${userDataModel.data!.firstName!.toString()} ${userDataModel.data!.lastName!.toString()}",
                                    style: isMobile(context)
                                        ? AppThemeData.titleTextStyle_14
                                        : AppThemeData.titleTextStyle_11Tab),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: -30.h,
                            child: SizedBox(
                              width: size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 95.h,
                                    width: 132.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          spreadRadius: 2.r,
                                          blurRadius: 10.r,
                                          color: Colors.black.withOpacity(0.1),
                                          offset: const Offset(0, 5),
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppTags.balance.tr,
                                          style: isMobile(context)?
                                              AppThemeData.profileTextStyle_13:AppThemeData.profileTextStyle_10Tab,
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          currencyConverterController.convertCurrency(
                                           myWalletController.myWalletModel.value.data!.balance!.balance != null ? myWalletController.myWalletModel.value.data!.balance!.balance!.toStringAsFixed(3) : "0"),
                                          style: isMobile(context)?
                                              AppThemeData.balanceTextStyle_16:AppThemeData.buttonDltTextStyle_12,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 10.h)
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      rechargeWallet(context);
                                    },
                                    child: Container(
                                      height: 95.h,
                                      width: 132.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 2.r,
                                              blurRadius: 10.r,
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              offset: const Offset(0, 5))
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppTags.recharge.tr,
                                            style: isMobile(context)?
                                            AppThemeData.profileTextStyle_13:AppThemeData.profileTextStyle_10Tab,
                                          ),
                                          SizedBox(height: 5.h),
                                          SvgPicture.asset(
                                            "assets/icons/plus_small.svg",
                                            height: 23.h,
                                            width: 23.w,
                                          ),
                                          SizedBox(height: 10.h)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: myWalletController
                            .myWalletModel.value.data!.recharges!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 10.h),
                            child: Container(
                              //height: 100,
                              decoration: BoxDecoration(
                                color: myWalletController.myWalletModel.value
                                            .data!.recharges![index].type ==
                                        "income"
                                    ? fixedColor[1 % fixedColor.length]
                                        .withOpacity(0.1)
                                    : fixedColor[0 % fixedColor.length]
                                        .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppTags.orderTotalAmount.tr,
                                          style: isMobile(context)? AppThemeData.walletTextStyle_12:AppThemeData.walletTextStyle_10Tab,
                                        ),
                                        Text(
                                          myWalletController
                                                      .myWalletModel
                                                      .value
                                                      .data!
                                                      .recharges![index]
                                                      .type ==
                                                  "expense"
                                              ? "- ${currencyConverterController.convertCurrency(myWalletController.myWalletModel.value.data!.recharges![index].amount.toStringAsFixed(2))}"
                                              : " ${currencyConverterController.convertCurrency(myWalletController.myWalletModel.value.data!.recharges![index].amount.toStringAsFixed(2))}",
                                          style: TextStyle(
                                            color: myWalletController
                                                        .myWalletModel
                                                        .value
                                                        .data!
                                                        .recharges![index]
                                                        .type ==
                                                    "income"
                                                ? fixedColor[
                                                    1 % fixedColor.length]
                                                : fixedColor[
                                                    0 % fixedColor.length],
                                            fontFamily: "Poppins",
                                            fontSize: 16.sp,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      myWalletController.myWalletModel.value
                                          .data!.recharges![index].transactionId
                                          .toString(),
                                      style: AppThemeData.walletTextStyle_12,
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          myWalletController.myWalletModel.value
                                              .data!.recharges![index].date
                                              .toString(),
                                          style:
                                              AppThemeData.walletTextStyle_12,
                                        )),
                                        Container(
                                          height: 28.h,
                                          width: 80.w,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff56A8C7)
                                                  .withOpacity(0.16),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            myWalletController
                                                .myWalletModel
                                                .value
                                                .data!
                                                .recharges![index]
                                                .paymentMethod
                                                .toString()
                                                .replaceAll("_", " ")
                                                .capitalizeFirstOfEach,
                                            style: AppThemeData
                                                .paymentTypeTextStyle_13,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Container(
                                            height: 28.h,
                                            width: 80.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff6DBEA3)
                                                    .withOpacity(0.16),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(
                                                myWalletController
                                                    .myWalletModel
                                                    .value
                                                    .data!
                                                    .recharges![index]
                                                    .status
                                                    .toString()
                                                    .capitalizeFirstOfEach,
                                                style: isMobile(context)? AppThemeData.paymentStatusTextStyle_13: AppThemeData.walletTextStyle_12)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              )
            : const LoaderWidget(),
      ),
    );
  }

  rechargeWallet(context) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.NO_HEADER,
      btnOkColor: const Color(0xFF333333),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(3.r),
                    child: Icon(
                      Icons.clear,
                      size: 18.r,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              AppTags.amount.tr,
              style: isMobile(context)
                  ? AppThemeData.priceTextStyle_14
                  : AppThemeData.todayDealDiscountPriceStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              height: isMobile(context) ? 42.h : 45.h,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xffF4F4F4)),
                borderRadius: BorderRadius.all(Radius.circular(5.r)),
              ),
              child: TextField(
                controller: amountController,
                maxLines: 1,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppTags.enterYourAmount.tr,
                  hintStyle:isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
                  contentPadding: EdgeInsets.only(
                    left: 8.w,
                    right: 8.w,
                    bottom: 8.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      btnOkText: AppTags.next.tr,
      buttonsTextStyle: TextStyle(fontSize: 13.sp),
      buttonsBorderRadius: BorderRadius.circular(5),
      btnOkOnPress: () {
        final String? token = LocalDataHelper().getUserToken();
        Get.toNamed(
          Routes.myWalletRecharge,
          parameters: {
            'amount': amountController.text,
            'token': token!,
          },
        );
      },
    ).show();
  }
}

extension CapExtension on String {
  String get inCaps =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String get capitalizeFirstOfEach => replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");
}
