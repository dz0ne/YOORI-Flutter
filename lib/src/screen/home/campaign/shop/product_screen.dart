import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/models/visit_shop_model.dart';
import 'package:yoori_ecommerce/src/utils/responsive.dart';
import 'package:yoori_ecommerce/src/widgets/product_card_list.dart';

import '../../../../utils/app_tags.dart';

class ProductScreen extends StatelessWidget {
  final VisitShopModel? visitShopModel;
  ProductScreen({Key? key, this.visitShopModel}) : super(key: key);

  final TextEditingController trackingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            child: SizedBox(
              height: 40.h,
              child: TextFormField(
                autofocus: false,
                controller: trackingController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onSaved: (value) => trackingController.text = value!,
                decoration: InputDecoration(
                  hintText: AppTags.searchProduct.tr,
                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(13.r),
                      child: SvgPicture.asset(
                        "assets/icons/search_bar.svg",
                        width: 17.w,
                        height: 17.h,
                      ),
                    ),
                  ),
                  hintStyle: TextStyle(
                    fontSize: isMobile(context)? 12.sp:9.sp,
                    color: const Color(0xFF999999),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(
                left: 15.w,
                right: 15.w,
                bottom: 15.h,
              ),
              itemCount: visitShopModel!.data!.products!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile(context)? 2:3,
                childAspectRatio: .75,
                mainAxisSpacing: isMobile(context)? 15:20,
                crossAxisSpacing: isMobile(context)? 15:20,
              ),
              itemBuilder: (context, index) {
                return ProductCardList(
                  dataModel: visitShopModel!.data!.products!,
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
