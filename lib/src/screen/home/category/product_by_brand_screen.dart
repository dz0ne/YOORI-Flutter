import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:yoori_ecommerce/src/models/product_by_brand_model.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:yoori_ecommerce/src/widgets/brand_card.dart';

import '../../../servers/repository.dart';
import '../../../widgets/loader/shimmer_load_data.dart';
import '../../../widgets/loader/shimmer_products.dart';

class ProductByBrand extends StatefulWidget {
  final int id;
  final String? title;
  const ProductByBrand({
    Key? key,
    required this.id,
    this.title,
  }) : super(key: key);

  @override
  State<ProductByBrand> createState() => _ProductByBrandState();
}

class _ProductByBrandState extends State<ProductByBrand> {
  int page = 0;
  PaginationViewType paginationViewType = PaginationViewType.gridView;
  GlobalKey<PaginationViewState> key = GlobalKey<PaginationViewState>();

  Future<List<Data>> getData(int offset) async {
    //page = (offset / 1).round();
    page++;
    return await Repository().getProductByBrand(id: widget.id, page: page);
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
          widget.title.toString(),
          style: AppThemeData.headerTextStyle_16,
        ),
      ),
      body: PaginationView<Data>(
        key: key,
        paginationViewType: paginationViewType,
        pageFetch: getData,
        pullToRefresh: true,
        onError: (dynamic error) =>  Center(
          child: Text(AppTags.someErrorOccurred.tr),
        ),
        onEmpty: const Center(
          child: Text(AppTags.noProduct),
        ),
        bottomLoader: const ShimmerLoadData(),
        initialLoader: const ShimmerProducts(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemBuilder: (BuildContext context, Data product, int index) {
          return BrandCard(
            data: product,
          );
        },
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        shrinkWrap: true,
      ),
    );
  }
}
