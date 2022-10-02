import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:yoori_ecommerce/src/controllers/all_notifications_controller.dart';
import 'package:yoori_ecommerce/src/models/all_notifications.dart';
import 'package:yoori_ecommerce/src/servers/repository.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:yoori_ecommerce/src/widgets/notification_widget.dart';

import '../../utils/responsive.dart';
import '../../widgets/loader/shimmer_notification.dart';

class NotificationContent extends StatefulWidget {
  const NotificationContent({Key? key}) : super(key: key);

  @override
  State<NotificationContent> createState() => _NotificationContentState();
}

class _NotificationContentState extends State<NotificationContent> {
  final controller = Get.put(AllNotificationsController());
  GlobalKey<PaginationViewState> key = GlobalKey<PaginationViewState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isMobile(context)? AppBar(
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
          AppTags.notification.tr,
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
        AppTags.notification.tr,
        style: AppThemeData.headerTextStyle_14,
      ),
    ),
      body: Obx(() => controller.noData.value
          ? noDataWidget()
          : controller.dataAvailable == false
              ? const ShimmerNotification()
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: ListView(
                        shrinkWrap: true,
                        controller: controller.scrollController,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        children: [
                          controller.allNotifications.isNotEmpty
                              ? otherWidget(controller.allNotifications)
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 25.h,
                      child: controller.isMoreDataLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
      ),
    );
  }

  Widget noDataWidget() {
    return Center(
      child: Text(
        AppTags.noNotification.tr,
        style:  TextStyle(
          fontSize: isMobile(context)? 14.sp:11.sp,
          color: const Color(0xFF666666),
          fontFamily: "Poppins",
        ),
      ),
    );
  }

  Widget todayWidget(List<Notifications> todaysNotifications) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppTags.today.tr,
              style: TextStyle(
                fontSize: isMobile(context)? 14.sp:11.sp,
                color: Colors.black,
                fontFamily: "Poppins",
              ),
            ),
            Text(
              AppTags.clear.tr,
              style: TextStyle(
                fontSize: isMobile(context)? 12.sp:9.sp,
                color: const Color(0xFF999999),
                fontFamily: "Poppins",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 6.h,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: todaysNotifications.length,
          itemBuilder: (context, index) {
            return NotificationWidget(
              notification: todaysNotifications.elementAt(index),
            );
          },
        )
      ],
    );
  }

  Widget otherWidget(List<Notifications> othersNotifications) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppTags.allNotifications.tr,
              style:  TextStyle(
                fontSize: isMobile(context)? 14.sp:11.sp,
                color: Colors.black,
                fontFamily: "Poppins",
              ),
            ),
            TextButton(
              onPressed: () {
                deleteAllNotification(context);
              },
              child: Text(
                AppTags.clearAll.tr,
                style:  TextStyle(
                  fontSize: isMobile(context)? 12.sp:9.sp,
                  color: const Color(0xFF999999),
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ],
        ),
       SizedBox(
          height: 6.h,
        ),
        ListView.builder(
          shrinkWrap: true,
          //controller: controller.scrollController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: othersNotifications.length,
          itemBuilder: (context, index) {
            return Slidable(
              key: const ValueKey(0),
              startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {
                    deleteNotification(
                        othersNotifications.elementAt(index).id, context);
                  }),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        controller.removeNotification(
                            othersNotifications.elementAt(index).id);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: AppTags.delete.tr,
                    )
                  ]),
              child: NotificationWidget(
                notification: othersNotifications.elementAt(index),
                isOtherNotification: true,
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> deleteNotification(int id, BuildContext context) async {
    bool? isDeleted = await Repository().deleteNotification(id);
    if (isDeleted != null) {
      if (!mounted) return;
      isDeleted
          ? showSnackBar(context, AppTags.notificationDeleted.tr)
          : showSnackBar(context, AppTags.notificationCanNotBeDeleted.tr);
    } else {
      if (!mounted) return;
      showSnackBar(context, AppTags.somethingWentWrong.tr);
    }
  }

  Future<void> deleteAllNotification(BuildContext context) async {
    controller.deleteAllNotifications().then((value) {
      value
          ? showSnackBar(
              context, AppTags.allNotificationsDeleted.tr)
          : showSnackBar(context, AppTags.notificationCanNotBeDeleted.tr);
    });
  }

  showSnackBar(context, message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
