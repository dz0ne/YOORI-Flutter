import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:yoori_ecommerce/src/widgets/error_message_widget.dart';

import '../../../models/campaign_details_model.dart';
import '../../../servers/repository.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/loader/shimmer_campaign_details.dart';
import 'campaign_by_brand.dart';
import 'campaign_by_products.dart';
import 'campaign_by_shop.dart';

class CampaignContentScreen extends StatefulWidget {
  final int campainId;
  final String? title;
  const CampaignContentScreen({
    Key? key,
    required this.campainId,
    this.title,
  }) : super(key: key);

  @override
  State<CampaignContentScreen> createState() => _CampaignContentScreenState();
}

class _CampaignContentScreenState extends State<CampaignContentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          widget.title.toString(),
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
          widget.title.toString(),
          style: AppThemeData.headerTextStyle_14,
        ),
      ),
      body: FutureBuilder<CampaignDetailsModel?>(
          future: Repository().getCampaignDetails(widget.campainId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ShimmerCampaignDetails();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data != null) {
                return _mainUI(snapshot.data!);
              } else if (snapshot.hasError) {
                return ErrorMessageWidget(
                    message: AppTags.somethingWentWrong.tr);
              }
            }
            return const ShimmerCampaignDetails();
          }),
    );
  }

  Widget _mainUI(CampaignDetailsModel data) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.network(
            data.data!.campaign!.banner.toString(),
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Center(
          child: CountdownTimer(
            endTime: DateTime.now().millisecondsSinceEpoch +
                DateTime.parse(data.data!.campaign!.endDate!)
                    .difference(DateTime.now())
                    .inMilliseconds,
            widgetBuilder: (_, time) {
              if (time == null) {
                return Center(
                  child: Text(
                    AppTags.campaignOver.tr,
                    style: AppThemeData.timeDateTextStyle_12,
                  ),
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 47.w,
                      height: 38.h,
                      decoration: BoxDecoration(
                        color: const Color(0xff333333),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 30,
                            blurRadius: 5,
                            color: const Color(0xff404040).withOpacity(0.01),
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "${time.days ?? 0}".padLeft(2, '0'),
                          style: isMobile(context)? AppThemeData.timeDateTextStyle_12:AppThemeData.timeDateTextStyleTab,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Container(
                      width: 38.w,
                      height: 38.h,
                      decoration: BoxDecoration(
                        color: const Color(0xff333333),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 30,
                            blurRadius: 5,
                            color: const Color(0xff404040).withOpacity(0.01),
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "${time.hours ?? 0}".padLeft(2, '0'),
                          style: isMobile(context)? AppThemeData.timeDateTextStyle_12:AppThemeData.timeDateTextStyleTab,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Container(
                      width: 38.w,
                      height: 38.h,
                      decoration: BoxDecoration(
                        color: const Color(0xff333333),
                        borderRadius:  BorderRadius.all(
                          Radius.circular(5.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 30,
                            blurRadius: 5,
                            color: const Color(0xff404040).withOpacity(0.01),
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "${time.min ?? 0}".padLeft(2, '0'),
                          style: isMobile(context)? AppThemeData.timeDateTextStyle_12:AppThemeData.timeDateTextStyleTab,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Container(
                      width: 38.w,
                      height: 38.h,
                      decoration: BoxDecoration(
                        color: const Color(0xff333333),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 30,
                            blurRadius: 5,
                            color: const Color(0xff404040).withOpacity(0.01),
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "${time.sec ?? 0}".padLeft(2, '0'),
                          style: isMobile(context)? AppThemeData.timeDateTextStyle_12:AppThemeData.timeDateTextStyleTab,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          child: DefaultTabController(
            length: 3, // length of tabs
            initialIndex: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 SizedBox(
                  width: 230.w,
                  height: 25.h,
                  child: TabBar(
                    labelColor: Colors.red,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Colors.red,
                    indicatorSize: TabBarIndicatorSize.label,
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    labelStyle: TextStyle(
                      fontFamily: "Poppins Medium",
                      fontSize: 13.r,
                    ),
                    tabs: [
                      Tab(text: AppTags.products.tr),
                      Tab(text: AppTags.brand.tr),
                      Tab(text: AppTags.shops.tr),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      CampaignByProduct(
                        campaignDetailsModel: data,
                      ),
                      CampaignByBrand(
                        campaignDetailsModel: data,
                      ),
                      CampaignByShop(
                        campaignDetailsModel: data,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//const ShimmerCampaignDetails();
