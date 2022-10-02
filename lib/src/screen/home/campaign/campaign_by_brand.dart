import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/campaign_details_model.dart';
import '../../../utils/responsive.dart';
import '../category/product_by_brand_screen.dart';

class CampaignByBrand extends StatelessWidget {
  final CampaignDetailsModel? campaignDetailsModel;
  const CampaignByBrand({
    Key? key,
    this.campaignDetailsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile(context)? 15.w:10.w),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: campaignDetailsModel!.data!.brands!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:   isMobile(context) ? 3 : 5,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProductByBrand(
                      id: campaignDetailsModel!.data!.brands![index].id!,
                      title:
                          campaignDetailsModel!.data!.brands![index].title!,
                    ),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                  border: Border.all(
                    color: const Color(0xFFEEEEEE),
                    width: 1.w,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(15.0.w),
                    child: Image.network(
                      campaignDetailsModel!.data!.brands![index].thumbnail
                          .toString(),
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
