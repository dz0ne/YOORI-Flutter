import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:yoori_ecommerce/src/controllers/search_controller.dart';

import '../../utils/app_tags.dart';
import '../../utils/responsive.dart';
import '../../widgets/search_product_card.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  TextEditingController searchFieldController = TextEditingController();
  final SearchController _searchController = Get.put(SearchController());

  _listenTextChange(String value) {
    _searchController.search(value);
  }

  @override
  void dispose() {
    searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isMobile(context)? AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            )),
        title: Container(
          height: 35.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xff404040).withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 20,
                offset: const Offset(0, 15), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            controller: searchFieldController,
            textInputAction: TextInputAction.search,
            onChanged: (value) {
              value.isEmpty
                  ? _searchController.setIsSearchFieldEmpty(true)
                  : _searchController.setIsSearchFieldEmpty(false);
              _listenTextChange(value);
            },
            onSubmitted: (value) => _listenTextChange(value),
            decoration: InputDecoration(
              fillColor: Colors.green,
              hoverColor: Colors.blue,
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.transparent)),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20,)),
                borderSide: BorderSide(width: 1, color: Colors.transparent),
              ),
              helperMaxLines: 1,
              hintText: AppTags.searchProducts.tr,
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(top: 15.h, bottom: 8.h, left: 15.h),
              hintStyle: TextStyle(fontSize:12.sp),
            ),
            style: TextStyle(color: Colors.black, fontSize: 15.sp),
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.all(4.r),
            icon: SvgPicture.asset(
              "assets/icons/search_bar.svg",
              color: Colors.black,
            ),
            onPressed: () => _listenTextChange(searchFieldController.text),
          ),
        ],
      ):AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
        toolbarHeight: 60.h,
        leadingWidth: 40.w,
      leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: isMobile(context)? 18.r:25.r,
          )),
      title: Container(
        height: 35.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff404040).withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 20,
              offset: const Offset(0, 15), // changes position of shadow
            ),
          ],
        ),
        child: TextField(
          controller: searchFieldController,
          textInputAction: TextInputAction.search,
          onChanged: (value) {
            value.isEmpty
                ? _searchController.setIsSearchFieldEmpty(true)
                : _searchController.setIsSearchFieldEmpty(false);
            _listenTextChange(value);
          },
          onSubmitted: (value) => _listenTextChange(value),
          decoration: InputDecoration(
            fillColor: Colors.green,
            hoverColor: Colors.blue,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.transparent)),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20,)),
              borderSide: BorderSide(width: 1, color: Colors.transparent),
            ),
            helperMaxLines: 1,
            hintText: AppTags.searchProducts.tr,
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.only(top: 15.h, bottom: 8.h, left: 15.h),
            hintStyle: TextStyle(fontSize:11.sp),
          ),
          style: TextStyle(color: Colors.black, fontSize:12.sp),
        ),
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search_bar.svg",
            color: Colors.black,
            width: 25.w,
            height: 25.h,
          ),
          onPressed: () => _listenTextChange(searchFieldController.text),
        ),
        SizedBox(width: 5.w,),
      ],
    ),
      body: Obx(
        () => _searchController.isSearching
            ? Center(
                child: Lottie.asset(
                  "assets/lottie/searching.json",
                  height: 300.h,
                  width: 300.w,
                ),
              )
            : _searchController.searchResult.data!.isEmpty ||
                    _searchController.isSearchFieldEmpty
                ? SizedBox(
                    height: 580.h,
                    child: Center(
                      child: Lottie.asset(
                        "assets/lottie/notFound.json",
                        height: 300.h,
                        width: 300.w,
                      ),
                    ),
                  )
                : SizedBox(
                    //height: 600,
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 8.h),
                      shrinkWrap: true,
                      itemCount: _searchController.searchResult.data != null
                          ? _searchController.searchResult.data!.length
                          : 0,
                      gridDelegate:
                           SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isMobile(context)? 2:3,
                        childAspectRatio: 0.68,
                        mainAxisSpacing: isMobile(context)? 15:20,
                        crossAxisSpacing: isMobile(context)? 15:20,
                      ),
                      itemBuilder: (context, index) {
                        return SearchProductCard(
                          data: _searchController.searchResult.data![index],
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
