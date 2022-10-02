import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:timelines/timelines.dart';
import 'package:yoori_ecommerce/src/controllers/tracking_order_controller.dart';
import 'package:yoori_ecommerce/src/models/track_order_model.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';

import '../../utils/responsive.dart';

class TrackingOrder extends StatelessWidget {
  TrackingOrder({Key? key}) : super(key: key);
  final trackingOrderController = Get.find<TrackingOrderController>();
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
      appBar:isMobile(context)? AppBar(
        backgroundColor: Colors.transparent,
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
          AppTags.trackOrder.tr,
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
        AppTags.trackOrder.tr,
        style: AppThemeData.headerTextStyle_14,
      ),
    ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: Container(
                height: 48.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff404040).withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: TextField(
                  controller: trackingOrderController.trackingController,
                  cursorColor: Colors.black87,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintText: AppTags.searchParcel.tr,
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 15.h, bottom: 15.h, left: 15.h),
                    hintStyle: TextStyle(
                      fontSize: isMobile(context)? 13.sp:10.sp,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        if (trackingOrderController
                            .trackingController.text.isNotEmpty) {
                          trackingOrderController.isLoadingUpdate(true);
                          trackingOrderController
                              .getTrackingOrder(trackingOrderController
                                  .trackingController.text)
                              .then(
                            (value) {
                              trackingOrderController.isLoadingUpdate(false);
                              trackingOrderController.loadDataUpdate(true);
                            },
                          );
                        } else {
                          trackingOrderController.textFieldEmptySnackBar();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20.w,
                          top: 15.h,
                          bottom: 15.h,
                          right: 20.w,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/search_bar.svg",
                          height: 17.5.h,
                          width: 18.w,
                        ),
                      ),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: isMobile(context)?  15.sp:11.sp,
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => trackingOrderController.isLoading.value
                ? SizedBox(
                    height: 580.h,
                    child: Lottie.asset(
                      "assets/lottie/searching.json",
                      height: 300.h,
                      width: 300.w,
                    ),
                  )
                : trackingOrderController.trackingOrderModel != null
                    ? Timeline.tileBuilder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        theme: TimelineThemeData(
                          nodePosition: .95,
                          connectorTheme: const ConnectorThemeData(
                            thickness: 3.0,
                            color: Color(0xffd3d3d3),
                            space: 50,
                          ),
                          indicatorTheme: const IndicatorThemeData(
                            size: 15.0,
                          ),
                        ),
                        builder: TimelineTileBuilder.connected(
                          contentsAlign: ContentsAlign.reverse,
                          connectorBuilder: (_, index, __) {
                            if (trackingOrderController.trackingOrderModel!
                                .data!.order!.isOrderDelivered!) {
                              return const DashedLineConnector(
                                color: Color(0xFF6DBEA3),
                              );
                            } else {
                              if (index ==
                                  trackingOrderController.trackingOrderModel!
                                          .data!.order!.orderHistory!.length -
                                      2) {
                                return DashedLineConnector(
                                  color:
                                      const Color(0xFF6DBEA3).withOpacity(0.4),
                                );
                              } else {
                                return const DashedLineConnector(
                                  color: Color(0xFF6DBEA3),
                                );
                              }
                            }
                          },
                          indicatorBuilder: (_, index) {
                            if (index ==
                                trackingOrderController.trackingOrderModel!
                                        .data!.order!.orderHistory!.length -
                                    1) {
                              return DotIndicator(
                                size: 20.r,
                                color: const Color(0xFF6DBEA3).withOpacity(0.4),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 15.r,
                                ),
                              );
                            } else {
                              return DotIndicator(
                                size: 20.r,
                                color: const Color(0xFF6DBEA3),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 15.r,
                                ),
                              );
                            }
                          },
                          itemExtentBuilder: (_, __) => 80.h,
                          contentsBuilder: (context, index) =>
                              orderTrackDetails(
                            trackingOrderController.trackingOrderModel!.data!
                                .order!.orderHistory![trackingOrderController
                                    .trackingOrderModel!
                                    .data!
                                    .order!
                                    .orderHistory!
                                    .length -
                                (index + 1)],
                            index, context,
                          ),
                          itemCount: trackingOrderController.trackingOrderModel!
                              .data!.order!.orderHistory!.length,
                        ),
                      )
                    : SizedBox(
                        height: 580.h,
                        child: Center(
                          child: Lottie.asset(
                            "assets/lottie/notFound.json",
                            height: 300.h,
                            width: 300.w,
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget? orderTrackDetails(OrderHistory orderHistory, index,context) {
    switch (orderHistory.event) {
      case "order_create_event":
        return deliveryTrackItem(
          "order_created",
          "Order Created",
          orderHistory.createdAt,
          index,
            context
        );
      case "delivery_hero_assigned":
        return deliveryTrackItem(
          "delivery_hero_assigned",
          "Delivery Hero Assigned",
          orderHistory.createdAt,
          index,
            context
        );
      case "delivery_hero_changed":
        return deliveryTrackItem(
          "delivery_hero_changed",
          "Delivery Hero Changed",
          orderHistory.createdAt,
          index,
            context
        );
      case "order_confirm_event":
        return deliveryTrackItem(
          "order_confirm",
          "Order Confirm",
          orderHistory.createdAt,
          index,
            context
        );
      case "order_picked_up_event":
        return deliveryTrackItem(
          "order_picked",
          "Order Picked Up",
          orderHistory.createdAt,
          index,
            context
        );
      case "order_on_the_way_event":
        return deliveryTrackItem(
          "order_on_the_way",
          "Order On The way",
          orderHistory.createdAt,
          index,
            context
        );
      case "order_pending_event":
        return deliveryTrackItem(
          "order_pending",
          "Order Pending",
          orderHistory.createdAt,
          index,
            context
        );
      case "order_canceled_event":
        return deliveryTrackItem(
          "order_cancelled",
          "Order Cancelled",
          orderHistory.createdAt,
          index,
            context
        );
      case "order_delivered_event":
        return deliveryTrackItem(
          "order_delivered",
          "Order Delivered",
          orderHistory.createdAt,
          index,
            context
        );
      case "pending":
        return deliveryTrackItem(
          "order_delivered",
          "Order Delivered",
          "Pending",
          index,
            context
        );
      default:
        return deliveryTrackItem(
          "",
          "",
          "",
          index,
          context,
        );
    }
  }

  Widget deliveryTrackItem(image, title, subtitle, index,context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 42.w,
          height: 42.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            color: fixedColor[index % fixedColor.length].withOpacity(0.1),
          ),
          child: Center(
            child: SvgPicture.asset(
              "assets/icons/track_order/$image.svg",
              height: 21.h,
              width: 21.w,
              color: fixedColor[index % fixedColor.length],
            ),
          ),
        ),
        title: Text(
          title,
          style: isMobile(context)? AppThemeData.trackingOrderTitle:AppThemeData.trackingOrderTitleTab,
        ),
        subtitle: Text(
          subtitle,
          style: isMobile(context)? AppThemeData.trackingOrderSubTitle:AppThemeData.trackingOrderSubTitleTab,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
