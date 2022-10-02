import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/models/all_category_product_model.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../servers/repository.dart';
import '../../../widgets/loader/shimmer_all_category.dart';

class AllCategory extends StatefulWidget {
  const AllCategory({Key? key}) : super(key: key);

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  AllCategoryProductModel? allCategoryModel = AllCategoryProductModel();

  //var allCategoryModel;
  int page = 1;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final GlobalKey _refreshkey = GlobalKey();

  Future getAllCategory() async {
    allCategoryModel = await Repository().getAllCategoryContent(page: page);
    setState(() {});
  }

  @override
  void initState() {
    getAllCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
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
          }, 
        ),
        centerTitle: true,
        title: Text(
          AppTags.allCategory.tr,
          style: AppThemeData.headerTextStyle_16,
        ),
      ),
      body: allCategoryModel!.data != null
          ? SmartRefresher(
              key: _refreshkey,
              controller: refreshController,
              enablePullDown: true,
              enablePullUp: true,
              physics: const BouncingScrollPhysics(),
              header: const WaterDropMaterialHeader(),
              footer: const ClassicFooter(
                loadStyle: LoadStyle.ShowWhenLoading,
              ),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                shrinkWrap: true,
                itemCount: allCategoryModel!.data!.categories!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (orientation == Orientation.portrait) ? 3 : 5,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return _allProduct(
                    allCategoryModel!.data!.categories![index].image.toString(),
                    allCategoryModel!.data!.categories![index].title.toString(),
                  );
                },
              ),
            )
          : const ShimmerAllCategory(),
    );
  }

  Widget _allProduct(String image, String tittle) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            spreadRadius: 30,
            blurRadius: 1,
            color: const Color(0xff404040).withOpacity(0.01),
            offset: const Offset(0, 15),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Image.network(image),
            ),
            Expanded(
                child: Center(
                    child: Text(
              tittle,
              style: AppThemeData.categoryTitleTextStyle_12,
              maxLines: 2,
              textAlign: TextAlign.center,
            ))),
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    //await Future.delayed(const Duration(seconds: 0));
    allCategoryModel = await Repository().getAllCategoryContent(page: 1);
    setState(() {
      refreshController.refreshCompleted();
      page = 1;
    });
  }

  Future<void> _onLoading() async {
    page++;
    printInfo(info: 'Page: $page');
    await Future.delayed(const Duration(seconds: 0));
    allCategoryModel = await Repository().getAllCategoryContent(page: page);
    if (mounted) {
      setState(() {
        refreshController.loadComplete();
      });
    }
  }
}
