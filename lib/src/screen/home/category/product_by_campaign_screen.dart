import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/controllers/home_screen_controller.dart';
import 'package:yoori_ecommerce/src/models/product_by_campaign_model.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';

import '../../../servers/repository.dart';
import '../../../utils/app_tags.dart';

class ProductByCampaign extends StatefulWidget {
  const ProductByCampaign({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<ProductByCampaign> createState() => _ProductByCampaignState();
}

class _ProductByCampaignState extends State<ProductByCampaign> {
  ProductByCampaignModel productByCampaignModel = ProductByCampaignModel();
  final homeController = Get.put(HomeScreenController());

  Future getCampaignData() async {
    productByCampaignModel = await Repository().getProductByCampaign(widget.id);
    setState(() {});
  }

  @override
  void initState() {
    getCampaignData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return productByCampaignModel.data == null
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Get.back();
                }, // null disables the button
              ),
              centerTitle: true,
              title: Text(
                AppTags.campaign.tr,
                style: AppThemeData.headerTextStyle_16,
              ),
            ),
            body: GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                shrinkWrap: true,
                itemCount: productByCampaignModel.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.68,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    height: 230,
                    width: 165,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(7.r)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff404040).withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 20.r,
                          offset:
                              const Offset(0, 10), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 5),
                                productByCampaignModel
                                            .data![index].specialDiscountType ==
                                        'flat'
                                    ? productByCampaignModel
                                                .data![index].specialDiscount ==
                                            0
                                        ? const SizedBox()
                                        : Container(
                                            width: 56,
                                            height: 16,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF51E46)
                                                  .withOpacity(0.06),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(3),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "\$ ${homeController.removeTrailingZeros(productByCampaignModel.data![index].specialDiscount.toString())} OFF",
                                                style: AppThemeData
                                                    .todayDealNewStyle,
                                              ),
                                            ),
                                          )
                                    : productByCampaignModel.data![index]
                                                .specialDiscountType ==
                                            'percentage'
                                        ? productByCampaignModel.data![index]
                                                    .specialDiscount ==
                                                0
                                            ? const SizedBox()
                                            : Container(
                                                width: 60,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFF51E46)
                                                      .withOpacity(0.06),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(3),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "${homeController.removeTrailingZeros(productByCampaignModel.data![index].specialDiscount.toString())}% OFF",
                                                    textAlign: TextAlign.center,
                                                    style: AppThemeData
                                                        .todayDealNewStyle,
                                                  ),
                                                ),
                                              )
                                        : Container(),
                              ],
                            ),
                            productByCampaignModel.data![index].currentStock ==
                                    0
                                ? Container(
                                    width: 60,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF51E46)
                                          .withOpacity(0.06),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(3)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        AppTags.stockOut.tr,
                                        style: AppThemeData.todayDealNewStyle,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Container(
                                    height: 28,
                                    width: 28,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffFFFFFF),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color: const Color(0xff404040)
                                                .withOpacity(0.1),
                                            offset: const Offset(0, 3))
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(7.5),
                                      child: SizedBox(
                                        width: 12.62,
                                        height: 14.19,
                                        child: SvgPicture.asset(
                                          "assets/icons/red_love.svg",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        SizedBox(
                          height: 107,
                          child: Image.network(
                            productByCampaignModel.data![index].image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                              productByCampaignModel.data![index].title!
                                  .toString(),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: AppThemeData.todayDealTitleStyle),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Center(
                            child: productByCampaignModel
                                        .data![index].specialDiscount ==
                                    0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "\$${productByCampaignModel.data![index].price!.toString()}",
                                        style: AppThemeData
                                            .todayDealDiscountPriceStyle,
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "\$${productByCampaignModel.data![index].price!}",
                                        style: AppThemeData
                                            .todayDealOriginalPriceStyle,
                                      ),
                                      const SizedBox(width: 15),
                                      Text(
                                        "\$${productByCampaignModel.data![index].discountPrice!.toString()}",
                                        style: AppThemeData
                                            .todayDealDiscountPriceStyle,
                                      ),
                                    ],
                                  ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          );
  }
}
