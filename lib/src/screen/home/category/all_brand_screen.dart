import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:yoori_ecommerce/src/models/all_brand_model.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';


import '../../../servers/repository.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/loader/shimmer_all_brand.dart';
import 'product_by_brand_screen.dart';

class AllBrand extends StatefulWidget {
  const AllBrand({Key? key}) : super(key: key);

  @override
  State<AllBrand> createState() => _AllBrandState();
}

class _AllBrandState extends State<AllBrand> {
  int page = 0;
  PaginationViewType paginationViewType = PaginationViewType.gridView;
  GlobalKey<PaginationViewState> key = GlobalKey<PaginationViewState>();

  @override
  void initState() {
    super.initState();
  }

  Future<List<Brand>> getAllBrand(int offset) async {
    // page = (offset / 20).round();
    page++;
    return await Repository().getAllBrand(page: page);
  }

  @override
  Widget build(BuildContext context) {
    //final orientation = MediaQuery.of(context).orientation;
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
         AppTags.allBrand.tr,
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
          AppTags.allBrand.tr,
          style: AppThemeData.headerTextStyle_14,
        ),
      ),
      body: PaginationView<Brand>(
        key: key,
        paginationViewType: paginationViewType,
        pageFetch: getAllBrand,
        pullToRefresh: false,
        onError: (dynamic error) => Center(
          child: Text(AppTags.someErrorOccurred.tr),
        ),
        onEmpty: const Center(
          child: Text(AppTags.noBrand),
        ),
        bottomLoader: const Center(
          child: CircularProgressIndicator(),
        ),
        initialLoader: const ShimmerAllBrand(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isMobile(context) ? 3 : 5,
          crossAxisSpacing: isMobile(context) ? 15:20,
          mainAxisSpacing:isMobile(context) ? 15:20,
          childAspectRatio: 1,
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, Brand brand, int index) {
          return GridTile(
              child: _allProduct(
            brand.thumbnail.toString(),
            brand.title.toString(),
            brand.id!,
          ));
        },
      ),
    );
  }

  Widget _allProduct(String image, String title, int id) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProductByBrand(
              id: id,
              title: title,
            ),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius:  BorderRadius.all(
            Radius.circular(10.r),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff404040).withOpacity(0.05),
              spreadRadius: 0,
              blurRadius: 30,
              offset: const Offset(0, 15), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: Image.network(
            image,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
