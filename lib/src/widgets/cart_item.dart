import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/controllers/cart_content_controller.dart';
import 'package:yoori_ecommerce/src/controllers/currency_converter_controller.dart';
import 'package:yoori_ecommerce/src/models/add_to_cart_list_model.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:yoori_ecommerce/src/utils/responsive.dart';

import '../utils/app_tags.dart';

class CartItem extends StatelessWidget {
  final _cartController = Get.find<CartContentController>();
  final currencyConverterController = Get.find<CurrencyConverterController>();
  late final AddToCartListModel cartList;
  late final Carts cart;
  // ignore: prefer_const_constructors_in_immutables
  CartItem({required cartList, required this.cart, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(cart),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () async {
            _cartController.deleteAProductFromCart(
                productId: cart.id.toString());
          },
        ),
        children: [
          SlidableAction(
            onPressed: (c) async {
              _cartController.deleteAProductFromCart(
                  productId: cart.id.toString());
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: AppTags.delete.tr,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: isMobile(context) ? 15.w : 10.w, vertical: 8.h),
        child: Container(
          //height:isMobile(context)? 115.h:125.h,
          decoration: BoxDecoration(
            color: const Color(0xffFFFFFF),
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 30,
                  blurRadius: 5,
                  color: const Color(0xff404040).withOpacity(0.01),
                  offset: const Offset(0, 15))
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.network(
                    cart.productImage.toString(),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cart.productName.toString(),
                          style: isMobile(context)
                              ? AppThemeData.labelTextStyle_16
                              : AppThemeData.todayDealDiscountPriceStyle,
                          textScaleFactor: 1.0,
                          maxLines: 2,
                        ),
                        Text(
                          cart.variant.toString(),
                          style: isMobile(context)
                              ? AppThemeData.hintTextStyle_13
                              : AppThemeData.hintTextStyle_10Tab,
                        ),
                        Text(
                          currencyConverterController
                              .convertCurrency(cart.formattedPrice.toString()),
                          style: isMobile(context)
                              ? AppThemeData.priceTextStyle_14
                              : AppThemeData.titleTextStyle_11Tab,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => InkWell(
                          onTap: () async {
                            int cartStock = cart.stock!;
                            int cartMinOrder = cart.minimumOrder!;
                            if (cartMinOrder < cartStock) {
                              _cartController.updateCartProduct(
                                  increasing: true,
                                  cartId: cart.id.toString(),
                                  quantity: 1);
                            }
                          },
                          child: Container(
                            height: 23.h,
                            width: isMobile(context) ? 23.w : 15.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xffFFFFFF),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.r),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  color:
                                      const Color(0xff404040).withOpacity(0.1),
                                  offset: const Offset(0, 0),
                                )
                              ],
                            ),
                            child: _cartController.isCartUpdating &&
                                    _cartController.updatingCartId ==
                                        cart.id.toString() &&
                                    _cartController.isIncreasing
                                ? const CircularProgressIndicator(
                                    strokeWidth: 1)
                                : Icon(
                                    Icons.add,
                                    size: 16.r,
                                    color: const Color(0xff333333),
                                  ),
                          ),
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: Text(
                          cart.quantity.toString(),
                          style: isMobile(context)
                              ? AppThemeData.priceTextStyle_14
                              : AppThemeData.titleTextStyle_11Tab,
                        ),
                      ),
                      Obx(
                        () => InkWell(
                          onTap: () async {
                            int cartMinOrder = cart.minimumOrder!;
                            if (1 <= cartMinOrder) {
                              _cartController.updateCartProduct(
                                  increasing: false,
                                  cartId: cart.id.toString(),
                                  quantity: -1);
                            }
                          },
                          child: Container(
                            height: 23.h,
                            width: isMobile(context) ? 23.w : 15.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xffFFFFFF),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.r),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    color: const Color(0xff404040)
                                        .withOpacity(0.1),
                                    offset: const Offset(0, 0))
                              ],
                            ),
                            child: _cartController.isCartUpdating &&
                                    _cartController.updatingCartId ==
                                        cart.id.toString() &&
                                    !_cartController.isIncreasing
                                ? const CircularProgressIndicator(
                                    strokeWidth: 1)
                                : Icon(
                                    Icons.remove,
                                    size: 16.r,
                                    color: const Color(0xff333333),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
