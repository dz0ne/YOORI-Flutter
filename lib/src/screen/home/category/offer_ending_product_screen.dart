import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:yoori_ecommerce/src/controllers/home_screen_controller.dart';
import 'package:yoori_ecommerce/src/models/offer_ending_product_model.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';

import '../../../servers/repository.dart';
import '../../../widgets/category_product_card.dart';
import '../../../widgets/loader/shimmer_products.dart';

class OfferEndingProductsView extends StatefulWidget {
  const OfferEndingProductsView({Key? key}) : super(key: key);

  @override
  State<OfferEndingProductsView> createState() =>
      _OfferEndingProductsViewState();
}

class _OfferEndingProductsViewState extends State<OfferEndingProductsView> {
  final homeScreenContentController = Get.put(HomeScreenController());

  int page = 0;
  PaginationViewType paginationViewType = PaginationViewType.gridView;
  GlobalKey<PaginationViewState> key = GlobalKey<PaginationViewState>();

  Future<List<Data>> getData(int offset) async {
    //page = (offset / 1).round();
    page++;
    return await Repository().getOfferEndingProduct(page: page);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          AppTags.offerEndingProduct.tr,
          style: AppThemeData.headerTextStyle_16,
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
        initialLoader: const ShimmerProducts(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemBuilder: (BuildContext context, Data product, int index) {
          return CategoryProductCard(
            dataModel: product,
            index: index,
          );
        },
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        shrinkWrap: true,
      ),
    );
  }
}
