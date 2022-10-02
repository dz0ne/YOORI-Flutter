import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:yoori_ecommerce/src/models/all_category_product_model.dart';
import 'package:yoori_ecommerce/src/servers/repository.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_tags.dart';
import '../../../widgets/loader/shimmer_category_content.dart';
import 'product_by_category_screen.dart';

class ProductCategory extends StatefulWidget {
  const ProductCategory({Key? key}) : super(key: key);

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  AllCategoryProductModel? allCategoryProductModel = AllCategoryProductModel();
  int _index = 0;
  bool _featuredIndex = true;
  bool isLoading = false;

  @override
  void initState() {
    getAllCategoryProduct();
    super.initState();
  }

  Future getAllCategoryProduct() async {
    allCategoryProductModel = await Repository().getAllCategoryContent(page: 1);
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? Scaffold(
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
                AppTags.allCategory.tr,
                style: AppThemeData.headerTextStyle_16,
              ),
            ),
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
                          child: ListView.builder(
                            itemCount: allCategoryProductModel!
                                    .data!.categories!.length +
                                1,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  index == 0
                                      ? InkWell(
                                          onTap: () {
                                            setState(() {
                                              _featuredIndex = true;
                                            });
                                          },
                                          child: Container(
                                            height: 70.h,
                                            color: _featuredIndex
                                                ? Colors.white
                                                : const Color(0xfff3f3f3),
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                //SvgPicture.asset("assets/icons/category_icon/$icon.svg"),
                                                Icon(
                                                  MdiIcons.fromString(
                                                    allCategoryProductModel!
                                                        .data!
                                                        .featuredCategory!
                                                        .icon!
                                                        .substring(8),
                                                  ),
                                                  size: 30,
                                                ),
                                                SizedBox(height: 5.h),
                                                Text(
                                                  allCategoryProductModel!.data!
                                                      .featuredCategory!.title
                                                      .toString()
                                                      .replaceAll(
                                                          "Category", ""),
                                                  style: AppThemeData
                                                      .categoryTitleTextStyle_12,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : _categoryContent(
                                          index - 1,
                                          allCategoryProductModel!,
                                        ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    //
                    _featuredIndex
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
                                          allCategoryProductModel!
                                              .data!.featuredCategory!.banner!,
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
                                        style: AppThemeData.priceTextStyle_14,
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
                                      itemCount: allCategoryProductModel!
                                          .data!
                                          .featuredCategory!
                                          .featuredSubCategories!
                                          .length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: (orientation ==
                                                Orientation.portrait)
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
                                                builder: (_) =>
                                                    ProductByCategory(
                                                  id: allCategoryProductModel!
                                                      .data!
                                                      .featuredCategory!
                                                      .featuredSubCategories![
                                                          index]
                                                      .id,
                                                  title: allCategoryProductModel!
                                                      .data!
                                                      .featuredCategory!
                                                      .featuredSubCategories![
                                                          index]
                                                      .title,
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
                                                width: 1,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 30.r,
                                                    blurRadius: 1,
                                                    color:
                                                        const Color(0xff404040)
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
                                                      allCategoryProductModel!
                                                          .data!
                                                          .featuredCategory!
                                                          .featuredSubCategories![
                                                              index]
                                                          .image!
                                                          .toString(),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      allCategoryProductModel!
                                                          .data!
                                                          .featuredCategory!
                                                          .featuredSubCategories![
                                                              index]
                                                          .title
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppThemeData
                                                          .categoryTitleTextStyle_12,
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
                              padding:
                                  EdgeInsets.only(left: 7.5.w, right: 15.w),
                              //color: Colors.green,
                              child: Column(
                                children: [
                                  Container(
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffDBE8C2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          allCategoryProductModel!.data!
                                              .categories![_index].banner!,
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
                                      itemCount: allCategoryProductModel!
                                          .data!
                                          .categories![_index]
                                          .subCategories!
                                          .length,
                                      itemBuilder: (_, subCtIndex) {
                                        return allCategoryProductModel!
                                                .data!
                                                .categories![_index]
                                                .subCategories![subCtIndex]
                                                .childCategories!
                                                .isNotEmpty
                                            ? InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          ProductByCategory(
                                                        id: allCategoryProductModel!
                                                            .data!
                                                            .categories![_index]
                                                            .subCategories![
                                                                subCtIndex]
                                                            .id,
                                                        title:
                                                            allCategoryProductModel!
                                                                .data!
                                                                .categories![
                                                                    _index]
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
                                                      allCategoryProductModel!
                                                          .data!
                                                          .categories![_index]
                                                          .subCategories![
                                                              subCtIndex]
                                                          .title
                                                          .toString(),
                                                      style: AppThemeData
                                                          .priceTextStyle_14,
                                                    ),
                                                    SizedBox(height: 10.h),
                                                    GridView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          allCategoryProductModel!
                                                              .data!
                                                              .categories![
                                                                  _index]
                                                              .subCategories![
                                                                  subCtIndex]
                                                              .childCategories!
                                                              .length,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount:
                                                            orientation ==
                                                                    Orientation
                                                                        .portrait
                                                                ? 3
                                                                : 3,
                                                        crossAxisSpacing: 15,
                                                        mainAxisSpacing: 16,
                                                        childAspectRatio: 0.73,
                                                      ),
                                                      itemBuilder: (context,
                                                          childIndex) {
                                                        return InkWell(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              MaterialPageRoute(
                                                                builder: (_) =>
                                                                    ProductByCategory(
                                                                  id: allCategoryProductModel!
                                                                      .data!
                                                                      .categories![
                                                                          _index]
                                                                      .subCategories![
                                                                          subCtIndex]
                                                                      .childCategories![
                                                                          childIndex]
                                                                      .id,
                                                                  title: allCategoryProductModel!
                                                                      .data!
                                                                      .categories![
                                                                          _index]
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
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                  0xffFFFFFF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    10.r),
                                                              ),
                                                              border:
                                                                  Border.all(
                                                                color: const Color(
                                                                    0xFFEEEEEE),
                                                                width: 1,
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  spreadRadius:
                                                                      30.r,
                                                                  blurRadius: 1,
                                                                  color: const Color(
                                                                          0xff404040)
                                                                      .withOpacity(
                                                                          0.01),
                                                                  offset:
                                                                      const Offset(
                                                                          0,
                                                                          15),
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
                                                                    child: Image
                                                                        .network(
                                                                      allCategoryProductModel!
                                                                          .data!
                                                                          .categories![
                                                                              _index]
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
                                                                      allCategoryProductModel!
                                                                          .data!
                                                                          .categories![
                                                                              _index]
                                                                          .subCategories![
                                                                              subCtIndex]
                                                                          .childCategories![
                                                                              childIndex]
                                                                          .title
                                                                          .toString(),
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: AppThemeData
                                                                          .categoryTitleTextStyle_12,
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
                                                        id: allCategoryProductModel!
                                                            .data!
                                                            .categories![_index]
                                                            .subCategories![
                                                                subCtIndex]
                                                            .id!,
                                                        title:
                                                            allCategoryProductModel!
                                                                .data!
                                                                .categories![
                                                                    _index]
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
                                                      color: const Color(
                                                          0xFFFFFFFF),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10.r),
                                                      ),
                                                      border: Border.all(
                                                        color: const Color(
                                                            0xFFEEEEEE),
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
                                                                    EdgeInsets
                                                                        .all(8
                                                                            .r),
                                                                child: Image
                                                                    .network(
                                                                  allCategoryProductModel!
                                                                      .data!
                                                                      .categories![
                                                                          _index]
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
                                                                allCategoryProductModel!
                                                                    .data!
                                                                    .categories![
                                                                        _index]
                                                                    .subCategories![
                                                                        subCtIndex]
                                                                    .title
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        "Poppins_Medium"),
                                                              ),
                                                              Text(
                                                                "${AppTags.totalProduct.tr}: ${allCategoryProductModel!.data!.categories![_index].subCategories![subCtIndex].childCategories!.length}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.sp,
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
          )
        : const ShimmerCategoryContent();
  }

  Widget _categoryContent(int index, AllCategoryProductModel data) {
    return InkWell(
      onTap: () {
        setState(
          () {
            _featuredIndex = false;
            _index = index;
          },
        );
      },
      child: Container(
        height: 70.h,
        color: _index == index
            ? !_featuredIndex
                ? Colors.white
                : const Color(0xfff3f3f3)
            : const Color(0xfff3f3f3),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //SvgPicture.asset("assets/icons/category_icon/$icon.svg"),
            Icon(
              MdiIcons.fromString(
                data.data!.categories![index].icon!.substring(8),
              ),
              size: 30,
            ),
            SizedBox(height: 5.h),
            Text(
              data.data!.categories![index].title.toString(),
              style: AppThemeData.categoryTitleTextStyle_12,
            )
          ],
        ),
      ),
    );
  }
}
