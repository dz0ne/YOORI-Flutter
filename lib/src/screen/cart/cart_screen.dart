import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/controllers/cart_content_controller.dart';
import 'package:yoori_ecommerce/src/controllers/currency_converter_controller.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:yoori_ecommerce/src/widgets/button_widget.dart';
import 'package:yoori_ecommerce/src/widgets/cart_item.dart';

import '../../models/add_to_cart_list_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/loader/shimmer_cart_content.dart';
import 'check_out_screen.dart';
import 'empty_cart_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final TextEditingController couponController = TextEditingController();
  late final CartContentController _cartController;
  final currencyConverterController = Get.find<CurrencyConverterController>();

  @override
  void initState() {
    super.initState();
    _cartController = Get.put(CartContentController());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _cartController.isLoading
          ? const ShimmerCartContent()
          : _mainUi(_cartController.addToCartListModel, context),
    );
  }

  Widget _mainUi(AddToCartListModel addToCartListModel, context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppTags.myCart.tr,
          style: isMobile(context)? AppThemeData.headerTextStyle_16:AppThemeData.headerTextStyle_14,
        ),
      ),
      body: addToCartListModel.data!.carts!.isNotEmpty
          ? SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: addToCartListModel.data!.carts!.length,
                      itemBuilder: (context, index) {
                        return CartItem(
                            cartList: addToCartListModel,
                            cart: addToCartListModel.data!.carts![index]);
                      },
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 15.h),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF404040).withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 30,
                                offset: const Offset(
                                    0, 15), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              onExpansionChanged: (bool expanded) {},
                              title: Text(
                                AppTags.couponApply.tr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: isMobile(context)? 13.sp : 10.sp,
                                  fontFamily: "Poppins Medium",
                                ),
                              ),
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: SizedBox(
                                        height: 40.h,
                                        width: double.infinity,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _cartController
                                                      .appliedCouponList.data !=
                                                  null
                                              ? _cartController
                                                  .appliedCouponList
                                                  .data!
                                                  .length
                                              : 0,
                                          itemBuilder: (_, index) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4.w),
                                              child: Container(
                                                height: 40.h,
                                                padding: EdgeInsets.only(
                                                    left: 10.w, right: 6.w),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(5.r),
                                                  ),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFFEEEEEE),
                                                    width: 1.w,
                                                  ),
                                                ),
                                                child: Obx(
                                                  () => Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            _cartController
                                                                .appliedCouponList
                                                                .data![index]
                                                                .title
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: isMobile(context)? 12.sp:9.sp,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        _cartController
                                                            .appliedCouponList
                                                            .data![index]
                                                            .discount
                                                            .toString(),
                                                        style: TextStyle(
                                                          color:
                                                              const Color(0xFFF51E46),
                                                          fontSize:isMobile(context)? 10.sp:8.sp,
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
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.h),
                                      child: SizedBox(
                                        height: 48.h,
                                        child: TextFormField(
                                          autofocus: false,
                                          controller: couponController,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          onSaved: (value) =>
                                              couponController.text = value!,
                                          decoration: InputDecoration(
                                            hintText: _cartController
                                                .couponCode.value,
                                            suffixIconConstraints:
                                                const BoxConstraints(
                                              minWidth: 0,
                                              minHeight: 0,
                                            ),
                                            hintStyle: TextStyle(
                                              fontSize:  isMobile(context)? 12.sp: 9.sp,
                                              color: const Color(0xFF999999),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFEEEEEE),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFEEEEEE),
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 30.h,
                                            child: Obx(
                                              () => ElevatedButton(
                                                onPressed: () async {
                                                  _cartController
                                                      .applyCouponCode(
                                                          code: couponController
                                                              .text);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary:
                                                      const Color(0xFF333333),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(5.r),
                                                  ),
                                                ),
                                                child: _cartController
                                                        .isAplyingCoupon
                                                    ? SizedBox(
                                                        width: 15.w,
                                                        height: 15.h,
                                                        child:
                                                            CircularProgressIndicator(
                                                                strokeWidth:
                                                                    2.w),
                                                      )
                                                    : Text(
                                                        AppTags.apply.tr,
                                                        style: TextStyle(
                                                          fontSize: isMobile(context)? 12.sp:9.sp,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 10.h,
                  ),

                  //Calculate Card

                  Padding(
                    padding: EdgeInsets.only(right: 15.w, left: 15.w, bottom: 15.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF),
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 30,
                            blurRadius: 5,
                            color: const Color(0xff404040).withOpacity(0.01),
                            offset: const Offset(0, 15),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppTags.subTotal.tr,
                                  style: isMobile(context)? AppThemeData.titleTextStyle_14 : AppThemeData.titleTextStyle_11Tab,
                                ),
                                Text(
                                  currencyConverterController.convertCurrency(
                                      addToCartListModel.data!.calculations!
                                          .formattedSubTotal),
                                  style: isMobile(context)? AppThemeData.titleTextStyle_14 : AppThemeData.titleTextStyle_11Tab,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppTags.discount.tr,
                                  style: isMobile(context)? AppThemeData.titleTextStyle_14 : AppThemeData.titleTextStyle_11Tab,
                                ),
                                Text(
                                  currencyConverterController.convertCurrency(
                                      addToCartListModel
                                          .data!.calculations!.formattedDiscount
                                          .toString()),
                                  style: isMobile(context)? AppThemeData.titleTextStyle_14 : AppThemeData.titleTextStyle_11Tab,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppTags.deliveryCharge.tr,
                                    style: isMobile(context)? AppThemeData.titleTextStyle_14 : AppThemeData.titleTextStyle_11Tab),
                                Text(
                                    currencyConverterController.convertCurrency(
                                        addToCartListModel.data!.calculations!
                                            .formattedShippingCost
                                            .toString()),
                                    style: isMobile(context)? AppThemeData.titleTextStyle_14 : AppThemeData.titleTextStyle_11Tab),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppTags.tax.tr,
                                    style: isMobile(context)? AppThemeData.titleTextStyle_14 : AppThemeData.titleTextStyle_11Tab),
                                Text(
                                    currencyConverterController.convertCurrency(
                                        addToCartListModel
                                            .data!.calculations!.formattedTax
                                            .toString()),
                                    style: isMobile(context)? AppThemeData.titleTextStyle_14 : AppThemeData.titleTextStyle_11Tab),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppTags.total.tr,
                                    style: isMobile(context)? AppThemeData.titleTextStyle_14 : AppThemeData.titleTextStyle_11Tab),
                                Text(
                                  currencyConverterController.convertCurrency(
                                      addToCartListModel
                                          .data!.calculations!.formattedTotal
                                          .toString()),
                                  style: isMobile(context)? AppThemeData.titleTextStyle_14 : AppThemeData.titleTextStyle_11Tab,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CheckOutScreen(
                                        addToCartListModel: addToCartListModel,
                                      ),
                                    ),
                                  );
                                },
                                child: ButtonWidget(
                                  buttonTittle: AppTags.checkOut.tr,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : EmptyCartScreen(),
    );
  }
}
