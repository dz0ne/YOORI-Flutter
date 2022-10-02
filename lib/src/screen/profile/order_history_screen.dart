import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yoori_ecommerce/src/_route/routes.dart';
import 'package:yoori_ecommerce/src/controllers/currency_converter_controller.dart';
import 'package:yoori_ecommerce/src/controllers/order_history_controller.dart';
import 'package:yoori_ecommerce/src/servers/network_service.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';

import '../../data/local_data_helper.dart';
import '../../utils/responsive.dart';
import '../../widgets/loader/shimmer_order_history.dart';


enum RouteCheckofOrderHistory {
  profileScreen,
  paymentCompleteScreen,
}

class OrderHistory extends StatelessWidget {
  OrderHistory({Key? key}) : super(key: key);
  final String routeName = Get.parameters['routeName']!;
  final currencyConverterController = Get.find<CurrencyConverterController>();
  final orderHistoryController = Get.find<OrderHistoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isMobile(context)? AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            if (routeName ==
                RouteCheckofOrderHistory.profileScreen.toString()) {
              Get.back();
            } else {
              Get.offAllNamed(Routes.dashboardScreen);
            }
          },
        ),
        centerTitle: true,
        title: Text(
          AppTags.orderHistory.tr,
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
          AppTags.orderHistory.tr,
          style: AppThemeData.headerTextStyle_14,
        ),
      ),
      body: Obx(
        () => orderHistoryController.isLoading.value
            ? const ShimmerOrderHistory()
            : ListView.builder(
                shrinkWrap: true,
                itemCount:
                    orderHistoryController.orderListModel.data!.orders!.length,
                itemBuilder: (context, index) {
                  String orderStatus = orderHistoryController.orderListModel.data!.orders![index].paymentStatus.toString();
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15.w, vertical: 8.h),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.invoiceScreen, parameters: {
                          'trackingId': orderHistoryController
                              .orderListModel.data!.orders![index].orderCode
                              .toString(),
                        },);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 110.h,
                        decoration: BoxDecoration(
                          color: const Color(0xffFFFFFF),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 15,
                              color: const Color(0xff404040).withOpacity(0.05),
                              offset: const Offset(0, 30),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15.r),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${AppTags.invoice.tr}: #",
                                          style:
                                          isMobile(context)? AppThemeData.orderHistoryTextStyle_12:AppThemeData.orderHistoryTextStyle_9Tab,
                                        ), SelectableText(
                                          orderHistoryController.orderListModel.data!.orders![index].orderCode.toString(),
                                          style:
                                          isMobile(context)? AppThemeData.orderHistoryTextStyle_12:AppThemeData.orderHistoryTextStyle_9Tab,
                                        ),
                                      ],
                                    ),
                                    Text(
                                        "${AppTags.orderDate.tr}: ${orderHistoryController.orderListModel.data!.orders![index].date.toString()}",
                                        style: isMobile(context)? AppThemeData.orderHistoryTextStyle_12:AppThemeData.orderHistoryTextStyle_9Tab),
                                    Text(
                                        "${AppTags.amount.tr}: ${currencyConverterController.convertCurrency(orderHistoryController.orderListModel.data!.orders![index].totalPayable.toString())}",
                                        style: isMobile(context)? AppThemeData.orderHistoryTextStyle_12:AppThemeData.orderHistoryTextStyle_9Tab),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      var url =
                                          "${NetworkService.apiUrl}/invoice-download/${orderHistoryController.orderListModel.data!.orders![index].id}?token=${LocalDataHelper().getUserToken()}";
                                      try {
                                        await launchUrl(Uri.parse(url),
                                            mode:
                                                LaunchMode.externalApplication);
                                      } catch (e) {
                                        Get.showSnackbar(
                                            GetSnackBar(
                                          backgroundColor: Colors.red,
                                          message: "Can't open link.",
                                          maxWidth: 200.w,
                                          duration: const Duration(seconds: 3),
                                          snackStyle: SnackStyle.FLOATING,
                                          margin: EdgeInsets.all(10.r),
                                          borderRadius: 5.r,
                                          isDismissible: true,
                                          dismissDirection:
                                              DismissDirection.horizontal,
                                        ));
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 28.h,
                                      width: 80.w,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF15642)
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.r),
                                        ),
                                      ),
                                      child: Text(
                                        AppTags.pdf.tr,
                                        style: isMobile(context)? AppThemeData.orderHistoryPDFTextStyle_13:AppThemeData.orderHistoryPDFTextStyleTab,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      orderStatus ==
                                              "unpaid"
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: Text(
                                                orderStatus
                                                    .toString(),
                                                style:isMobile(context)? AppThemeData.orderHistoryPDFTextStyle_13:AppThemeData.orderHistoryPDFTextStyleTab,
                                              ),
                                            )
                                          : const SizedBox(),
                                      orderStatus ==
                                              "unpaid"
                                          ? InkWell(
                                              onTap: () {
                                                Get.toNamed(
                                                  Routes.paymentScreen,
                                                  parameters: {
                                                    'trxId': LocalDataHelper()
                                                            .getCartTrxId() ??
                                                        "",
                                                    'token': LocalDataHelper()
                                                            .getUserToken() ??
                                                        ""
                                                  },
                                                );
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 28.h,
                                                width: orderStatus.length <= 8 ? 80.w : null,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xff6DBEA3)
                                                      .withOpacity(0.1),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(5.r),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets
                                                          .symmetric(
                                                      horizontal: 3.w),
                                                  child: Text(
                                                    AppTags.payNow.tr,
                                                    style: isMobile(context)? AppThemeData.orderHistoryStatusTextStyle_13:AppThemeData.orderHistoryStatusTextStyle_10Tab,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                      orderStatus !=
                                              "unpaid"
                                          ? Container(
                                              alignment: Alignment.center,
                                              height: 28.h,
                                              width: orderStatus
                                                          .length <=
                                                      8
                                                  ? 80.w
                                                  : null,
                                              decoration: BoxDecoration(
                                                color: const Color(0xff6DBEA3)
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                BorderRadius.all(
                                                  Radius.circular(5.r),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                     EdgeInsets.symmetric(
                                                        horizontal: 3.w),
                                                child: Text(
                                                  orderStatus.toString(),
                                                  style: isMobile(context)? AppThemeData.orderHistoryStatusTextStyle_13:AppThemeData.orderHistoryStatusTextStyle_10Tab,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
