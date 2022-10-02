import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:yoori_ecommerce/src/models/all_campaign_model.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';

import '../../../servers/repository.dart';
import '../../../utils/app_tags.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/loader/shimmer_all_campaign.dart';
import 'campaign_screen.dart';

class AllCampaign extends StatefulWidget {
  const AllCampaign({Key? key}) : super(key: key);

  @override
  State<AllCampaign> createState() => _AllCampaignState();
}

class _AllCampaignState extends State<AllCampaign> {
  int page = 0;
  PaginationViewType paginationViewType = PaginationViewType.gridView;
  GlobalKey<PaginationViewState> key = GlobalKey<PaginationViewState>();

  Future<List<Data>> getData(int offset) async {
    //page = (offset / 1).round();
    page++;
    return await Repository().getAllCampaign(page: page);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: isMobile(context) ?  AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon:  Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: isMobile(context) ? 15.r:20.r,
            ),

            onPressed: () {
              Get.back();
            }, // null disables the button
          ),
          centerTitle: true,
          title: Text(
            AppTags.allCampaign.tr,
            style: AppThemeData.headerTextStyle_16,
          ),
        ):AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 60.h,
          leadingWidth: 40.w,
          leading: IconButton(
            icon:  Icon(
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
            AppTags.allCampaign.tr,
            style: AppThemeData.headerTextStyleTab,
          ),
        ),
        body: PaginationView<Data>(
          key: key,
          paginationViewType: paginationViewType,
          pageFetch: getData,
          pullToRefresh: false,
          onError: (dynamic error) => Center(
            child: Text(AppTags.someErrorOccurred.tr),
          ),
          onEmpty: const Center(
            child: Text(AppTags.noProduct),
          ),
          bottomLoader: const Center(
            child: CircularProgressIndicator(),
          ),
          initialLoader: const ShimmerAllCampaign(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile(context) ? 2 : 3,
            childAspectRatio: 1.6,
            mainAxisSpacing:isMobile(context)? 15:20,
            crossAxisSpacing:isMobile(context)? 15:20,
          ),
          itemBuilder: (BuildContext context, Data campaign, int index) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CampaignContentScreen(
                        campainId: campaign.id!,
                        title: campaign.title!,
                      ),
                    ),
                  );
                },
                child: _allProduct(campaign.banner.toString()));
          },
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
          shrinkWrap: true,
        ));
  }

  Widget _allProduct(String image) {
    return Container(
      width: 159.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            image.toString(),
          ),
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        color: Colors.white,
      ),
    );
  }
}
