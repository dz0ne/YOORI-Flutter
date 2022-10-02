import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:yoori_ecommerce/src/controllers/category_content_controller.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';

import '../../utils/app_tags.dart';
import '../../utils/responsive.dart';
import '../../widgets/loader/shimmer_category_content.dart';
import '../home/category/product_by_category_screen.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);
  final _catController = Get.put(CategoryContentController());
  final List fixedColor = const [
    Color(0xFF6DBEA3),
    Color(0xFFFAB75A),
    Color(0xFF4179E0),
    Color(0xFFD16D86),
    Color(0xFF56A8C7),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        _catController.isLoading ? const ShimmerCategoryContent() : _mainUi(context));
  }


  Widget _mainUi(context) {
    final orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 15.0.w,
                    right: 7.5.w,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: const Color(0xfff3f3f3),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: _catController.scrollController,
                            itemCount: _catController.categoryList.length + 1,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  index == 0
                                      ? InkWell(
                                          onTap: () {
                                            _catController
                                                .updateFeaturedIndexData(true);
                                          },
                                          child: Container(
                                            height: 70.h,
                                            color: _catController
                                                .featuredIndex.value?AppThemeData.buttonTextColor:AppThemeData.categoryColor,
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: [
                                                      _catController.featuredCategory.value.icon!.isNotEmpty?Icon(
                                                        MdiIcons.fromString(
                                                          _catController
                                                              .featuredCategory
                                                              .value
                                                              .icon!
                                                              .substring(8),
                                                        ),
                                                        size: 30.r,
                                                        color: AppThemeData.headlineTextColor,
                                                      ):Icon( MdiIcons.fromString("checkbox-multiple-blank-outline"),size: 30.r,
                                                        color: AppThemeData.headlineTextColor,),
                                                      SizedBox(height: 5.h),
                                                      Text(
                                                        _catController
                                                            .featuredCategory
                                                            .value
                                                            .title
                                                            .toString()
                                                            .replaceAll(
                                                                "Category", ""),
                                                        style: isMobile(context)? AppThemeData.categoryTitleTextStyle_12:AppThemeData.categoryTitleTextStyle_9Tab,
                                                        overflow: TextOverflow.ellipsis,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : _categoryContent(index - 1,context),
                                ],
                              );
                            },
                          ),
                        ),

                        //pagination progress
                        _catController.isMoreDataLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
              ),
              //
              _catController.featuredIndex.value
                  ? Expanded(
                      flex: 2,
                      child: Container(
                        height: size.height,
                        padding: EdgeInsets.only(
                          left: 7.5.w,
                          right: 15.w,
                        ),
                        //color: Colors.green,
                        child: Column(
                          children: [
                            Container(
                              height: 100.h,
                              decoration: BoxDecoration(
                                color: const Color(0xffDBE8C2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    _catController
                                        .featuredCategory.value.banner!,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 30.r,
                                    blurRadius: 1,
                                    color: const Color(0xff404040)
                                        .withOpacity(0.01),
                                    offset: const Offset(0, 15),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              children: [
                                Text(
                                  AppTags.featuredCategories.tr,
                                  style: isMobile(context)? AppThemeData.priceTextStyle_14:AppThemeData.titleTextStyle_11Tab,
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Expanded(
                              child: GridView.builder(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                ),
                                shrinkWrap: true,
                                itemCount: _catController.featuredCategory.value
                                    .featuredSubCategories!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      (orientation == Orientation.portrait)
                                          ? 3
                                          : 3,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 0.73,
                                ),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ProductByCategory(
                                            id: _catController
                                                .featuredCategory
                                                .value
                                                .featuredSubCategories![index]
                                                .id,
                                            title: _catController
                                                .featuredCategory
                                                .value
                                                .featuredSubCategories![index]
                                                .title,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppThemeData.buttonTextColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.r),
                                        ),
                                        border: Border.all(
                                          color: const Color(0xFFEEEEEE),
                                          width: 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 30.r,
                                              blurRadius: 1,
                                              color: const Color(0xff404040)
                                                  .withOpacity(0.01),
                                              offset: const Offset(0, 15))
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.r),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Image.network(
                                                _catController
                                                    .featuredCategory
                                                    .value
                                                    .featuredSubCategories![
                                                        index]
                                                    .image!
                                                    .toString(),
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                _catController
                                                    .featuredCategory
                                                    .value
                                                    .featuredSubCategories![
                                                        index]
                                                    .title
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: isMobile(context)? AppThemeData.categoryTitleTextStyle_12:AppThemeData.categoryTitleTextStyle_9Tab,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      flex: 2,
                      child: Container(
                        height: size.height,
                        padding: EdgeInsets.only(left: 7.5.w, right: 15.w),
                        //color: Colors.green,
                        child: Column(
                          children: [
                            Container(
                              height: isMobile(context)?100.h:130.h,
                              decoration: BoxDecoration(
                                color: const Color(0xffDBE8C2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    _catController
                                        .categoryList[
                                            _catController.index.value]
                                        .banner!,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 30.r,
                                    blurRadius: 1,
                                    color: const Color(0xff404040)
                                        .withOpacity(0.01),
                                    offset: const Offset(0, 15),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _catController
                                    .categoryList[_catController.index.value]
                                    .subCategories!
                                    .length,
                                itemBuilder: (_, subCtIndex) {
                                  return _catController
                                          .categoryList[
                                              _catController.index.value]
                                          .subCategories![subCtIndex]
                                          .childCategories!
                                          .isNotEmpty
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    ProductByCategory(
                                                  id: _catController
                                                      .categoryList[
                                                          _catController
                                                              .index.value]
                                                      .subCategories![
                                                          subCtIndex]
                                                      .id,
                                                  title: _catController
                                                      .categoryList[
                                                          _catController
                                                              .index.value]
                                                      .subCategories![
                                                          subCtIndex]
                                                      .title,
                                                ),
                                              ),
                                            );
                                          },
                                          child: ListView(
                                            shrinkWrap: true,
                                            primary: false,
                                            children: [
                                              SizedBox(height: 15.h),
                                              Text(
                                                _catController
                                                    .categoryList[_catController
                                                        .index.value]
                                                    .subCategories![subCtIndex]
                                                    .title
                                                    .toString(),
                                                style: isMobile(context)? AppThemeData.priceTextStyle_14:AppThemeData.titleTextStyle_11Tab,
                                              ),
                                              SizedBox(height: 10.h),
                                              GridView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: _catController
                                                    .categoryList[_catController
                                                        .index.value]
                                                    .subCategories![subCtIndex]
                                                    .childCategories!
                                                    .length,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: orientation ==
                                                          Orientation.portrait
                                                      ? 3
                                                      : 3,
                                                  crossAxisSpacing: 15,
                                                  mainAxisSpacing: 16,
                                                  childAspectRatio: 0.73,
                                                ),
                                                itemBuilder:
                                                    (context, childIndex) {
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              ProductByCategory(
                                                            id: _catController
                                                                .categoryList[
                                                                    _catController
                                                                        .index
                                                                        .value]
                                                                .subCategories![
                                                                    subCtIndex]
                                                                .childCategories![
                                                                    childIndex]
                                                                .id,
                                                            title: _catController
                                                                .categoryList[
                                                                    _catController
                                                                        .index
                                                                        .value]
                                                                .subCategories![
                                                                    subCtIndex]
                                                                .childCategories![
                                                                    childIndex]
                                                                .title,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: AppThemeData.buttonTextColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10.r),
                                                        ),
                                                        border: Border.all(
                                                          color: const Color(
                                                              0xFFEEEEEE),
                                                          width: 1,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            spreadRadius: 30.r,
                                                            blurRadius: 1,
                                                            color: const Color(
                                                                    0xff404040)
                                                                .withOpacity(
                                                                    0.01),
                                                            offset:
                                                                const Offset(
                                                                    0, 15),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 8.w,
                                                          vertical: 9.h,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  Image.network(
                                                                _catController
                                                                    .categoryList[
                                                                        _catController
                                                                            .index
                                                                            .value]
                                                                    .subCategories![
                                                                        subCtIndex]
                                                                    .childCategories![
                                                                        childIndex]
                                                                    .image
                                                                    .toString(),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 6.h,
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                _catController
                                                                    .categoryList[
                                                                        _catController
                                                                            .index
                                                                            .value]
                                                                    .subCategories![
                                                                        subCtIndex]
                                                                    .childCategories![
                                                                        childIndex]
                                                                    .title
                                                                    .toString(),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: isMobile(context)? AppThemeData.categoryTitleTextStyle_12:AppThemeData.categoryTitleTextStyle_9Tab,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                            ],
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    ProductByCategory(
                                                  id: _catController
                                                      .categoryList[
                                                          _catController
                                                              .index.value]
                                                      .subCategories![
                                                          subCtIndex]
                                                      .id!,
                                                  title: _catController
                                                      .categoryList[
                                                          _catController
                                                              .index.value]
                                                      .subCategories![
                                                          subCtIndex]
                                                      .title,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10.h,
                                            ),
                                            child: Container(
                                              height: 80.h,
                                              decoration: BoxDecoration(
                                                color: AppThemeData.buttonTextColor,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.r),
                                                ),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xFFEEEEEE),
                                                  width: 1.w,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.r),
                                                          child: Image.network(
                                                            _catController
                                                                .categoryList[
                                                                    _catController
                                                                        .index
                                                                        .value]
                                                                .subCategories![
                                                                    subCtIndex]
                                                                .banner!,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          _catController
                                                              .categoryList[
                                                                  _catController
                                                                      .index
                                                                      .value]
                                                              .subCategories![
                                                                  subCtIndex]
                                                              .title
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: isMobile(context)? 12.sp:10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Poppins_Medium"),
                                                        ),
                                                        Text(
                                                          "${AppTags.totalProduct.tr}: ${_catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories!.length}",
                                                          style: TextStyle(
                                                            fontSize: isMobile(context)? 12.sp:10.sp,
                                                            fontFamily:
                                                                "Poppins",
                                                            color: const Color(
                                                                0xFF666666),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryContent(int index,context) {
    return InkWell(
      onTap: () {
        _catController.updateFeaturedIndexData(false);
        _catController.updateIndex(index);
      },
      child: Container(
        height: 70.h,
        color: _catController.index.value == index && !_catController.featuredIndex.value ?AppThemeData.buttonTextColor:AppThemeData.categoryColor,
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _catController.categoryList[index].icon!.isNotEmpty?Icon(
                    MdiIcons.fromString(
                      _catController.categoryList[index].icon!.substring(8),
                    ),
                    size: 30.r,
                    color: AppThemeData.headlineTextColor,
                  ):Icon( MdiIcons.fromString("checkbox-multiple-blank-outline"),size: 30.r,
                    color: AppThemeData.headlineTextColor,),
                  SizedBox(height: 5.h),
                  Text(
                    _catController.categoryList[index].title.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: isMobile(context)? AppThemeData.categoryTitleTextStyle_12:AppThemeData.categoryTitleTextStyle_9Tab,

                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
