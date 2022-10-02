import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:yoori_ecommerce/src/controllers/home_screen_controller.dart';
import 'package:yoori_ecommerce/src/models/product_by_category_model.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:yoori_ecommerce/src/utils/responsive.dart';
import 'package:yoori_ecommerce/src/widgets/category_product_card.dart';

import '../../../servers/repository.dart';
import '../../../utils/app_tags.dart';
import '../../../widgets/loader/shimmer_load_data.dart';
import '../../../widgets/loader/shimmer_products.dart';

class ProductByCategory extends StatefulWidget {
  const ProductByCategory({
    Key? key,
    required this.id,
    this.title,
  }) : super(key: key);
  final int? id;
  final String? title;

  @override
  State<ProductByCategory> createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {
  final homeController = Get.put(HomeScreenController());

  int page = 0;
  GlobalKey<PaginationViewState> key = GlobalKey<PaginationViewState>();
  late List<CategoryProductData> data = [];

  Future<List<CategoryProductData>> getData(int offset) async {
    page++;
    return await Repository()
        .getProductByCategoryItem(id: widget.id, page: page);
  }

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
      body: PaginationView<CategoryProductData>(
        key: key,
        paginationViewType: PaginationViewType.gridView,
        pageFetch: getData,
        pullToRefresh: false,
        onError: (dynamic error) => Center(
          child: Text(AppTags.somethingWentWrong.tr),
        ),
        onEmpty: const Center(
          child: Text(AppTags.noProduct),
        ),
        bottomLoader: const ShimmerLoadData(),
        initialLoader: const ShimmerProducts(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isMobile(context)? 2:3,
          childAspectRatio: 0.68,
          mainAxisSpacing: isMobile(context)? 15:20,
          crossAxisSpacing:  isMobile(context)? 15:20,
        ),
        itemBuilder:
            (BuildContext context, CategoryProductData product, int index) {
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
