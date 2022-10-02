import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:yoori_ecommerce/src/controllers/currency_converter_controller.dart';

import '../models/product_details_model.dart';
import '../utils/app_theme_data.dart';

class WholesaleDataWidget extends StatelessWidget {
  final WholesalePrices wholesalePrice;
   WholesaleDataWidget({required this.wholesalePrice, Key? key})
      : super(key: key);
  final CurrencyConverterController controller =
      Get.put(CurrencyConverterController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(wholesalePrice.minQty.toString(),
                style: AppThemeData.titleTextStyle_13),
            Text(wholesalePrice.maxQty.toString(),
                style: AppThemeData.titleTextStyle_13),
            Text(controller.convertCurrency(wholesalePrice.price), style: AppThemeData.titleTextStyle_13),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
