import 'package:http/http.dart' as http;
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/_route/routes.dart';
import 'package:yoori_ecommerce/src/controllers/currency_converter_controller.dart';
import 'package:yoori_ecommerce/src/models/add_to_cart_list_model.dart';
import 'package:yoori_ecommerce/src/models/edit_view_model.dart';
import 'package:yoori_ecommerce/src/models/shipping_address_model/country_list_model.dart';
import 'package:yoori_ecommerce/src/models/shipping_address_model/get_city_model.dart';
import 'package:yoori_ecommerce/src/models/shipping_address_model/shipping_address_model.dart';
import 'package:yoori_ecommerce/src/models/shipping_address_model/state_list_model.dart';
import 'package:yoori_ecommerce/src/servers/network_service.dart';
import 'package:yoori_ecommerce/src/servers/repository.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/data/local_data_helper.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yoori_ecommerce/src/widgets/button_widget.dart';

import '../../../../config.dart';
import '../../utils/responsive.dart';
import '../../utils/validators.dart';
import '../../widgets/loader/loader_widget.dart';


class CheckOutScreen extends StatefulWidget {
  final AddToCartListModel? addToCartListModel;
  const CheckOutScreen({Key? key, this.addToCartListModel}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final postalCodeController = TextEditingController();
  final addressController = TextEditingController();
  final currencyConverterController = Get.find<CurrencyConverterController>();
  bool isSelectPickup = false;
  bool isSelectBilling = false;
  int? shippingIndex = 0;
  String? token = LocalDataHelper().getUserToken();
  void onShippingTapped(int? index) {
    setState(() {
      shippingIndex = index!;
    });
  }

  int? billingIndex = 0;
  void onBillingTapped(int? index) {
    setState(() {
      billingIndex = index!;
    });
  }

  String? phoneCode = "880";
  dynamic selectPickUpAddress;
  dynamic _selectedCountry; // Option 2
  dynamic _selectedState; // Option 2// Option 2
  dynamic _selectedCity; // Option 2

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    getCountryList();
    getShippingAddress();
    super.initState();
  }

  ShippingAddressModel shippingAddressModel = ShippingAddressModel();
  Future getShippingAddress() async {
    shippingAddressModel = await Repository().getShippingAddress();
    setState(() {});
  }

  CountryListModel countryListModel = CountryListModel();
  Future getCountryList() async {
    countryListModel = await Repository().getCountryList();
    setState(() {});
  }

  StateListModel stateListModel = StateListModel();
  Future getStateList(int? countryId) async {
    stateListModel = await Repository().getStateList(countryId: countryId);
    setState(() {});
  }

  GetCitisModel cityModel = GetCitisModel();
  Future getCityList(int? stateId) async {
    cityModel = await Repository().getCityList(stateId: stateId);
    setState(() {});
  }

  EditViewModel editViewModel = EditViewModel();
  Future getEditViewAddress(int addressId) async {
    editViewModel = await Repository().getEditViewAddress(addressId);
    setState(() {});
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    postalCodeController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return shippingAddressModel.data != null
        ? Scaffold(
            key: _scaffoldkey,
            appBar: isMobile(context)? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              //toolbarHeight: 50.h,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20.r,
                ),

                onPressed: () {
                  Get.back();
                }, // null disables the button
              ),
              centerTitle: false,
              title: Text(
                AppTags.billingShippingAddress.tr,
                style:AppThemeData.headerTextStyle_16,
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: TextButton(
                    child: Text(
                      "+ ${AppTags.add.tr}",
                      style: AppThemeData.addAddressTextStyle_13,
                    ),
                    onPressed: () {
                      if (token != null) {
                        createAddress();
                      } else {
                        Get.snackbar(
                          AppTags.login.tr,
                          AppTags.pleaseLoginFirst.tr,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 3),
                          colorText: Colors.white,
                          backgroundColor: Colors.black,
                          forwardAnimationCurve: Curves.decelerate,
                          shouldIconPulse: false,
                        );
                      }
                    },
                  ),
                )
              ],
            ):AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              toolbarHeight: 60.h,
              leadingWidth: 40.w,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20.r,
                ),

                onPressed: () {
                  Get.back();
                }, // null disables the button
              ),
              centerTitle: false,
              title: Text(
                AppTags.billingShippingAddress.tr,
                style: AppThemeData.headerTextStyle_14,
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: TextButton(
                    child: Text(
                      "+ ${AppTags.add.tr}",
                      style: AppThemeData.addAddressTextStyle_10Tab,
                    ),
                    onPressed: () {
                      if (token != null) {
                        createAddress();
                      } else {
                        Get.snackbar(
                          AppTags.login.tr,
                          AppTags.pleaseLoginFirst.tr,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 3),
                          colorText: Colors.white,
                          backgroundColor: Colors.black,
                          forwardAnimationCurve: Curves.decelerate,
                          shouldIconPulse: false,
                        );
                      }
                    },
                  ),
                )
              ],
            ),
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        //PickUp Point
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 7.5.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffFFFFFF),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 30,
                                    blurRadius: 5,
                                    color: const Color(0xffEEEEEE)
                                        .withOpacity(0.01),
                                    offset: const Offset(0, 15))
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isSelectPickup = !isSelectPickup;
                                      });
                                    },
                                    child: isSelectPickup
                                        ? Container(
                                            height: 18.h,
                                            width: 18.w,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              color: Color(0xff56A8C7),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(2.5.r),
                                              child: Icon(
                                                Icons.check,
                                                size: 14.r,
                                                color: Colors.white,
                                              ),
                                            ))
                                        : Container(
                                            height: 18.h,
                                            width: 18.w,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffE1E1E1)),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5.r),
                                              ),
                                            ),
                                          ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(AppTags.iWantToPickup.tr,
                                      style: isMobile(context) ? AppThemeData.headerTextStyle_14:AppThemeData.titleTextStyleTab
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        isSelectPickup
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 26.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.h),
                                    child: Text(AppTags.pickupPoint.tr),
                                  ),
                                  SizedBox(
                                    height: 11.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w),
                                    child: Container(
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: const Color(0xffEEEEEE)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.r)),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.w, right: 10.w),
                                          child: DropdownButton(
                                            isExpanded: true,
                                            hint: Text(
                                                AppTags.selectPickupPoint.tr,
                                                style: AppThemeData
                                                    .hintTextStyle_13),
                                            // Not necessary for Option 1
                                            value: selectPickUpAddress,
                                            style:
                                                isMobile(context) ? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectPickUpAddress = newValue;
                                              });
                                            },
                                            items: shippingAddressModel
                                                .data!.pickupHubs!
                                                .map((pickUp) {
                                              return DropdownMenuItem(
                                                value: pickUp.id,
                                                child: Text(
                                                  pickUp.address.toString(),
                                                  style:  isMobile(context) ? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        isSelectPickup
                            ? const SizedBox()
                            : token != null
                                ? Column(
                                    children: [
                                      shippingAddress(),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w, vertical: 7.5.h),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xffFFFFFF),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.r),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 30,
                                                  blurRadius: 5,
                                                  color: const Color(0xff404040)
                                                      .withOpacity(0.01),
                                                  offset: const Offset(0, 15))
                                            ],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(12.r),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      isSelectBilling =
                                                          !isSelectBilling;
                                                    });
                                                  },
                                                  child: isSelectBilling
                                                      ? Container(
                                                          height: 18.h,
                                                          width: 18.w,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xff56A8C7),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5.r),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2.5.r),
                                                            child: Icon(
                                                              Icons.check,
                                                              size: 14.r,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ))
                                                      : Container(
                                                          height: 18.h,
                                                          width: 18.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: const Color(
                                                                    0xffE1E1E1)),
                                                            borderRadius: BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5.r),
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Text(AppTags
                                                    .billToTheSameAddress.tr,
                                                   style: isMobile(context) ? AppThemeData.headerTextStyle_14:AppThemeData.titleTextStyleTab
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      isSelectBilling
                                          ? const SizedBox()
                                          : billingAddress(),
                                    ],
                                  )
                                : const SizedBox(),
                      ],
                    ),
                  ),

                  //Calculate Card
                  Padding(
                    padding: EdgeInsets.only(right: 15.w, left: 15.w, bottom: 15.h),
                    child: Container(
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
                                        widget.addToCartListModel!.data!
                                            .calculations!.formattedSubTotal
                                            .toString()),
                                    style: isMobile(context)? AppThemeData.titleTextStyle_14 : AppThemeData.titleTextStyle_11Tab),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppTags.discount.tr,
                                    style: isMobile(context)? AppThemeData.titleTextStyle_14 : AppThemeData.titleTextStyle_11Tab),
                                Text(
                                    currencyConverterController.convertCurrency(
                                        widget.addToCartListModel!.data!
                                            .calculations!.formattedDiscount
                                            .toString()),
                                    style: isMobile(context)? AppThemeData.titleTextStyle_14 : AppThemeData.titleTextStyle_11Tab),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppTags.deliveryCharge.tr,
                                    style: isMobile(context)? AppThemeData.titleTextStyle_14 : AppThemeData.titleTextStyle_11Tab),
                                Text(
                                    currencyConverterController.convertCurrency(
                                      isSelectPickup
                                          ? "0"
                                          : widget
                                              .addToCartListModel!
                                              .data!
                                              .calculations!
                                              .formattedShippingCost,
                                    ),
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
                                      widget.addToCartListModel!.data!
                                          .calculations!.formattedTax,
                                    ),
                                    style: isMobile(context)? AppThemeData.titleTextStyle_14 : AppThemeData.titleTextStyle_11Tab),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppTags.total.tr,
                                    style:isMobile(context)? AppThemeData.titleTextStyle_14 : AppThemeData.titleTextStyle_11Tab),
                                Text(
                                    currencyConverterController.convertCurrency(
                                      isSelectPickup
                                          ? (double.parse(widget
                                                      .addToCartListModel!
                                                      .data!
                                                      .calculations!
                                                      .formattedTotal!) -
                                                  double.parse(widget
                                                      .addToCartListModel!
                                                      .data!
                                                      .calculations!
                                                      .formattedShippingCost!))
                                              .toString()
                                          : widget.addToCartListModel!.data!
                                              .calculations!.formattedTotal,
                                    ),
                                    style: isMobile(context)? AppThemeData.titleTextStyle_14 : AppThemeData.titleTextStyle_11Tab),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.r),
                              child: InkWell(
                                onTap: () async {
                                  if (shippingAddressModel
                                          .data!.addresses!.isNotEmpty ||
                                      isSelectPickup) {
                                    await postConfirmOrder().then(
                                      (value) => Get.toNamed(
                                        Routes.paymentScreen,
                                        parameters: {
                                          'trxId': LocalDataHelper()
                                                  .getCartTrxId() ??
                                              "",
                                          'token': LocalDataHelper()
                                                  .getUserToken() ??
                                              ""
                                        },
                                      ),
                                    );
                                  } else {
                                    Get.snackbar(
                                      AppTags.selectAddress.tr,
                                      AppTags.pleaseSelectBullingOrPickupAddress
                                          .tr,
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 3),
                                      colorText: Colors.white,
                                      backgroundColor: Colors.black,
                                      forwardAnimationCurve: Curves.decelerate,
                                      shouldIconPulse: false,
                                    );
                                  }
                                },
                                child: ButtonWidget(
                                  buttonTittle: AppTags.proceedToPayment.tr,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Scaffold(body: Center(child: LoaderWidget()));
  }

  // Shipping Address
  Widget shippingAddress() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: shippingAddressModel.data!.addresses!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                 EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.5.h),
            child: Container(
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
                padding: EdgeInsets.all(13.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppTags.home_.tr,
                          style: AppThemeData.headerTextStyle_14,
                        ),
                        InkWell(
                          onTap: () {
                            onShippingTapped(index);
                            setState(() {});
                          },
                          child: shippingIndex == index
                              ? Container(
                                  height: 18.h,
                                  width: 18.w,
                                  alignment: Alignment.center,
                                  decoration:  BoxDecoration(
                                    color: const Color(0xffD16D86),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.r),
                                    ),
                                  ),
                                  child:  Padding(
                                    padding: EdgeInsets.all(2.5.r),
                                    child: Icon(
                                      Icons.check,
                                      size: 14.r,
                                      color: Colors.white,
                                    ),
                                  ))
                              : Container(
                                  height: 18.h,
                                  width: 18.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xffE1E1E1)),
                                    borderRadius:  BorderRadius.all(
                                      Radius.circular(5.r),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "${AppTags.name.tr}: ${shippingAddressModel.data!.addresses![index].name.toString()}",
                      style: isMobile(context)? AppThemeData.profileTextStyle_13:AppThemeData.profileTextStyle_10Tab,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                        "${AppTags.email.tr}: ${shippingAddressModel.data!.addresses![index].email.toString()}",
                        style: isMobile(context)? AppThemeData.profileTextStyle_13:AppThemeData.profileTextStyle_10Tab),
                    SizedBox(height: 8.h),
                    Text(
                        "${AppTags.phone.tr}: ${shippingAddressModel.data!.addresses![index].phoneNo.toString()}",
                        style: isMobile(context)? AppThemeData.profileTextStyle_13:AppThemeData.profileTextStyle_10Tab),
                    SizedBox(height: 8.h),
                    Text(
                        "${AppTags.address.tr}: ${shippingAddressModel.data!.addresses![index].address.toString()}",
                        style: isMobile(context)? AppThemeData.profileTextStyle_13:AppThemeData.profileTextStyle_10Tab),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(AppTags.confirmation.tr),
                                  content:
                                      Text(AppTags.doYouWantToDeleteAddress.tr),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(
                                                false); // dismisses only the dialog and returns false
                                      },
                                      child: Text(AppTags.no.tr),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await Repository()
                                            .deleteUserAddress(
                                                addressId: shippingAddressModel
                                                    .data!.addresses![index].id
                                                    .toString())
                                            .then((value) =>
                                                getShippingAddress());
                                        setState(() {});
                                        if (!mounted) return;
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(
                                                true); // dismisses only the dialog and returns true
                                      },
                                      child: Text(AppTags.yes.tr),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 80.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color(0xffF4F4F4), width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.r),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Text(AppTags.delete.tr,
                                  style: isMobile(context)?AppThemeData.buttonDltTextStyle_13 :AppThemeData.buttonDltTextStyle_10Tab),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        InkWell(
                          onTap: () async {
                            await getEditViewAddress(shippingAddressModel
                                    .data!.addresses![index].id!)
                                .then((value) => editAddress(
                                    shippingAddressModel
                                        .data!.addresses![index].id,
                                    editViewModel));
                          },
                          child: Container(
                            width: 80.w,
                            //   height: 42,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color(0xffF4F4F4), width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.r),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Text(AppTags.edit.tr,
                                  style: isMobile(context)? AppThemeData.buttonTextStyle_13:AppThemeData.buttonTextStyle_10Tab),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  // Billing Address
  Widget billingAddress() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: shippingAddressModel.data!.addresses!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.5.h),
            child: Container(
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
                padding: EdgeInsets.all(13.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppTags.home_.tr,
                          style: AppThemeData.headerTextStyle_14,
                        ),
                        InkWell(
                          onTap: () {
                            onBillingTapped(index);
                            setState(() {});
                          },
                          child: billingIndex == index
                              ? Container(
                                  height: 18.h,
                                  width: 18.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffD16D86),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.r),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(2.5.r),
                                    child: Icon(
                                      Icons.check,
                                      size: 14.r,
                                      color: Colors.white,
                                    ),
                                  ))
                              : Container(
                                  height: 18.h,
                                  width: 18.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xffE1E1E1)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.r),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "${AppTags.name.tr}: ${shippingAddressModel.data!.addresses![index].name.toString()}",
                      style: isMobile(context)? AppThemeData.profileTextStyle_13:AppThemeData.profileTextStyle_10Tab,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                        "${AppTags.email.tr}: ${shippingAddressModel.data!.addresses![index].email.toString()}",
                        style: isMobile(context)? AppThemeData.profileTextStyle_13:AppThemeData.profileTextStyle_10Tab),
                   SizedBox(height: 8.h),
                    Text(
                        "${AppTags.phone.tr}: ${shippingAddressModel.data!.addresses![index].phoneNo.toString()}",
                        style: isMobile(context)? AppThemeData.profileTextStyle_13:AppThemeData.profileTextStyle_10Tab),
                    SizedBox(height: 8.h),
                    Text(
                        "${AppTags.address.tr}: ${shippingAddressModel.data!.addresses![index].address.toString()}",
                        style: isMobile(context)? AppThemeData.profileTextStyle_13:AppThemeData.profileTextStyle_10Tab),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(AppTags.confirmation.tr),
                                  content:
                                      Text(AppTags.doYouWantToDeleteAddress.tr),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(
                                                false); // dismisses only the dialog and returns false
                                      },
                                      child: Text(AppTags.no.tr),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await Repository()
                                            .deleteUserAddress(
                                                addressId: shippingAddressModel
                                                    .data!.addresses![index].id
                                                    .toString())
                                            .then((value) =>
                                                getShippingAddress());
                                        setState(() {});
                                        if (!mounted) return;
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(
                                                true); // dismisses only the dialog and returns true
                                      },
                                      child: Text(AppTags.yes.tr),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 80.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color(0xffF4F4F4), width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.r),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Text(AppTags.delete.tr,
                                  style: isMobile(context)?AppThemeData.buttonDltTextStyle_13 :AppThemeData.buttonDltTextStyle_10Tab),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        InkWell(
                          onTap: () async {
                            await getEditViewAddress(shippingAddressModel
                                    .data!.addresses![index].id!)
                                .then((value) => editAddress(
                                    shippingAddressModel
                                        .data!.addresses![index].id,
                                    editViewModel));
                          },
                          child: Container(
                            width: 80.w,
                            //   height: 42,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color(0xffF4F4F4), width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.r),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Text(AppTags.edit.tr,
                                  style: isMobile(context)? AppThemeData.buttonTextStyle_13:AppThemeData.buttonTextStyle_10Tab),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  //User Confirm Order
  Future postConfirmOrder() async {
    var headers = {"apiKey": Config.apiKey};
    Map<String, String> bodyData;

    if (isSelectPickup) {
      bodyData = {
        'pick_hub_id': selectPickUpAddress.toString(),
        'trx_id': LocalDataHelper().getCartTrxId().toString()
      };
    } else {
      bodyData = {
        'shipping_address[id]':
            shippingAddressModel.data!.addresses![shippingIndex!].id.toString(),
        'shipping_address[name]': shippingAddressModel
            .data!.addresses![shippingIndex!].name
            .toString(),
        'shipping_address[email]': shippingAddressModel
            .data!.addresses![shippingIndex!].email
            .toString(),
        'shipping_address[phone_no]': shippingAddressModel
            .data!.addresses![shippingIndex!].phoneNo
            .toString(),
        'shipping_address[address]': shippingAddressModel
            .data!.addresses![shippingIndex!].address
            .toString(),
        'shipping_address[address_ids][country_id]': shippingAddressModel
            .data!.addresses![shippingIndex!].addressIds!.countryId!
            .toString(),
        'shipping_address[address_ids][state_id]': shippingAddressModel
            .data!.addresses![shippingIndex!].addressIds!.stateId!
            .toString(),
        'shipping_address[address_ids][city_id]': shippingAddressModel
            .data!.addresses![shippingIndex!].addressIds!.cityId!
            .toString(),
        'shipping_address[country]': shippingAddressModel
            .data!.addresses![shippingIndex!].country
            .toString(),
        'shipping_address[state]': shippingAddressModel
            .data!.addresses![shippingIndex!].state
            .toString(),
        'shipping_address[city]': shippingAddressModel
            .data!.addresses![shippingIndex!].city
            .toString(),
        'shipping_address[latitude]': shippingAddressModel
            .data!.addresses![shippingIndex!].latitude
            .toString(),
        'shipping_address[longitude]': shippingAddressModel
            .data!.addresses![shippingIndex!].longitude
            .toString(),
        'shipping_address[postal_code]': shippingAddressModel
            .data!.addresses![shippingIndex!].postalCode
            .toString(),
        'billing_address[id]': isSelectBilling
            ? shippingAddressModel.data!.addresses![shippingIndex!].id
                .toString()
            : shippingAddressModel.data!.addresses![billingIndex!].id
                .toString(),
        'billing_address[name]': isSelectBilling
            ? shippingAddressModel.data!.addresses![shippingIndex!].name
                .toString()
            : shippingAddressModel.data!.addresses![billingIndex!].name
                .toString(),
        'billing_address[email]': isSelectBilling
            ? shippingAddressModel.data!.addresses![shippingIndex!].email
                .toString()
            : shippingAddressModel.data!.addresses![billingIndex!].email
                .toString(),
        'billing_address[phone_no]': isSelectBilling
            ? shippingAddressModel.data!.addresses![shippingIndex!].phoneNo
                .toString()
            : shippingAddressModel.data!.addresses![billingIndex!].phoneNo
                .toString(),
        'billing_address[address]': isSelectBilling
            ? shippingAddressModel.data!.addresses![shippingIndex!].address
                .toString()
            : shippingAddressModel.data!.addresses![billingIndex!].address
                .toString(),
        'billing_address[address_ids][country_id]': isSelectBilling
            ? shippingAddressModel
                .data!.addresses![shippingIndex!].addressIds!.countryId!
                .toString()
            : shippingAddressModel
                .data!.addresses![billingIndex!].addressIds!.countryId!
                .toString(),
        'billing_address[address_ids][state_id]': isSelectBilling
            ? shippingAddressModel
                .data!.addresses![shippingIndex!].addressIds!.stateId!
                .toString()
            : shippingAddressModel
                .data!.addresses![billingIndex!].addressIds!.stateId!
                .toString(),
        'billing_address[address_ids][city_id]': isSelectBilling
            ? shippingAddressModel
                .data!.addresses![shippingIndex!].addressIds!.cityId!
                .toString()
            : shippingAddressModel
                .data!.addresses![billingIndex!].addressIds!.cityId!
                .toString(),
        'billing_address[country]': isSelectBilling
            ? shippingAddressModel.data!.addresses![shippingIndex!].country
                .toString()
            : shippingAddressModel.data!.addresses![billingIndex!].country
                .toString(),
        'billing_address[state]': isSelectBilling
            ? shippingAddressModel.data!.addresses![shippingIndex!].state
                .toString()
            : shippingAddressModel.data!.addresses![billingIndex!].state
                .toString(),
        'billing_address[city]': isSelectBilling
            ? shippingAddressModel.data!.addresses![shippingIndex!].city
                .toString()
            : shippingAddressModel.data!.addresses![billingIndex!].city
                .toString(),
        'billing_address[latitude]': isSelectBilling
            ? shippingAddressModel.data!.addresses![shippingIndex!].latitude
                .toString()
            : shippingAddressModel.data!.addresses![billingIndex!].latitude
                .toString(),
        'billing_address[longitude]': isSelectBilling
            ? shippingAddressModel.data!.addresses![shippingIndex!].longitude
                .toString()
            : shippingAddressModel.data!.addresses![billingIndex!].longitude
                .toString(),
        'billing_address[postal_code]': isSelectBilling
            ? shippingAddressModel.data!.addresses![shippingIndex!].postalCode
                .toString()
            : shippingAddressModel.data!.addresses![billingIndex!].postalCode
                .toString(),
        'trx_id': LocalDataHelper().getCartTrxId().toString()
      };
    }

    Uri url;
    if (LocalDataHelper().getUserToken() == null) {
      url = Uri.parse("${NetworkService.apiUrl}/confirm-order");
    } else {
      url = Uri.parse(
          "${NetworkService.apiUrl}/confirm-order?token=${LocalDataHelper().getUserToken()}");
    }
    final response = await http.post(
      url,
      body: bodyData,
      headers: headers,
    );
    if (response.statusCode == 200) {
      //showShortToast(data["message"].toString());
    } else {
      showShortToast("No response");
    }
  }

  //Create Address
  Future createAddress() {
    return showDialog(
      //barrierColor: Colors.red,
      barrierDismissible: false,
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return WillPopScope(
              onWillPop: () => Future.value(true),
              child: AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTags.addAddress.tr,
                      style: AppThemeData.priceTextStyle_14,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 18.h,
                        width: 18.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xff56A8C7),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.r),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2.5.r),
                          child: Icon(
                            Icons.clear,
                            size: 12.r,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                content: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.zero,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppTags.name.tr,
                          style: AppThemeData.titleTextStyle_13,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          height: 42.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffF4F4F4)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.r),
                            ),
                          ),
                          child: TextFormField(
                            controller: nameController,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.name,
                            validator: (value) => textFieldValidator(
                              AppTags.name.tr,
                              nameController,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppTags.name.tr,
                              hintStyle: AppThemeData.hintTextStyle_13,
                              contentPadding: EdgeInsets.only(
                                left: 8.w,
                                right: 8.w,
                                bottom: 5.h,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          AppTags.email.tr,
                          style: AppThemeData.titleTextStyle_13,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          height: 42.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffF4F4F4)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.r),
                            ),
                          ),
                          child: TextFormField(
                            controller: emailController,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => textFieldValidator(
                              AppTags.email.tr,
                              emailController,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppTags.email.tr,
                              hintStyle: AppThemeData.hintTextStyle_13,
                              contentPadding: EdgeInsets.only(
                                left: 8.w,
                                right: 8.w,
                                bottom: 5.h,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          AppTags.phone.tr,
                          style: AppThemeData.titleTextStyle_13,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          height: 42.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 12.w, right: 4.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffF4F4F4)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.r),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 7,
                                child: CountryPickerDropdown(
                                  isFirstDefaultIfInitialValueNotProvided:
                                      false,
                                  initialValue: 'BD',
                                  isExpanded: true,
                                  itemBuilder: (Country country) => Row(
                                    children: <Widget>[
                                      CountryPickerUtils.getDefaultFlagImage(
                                          country),
                                      Text("+${country.phoneCode}"),
                                    ],
                                  ),
                                  onValuePicked: (Country country) {
                                    setState(() {
                                      phoneCode = country.phoneCode;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: TextFormField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) => textFieldValidator(
                                    AppTags.phone.tr,
                                    phoneController,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 8.w,
                                      right: 8.w,
                                      bottom: 5.h,
                                    ),
                                    border: InputBorder.none,
                                    hintText: AppTags.phone.tr,
                                    hintStyle: AppThemeData.hintTextStyle_13,
                                  ),
                                  onChanged: (value) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          AppTags.country.tr,
                          style: AppThemeData.titleTextStyle_13,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          height: 42.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 12.w, right: 4.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffF4F4F4)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.r),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text(
                                AppTags.selectCountry.tr,
                                style: AppThemeData.hintTextStyle_13,
                              ),
                              value: _selectedCountry,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedCountry = newValue;
                                });
                              },
                              items: countryListModel.data!.countries!
                                  .map((country) {
                                return DropdownMenuItem(
                                  onTap: () async {
                                    await getStateList(country.id);
                                    setState(() {});
                                  },
                                  value: country.id,
                                  child: Text(country.name.toString()),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          AppTags.state.tr,
                          style: AppThemeData.titleTextStyle_13,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        stateListModel.data != null
                            ? Container(
                                height: 42.h,
                                alignment: Alignment.center,
                                padding:
                                     EdgeInsets.only(left: 12.w, right: 4.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0xffF4F4F4)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.r),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text(
                                      AppTags.selectState.tr,
                                      style: AppThemeData.hintTextStyle_13,
                                    ),
                                    value: _selectedState,
                                    onChanged: (newValue) {
                                      setState(
                                        () {
                                          _selectedState = newValue!;
                                        },
                                      );
                                    },
                                    items: stateListModel.data!.states!
                                        .map((state) {
                                      return DropdownMenuItem(
                                        onTap: () async {
                                          await getCityList(state.id);
                                          setState(() {});
                                        },
                                        value: state.id,
                                        child: Text(state.name.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            : Container(
                                height: 42.h,
                                alignment: Alignment.center,
                                padding:
                                     EdgeInsets.only(left: 12.w, right: 4.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0xffF4F4F4)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.r),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text(AppTags.selectState.tr,
                                        style: AppThemeData.hintTextStyle_13),
                                    value: _selectedState,
                                    onChanged: (newValue) {
                                      setState(
                                        () {
                                          _selectedState = newValue!;
                                        },
                                      );
                                    },
                                    items: null,
                                  ),
                                ),
                              ),
                        SizedBox(height: 16.r),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppTags.city.tr,
                              style: AppThemeData.titleTextStyle_13,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            cityModel.data != null
                                ? Container(
                                    height: 42.h,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                        left: 12.w, right: 4.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color(0xffF4F4F4)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.r),
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        hint: Text(
                                          AppTags.selectCity.tr,
                                          style: AppThemeData.hintTextStyle_13,
                                        ),
                                        value: _selectedCity,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedCity = newValue;
                                          });
                                        },
                                        items:
                                            cityModel.data!.cities!.map((city) {
                                          return DropdownMenuItem(
                                            onTap: () {},
                                            value: city.id,
                                            child: Text(city.name.toString()),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 42.h,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                        left: 12.w, right: 4.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color(0xffF4F4F4)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.r),
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text(AppTags.selectCity.tr,
                                              style: AppThemeData
                                                  .hintTextStyle_13),
                                          value: _selectedCity,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _selectedCity = newValue;
                                            });
                                          },
                                          items: null),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          AppTags.postalCode.tr,
                          style: AppThemeData.titleTextStyle_13,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          height: 42.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffF4F4F4)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.r),
                            ),
                          ),
                          child: TextFormField(
                            controller: postalCodeController,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.name,
                            validator: (value) => textFieldValidator(
                              AppTags.postalCode.tr,
                              postalCodeController,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppTags.postalCode.tr,
                              hintStyle: AppThemeData.hintTextStyle_13,
                              contentPadding:  EdgeInsets.only(
                                left: 8.w,
                                right: 8.w,
                                bottom: 5.h,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          AppTags.address.tr,
                          style: AppThemeData.titleTextStyle_13,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          height: 65.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffF4F4F4)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.r),
                            ),
                          ),
                          child: TextFormField(
                            controller: addressController,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.name,
                            validator: (value) => textFieldValidator(
                              AppTags.address.tr,
                              addressController,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppTags.streetAddress.tr,
                              hintStyle: AppThemeData.hintTextStyle_13,
                              contentPadding: EdgeInsets.only(
                                left: 8.w,
                                right: 8.w,
                                bottom: 5.h,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15.w, bottom: 15.h, right: 15.w),
                    child: InkWell(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await Repository()
                              .postCreateAddress(
                                name: nameController.text.toString(),
                                email: emailController.text.toString(),
                                phoneNo:
                                    "+$phoneCode ${phoneController.text.toString()}",
                                countryId: _selectedCountry,
                                stateId: _selectedState,
                                cityId: _selectedCity,
                                postalCode:
                                    postalCodeController.text.toString(),
                                address: addressController.text.toString(),
                              )
                              .then((value) => getShippingAddress());
                          Get.back();
                        }
                      },
                      child: Container(
                        alignment: Alignment.bottomRight,
                        width: 80.w,
                        height: 42.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffF4F4F4)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.r),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            AppTags.add.tr,
                            style: isMobile(context)? AppThemeData.buttonTextStyle_13:AppThemeData.buttonTextStyle_10Tab,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  //Edit Address
  Future editAddress(int? addressId, EditViewModel editViewModel) {
    return showDialog(
      //barrierColor: Colors.red,
      barrierDismissible: false,
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return WillPopScope(
                onWillPop: () => Future.value(true),
                child: AlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppTags.addAddress.tr,
                        style: AppThemeData.priceTextStyle_14,
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            height: 18.h,
                            width: 18.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xff56A8C7),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.r),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2.5.r),
                              child: Icon(
                                Icons.clear,
                                size: 12.r,
                                color: Colors.white,
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                  content: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.zero,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppTags.name.tr,
                          style: AppThemeData.titleTextStyle_13,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          height: 42.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffF4F4F4)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.r),
                            ),
                          ),
                          child: TextField(
                            controller: nameController,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              // label: Text(editViewModel.data!.address!.name.toString()),
                              border: InputBorder.none,
                              hintText:
                                  editViewModel.data!.address!.name.toString(),
                              hintStyle: AppThemeData.hintTextStyle_13,
                              contentPadding: EdgeInsets.only(
                                  left: 8.w, right: 8.w, bottom: 8.h),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          AppTags.email.tr,
                          style: AppThemeData.titleTextStyle_13,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          height: 42.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffF4F4F4)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.r),
                            ),
                          ),
                          child: TextField(
                            controller: emailController,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  editViewModel.data!.address!.email.toString(),
                              hintStyle: AppThemeData.hintTextStyle_13,
                              contentPadding: EdgeInsets.only(
                                  left: 8.w, right: 8.w, bottom: 8.h),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          AppTags.phone.tr,
                          style: AppThemeData.titleTextStyle_13,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          height: 42.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffF4F4F4)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.r),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 7,
                                child: CountryPickerDropdown(
                                  isFirstDefaultIfInitialValueNotProvided:
                                      false,
                                  initialValue: 'BD',
                                  isExpanded: true,
                                  itemBuilder: _buildDropdownItem,
                                  onValuePicked: (Country country) {
                                    setState(() {
                                      phoneCode=country.phoneCode;
                                    });

                                  },
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: TextField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: editViewModel
                                        .data!.address!.phoneNo
                                        .toString(),
                                  ),
                                  onChanged: (value) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          AppTags.country.tr,
                          style: AppThemeData.titleTextStyle_13,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          height: 42.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffF4F4F4)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.r),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Padding(
                                padding: EdgeInsets.only(left: 6.w),
                                child: Text(
                                  editViewModel.data!.address!.country!
                                      .toString(),
                                  style: AppThemeData.hintTextStyle_13,
                                ),
                              ),
                              // Not necessary for Option 1
                              value: _selectedCountry,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedCountry = newValue;
                                });
                              },
                              items: countryListModel.data!.countries!
                                  .map((country) {
                                return DropdownMenuItem(
                                  onTap: () async {
                                    await getStateList(country.id);
                                    setState(() {});
                                  },
                                  value: country.id,
                                  child: Text(country.name.toString()),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          AppTags.state.tr,
                          style: AppThemeData.titleTextStyle_13,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        stateListModel.data != null
                            ? Container(
                                height: 42.h,
                                alignment: Alignment.center,
                                padding:
                                     EdgeInsets.symmetric(horizontal: 4.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0xffF4F4F4)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.r),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Padding(
                                      padding: EdgeInsets.only(left: 6.w),
                                      child: Text(
                                        editViewModel.data!.address!.state!
                                            .toString(),
                                        style: AppThemeData.hintTextStyle_13,
                                      ),
                                    ),
                                    value: _selectedState,
                                    onChanged: (newValue) {
                                      setState(
                                        () {
                                          _selectedState = newValue!;
                                        },
                                      );
                                    },
                                    items: stateListModel.data!.states!
                                        .map((state) {
                                      return DropdownMenuItem(
                                        onTap: () async {
                                          await getCityList(state.id);
                                          setState(() {});
                                        },
                                        value: state.id,
                                        child: Text(state.name.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            : Container(
                                height: 42.h,
                                alignment: Alignment.center,
                                padding:
                                     EdgeInsets.symmetric(horizontal: 4.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0xffF4F4F4)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.r),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Padding(
                                      padding: EdgeInsets.only(left: 6.w),
                                      child: Text(
                                        editViewModel.data!.address!.state!
                                            .toString(),
                                        style: AppThemeData.hintTextStyle_13,
                                      ),
                                    ),
                                    // Not necessary for Option 1
                                    value: _selectedState,
                                    onChanged: (newValue) {
                                      setState(
                                        () {
                                          _selectedState = newValue!;
                                        },
                                      );
                                    },
                                    items: null,
                                  ),
                                ),
                              ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          height: 73.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppTags.city.tr,
                                      style: AppThemeData.titleTextStyle_13,
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    cityModel.data != null
                                        ? Container(
                                            height: 42.h,
                                            alignment: Alignment.center,
                                            padding:  EdgeInsets.symmetric(
                                                horizontal: 4.w),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffF4F4F4)),
                                              borderRadius:
                                                   BorderRadius.all(
                                                Radius.circular(5.r),
                                              ),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                isExpanded: true,
                                                hint: Padding(
                                                  padding:
                                                       EdgeInsets.only(
                                                          left: 6.w),
                                                  child: Text(
                                                    editViewModel
                                                        .data!.address!.city!
                                                        .toString(),
                                                    style: AppThemeData
                                                        .hintTextStyle_13,
                                                  ),
                                                ),
                                                value: _selectedCity,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _selectedCity = newValue;
                                                  });
                                                },
                                                items: cityModel.data!.cities!
                                                    .map((city) {
                                                  return DropdownMenuItem(
                                                    onTap: () {},
                                                    value: city.id,
                                                    child: Text(
                                                        city.name.toString()),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: 42.h,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.w),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffF4F4F4)),
                                              borderRadius:
                                                   BorderRadius.all(
                                                Radius.circular(5.r),
                                              ),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                  isExpanded: true,
                                                  hint: Padding(
                                                    padding:
                                                         EdgeInsets.all(
                                                            6.r),
                                                    child: Text(
                                                      editViewModel
                                                          .data!.address!.city!
                                                          .toString(),
                                                      style: AppThemeData
                                                          .hintTextStyle_13,
                                                    ),
                                                  ),
                                                  value: _selectedCity,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _selectedCity = newValue;
                                                    });
                                                  },
                                                  items: null),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 0,
                                  child: SizedBox(
                                    width: 15.w,
                                  )),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppTags.postalCode.tr,
                                      style: AppThemeData.titleTextStyle_13,
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Container(
                                      height: 42.h,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: const Color(0xffF4F4F4)),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.r),
                                        ),
                                      ),
                                      child: TextField(
                                        controller: postalCodeController,
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: editViewModel
                                              .data!.address!.postalCode!
                                              .toString(),
                                          hintStyle:
                                              AppThemeData.hintTextStyle_13,
                                          contentPadding: EdgeInsets.only(
                                              left: 8.w,
                                              right: 8.w,
                                              bottom: 8.h
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          AppTags.address.tr,
                          style: AppThemeData.titleTextStyle_13,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          height: 42.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffF4F4F4)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.r),
                            ),
                          ),
                          child: TextField(
                            controller: addressController,
                            maxLines: 3,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: editViewModel.data!.address!.address!
                                  .toString(),
                              hintStyle: AppThemeData.hintTextStyle_13,
                              contentPadding: EdgeInsets.only(
                                  left: 8.w, right: 8.w, bottom: 8.h),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Padding(
                      padding:  EdgeInsets.only(
                          left: 15.w, bottom: 15.h, right: 15.w),
                      child: InkWell(
                        onTap: () async {
                          await Repository()
                              .updateEditAddress(
                            name: nameController.text.isNotEmpty?nameController.text.toString():editViewModel.data!.address!.name.toString(),
                            email: emailController.text.isNotEmpty?emailController.text.toString():editViewModel.data!.address!.email.toString(),
                            phoneNo: phoneController.text.isNotEmpty?"+$phoneCode ${phoneController.text.toString()}":editViewModel.data!.address!.phoneNo.toString(),
                            countryId: _selectedCountry ?? int.parse(editViewModel.data!.address!.addressIds!.countryId.toString()),
                            stateId: _selectedState ?? int.parse(editViewModel.data!.address!.addressIds!.stateId.toString()),
                            cityId: _selectedCity ?? int.parse(editViewModel.data!.address!.addressIds!.cityId.toString()),
                            postalCode: postalCodeController.text.isNotEmpty?postalCodeController.text.toString():editViewModel.data!.address!.postalCode.toString(),
                            address: addressController.text.isNotEmpty?addressController.text.toString():editViewModel.data!.address!.address.toString(),
                            addressId: addressId!,
                              )
                              .then((value) => getShippingAddress());
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.bottomRight,
                          width: 80.w,
                          height: 42.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffF4F4F4)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.r),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              AppTags.add.tr,
                              style: isMobile(context)? AppThemeData.buttonTextStyle_13:AppThemeData.buttonTextStyle_10Tab,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          },
        );
      },
    );
  }

  textFieldValidator(name, textController) {
    if (textController.text.isEmpty) {
      return "$name ${AppTags.required.tr}";
    }
  }

  Widget _buildDropdownItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          Text("+${country.phoneCode}"),
        ],
      );
}
