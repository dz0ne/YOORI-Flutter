import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/controllers/home_screen_controller.dart';
import 'package:yoori_ecommerce/src/models/product_by_shop_model.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:yoori_ecommerce/src/widgets/product_card.dart';

import '../../../servers/repository.dart';
import '../../../widgets/loader/shimmer_products.dart';

class ProductByShop extends StatefulWidget {
  const ProductByShop({Key? key, required this.id, this.shopName})
      : super(key: key);
  final int id;
  final String? shopName;

  @override
  State<ProductByShop> createState() => _ProductByShopState();
}

class _ProductByShopState extends State<ProductByShop> {
  ProductByShopModel productByShopModel = ProductByShopModel();
  final homeController = Get.put(HomeScreenController());

  Future getTodayDealData() async {
    productByShopModel = await Repository().getProductByShop(widget.id);
    setState(() {});
  }

  @override
  void initState() {
    getTodayDealData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return productByShopModel.data == null
        ? const Scaffold(body: ShimmerProducts())
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
                widget.shopName.toString(),
                style: AppThemeData.headerTextStyle_16,
              ),
            ),
            body: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              shrinkWrap: true,
              itemCount: productByShopModel.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (context, index) {
                return ProductCard(
                  dataModel: productByShopModel,
                  index: index,
                );
              },
            ),
          );
  }
}
