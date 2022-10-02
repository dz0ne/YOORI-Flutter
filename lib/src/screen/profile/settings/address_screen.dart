import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/controllers/currency_converter_controller.dart';
import 'package:yoori_ecommerce/src/models/edit_view_model.dart';
import 'package:yoori_ecommerce/src/models/shipping_address_model/country_list_model.dart';
import 'package:yoori_ecommerce/src/models/shipping_address_model/get_city_model.dart';
import 'package:yoori_ecommerce/src/models/shipping_address_model/shipping_address_model.dart';
import 'package:yoori_ecommerce/src/models/shipping_address_model/state_list_model.dart';
import 'package:yoori_ecommerce/src/servers/repository.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/data/local_data_helper.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yoori_ecommerce/src/utils/constants.dart';

import '../../../utils/responsive.dart';
import '../../../widgets/loader/loader_widget.dart';


class Addresses extends StatefulWidget {
  const Addresses({
    Key? key,
  }) : super(key: key);

  @override
  State<Addresses> createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final postalCodeController = TextEditingController();
  final addressController = TextEditingController();
  final currencyConverterController = Get.find<CurrencyConverterController>();
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
      key: scaffoldKey,
      appBar: isMobile(context)? AppBar(
        backgroundColor: Colors.white,
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
          AppTags.addAddress.tr,
          style: AppThemeData.headerTextStyle_16,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.w),
            child: TextButton(
              child: Text(
                "+ ${AppTags.add.tr}",
                style: isMobile(context)? AppThemeData.addAddressTextStyle_13:AppThemeData.addAddressTextStyle_10Tab,
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
          AppTags.addAddress.tr,
          style: AppThemeData.headerTextStyle_14,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: TextButton(
              child: Text(
                "+ ${AppTags.add.tr}",
                style: isMobile(context)? AppThemeData.addAddressTextStyle_13:AppThemeData.addAddressTextStyle_10Tab,
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
        child: token != null ? shippingAddress() : const SizedBox(),
      ),
    )
        : const Scaffold(body: Center(child: LoaderWidget()));
  }

  // Shipping Address
  Widget shippingAddress() {
    return ListView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
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
                          style: isMobile(context)? AppThemeData.headerTextStyle_14:AppThemeData.titleTextStyle_11Tab,
                        ),
                        InkWell(
                            onTap: () {
                              onShippingTapped(index);
                              setState(() {});
                            },
                            child: shippingAddressModel.data!.addresses![index]
                                .defaultBilling !=
                                0 ||
                                shippingAddressModel.data!.addresses![index]
                                    .defaultShipping !=
                                    0
                                ? Container(
                                height: 20.h,
                                width: 100.w,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Color(0xffF4F4F4),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Text(
                                  AppTags.defaultAddress.tr,
                                  style:isMobile(context)? AppThemeData.addressDefaultTextStyle_10:AppThemeData.addressDefaultTextStyle_10.copyWith(fontSize: 8.sp
                                  ),
                                ))
                                : const SizedBox()),
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
                        "${AppTags.country.tr}: ${shippingAddressModel.data!.addresses![index].country.toString()}",
                        style:isMobile(context)? AppThemeData.profileTextStyle_13:AppThemeData.profileTextStyle_10Tab),
                    SizedBox(height: 8.h),
                    Text(
                        "${AppTags.state.tr}: ${shippingAddressModel.data!.addresses![index].state.toString()}",
                        style: isMobile(context)? AppThemeData.profileTextStyle_13:AppThemeData.profileTextStyle_10Tab),
                    SizedBox(height: 8.h),
                    Text(
                        "${AppTags.city.tr}: ${shippingAddressModel.data!.addresses![index].city.toString()}",
                        style: isMobile(context)? AppThemeData.profileTextStyle_13:AppThemeData.profileTextStyle_10Tab),
                    SizedBox(height: 8.h),
                    Text(
                        "${AppTags.address.tr}: ${shippingAddressModel.data!.addresses![index].address.toString()}",
                        style: isMobile(context)? AppThemeData.profileTextStyle_13:AppThemeData.profileTextStyle_10Tab),
                    SizedBox(height: 10.h),
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
                              borderRadius:  BorderRadius.all(
                                Radius.circular(5.r),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Text(AppTags.delete.tr,
                                  style:isMobile(context)? AppThemeData.buttonDltTextStyle_13:AppThemeData.buttonDltTextStyle_10Tab),
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
                                  style:isMobile(context)? AppThemeData.buttonTextStyle_13:AppThemeData.buttonTextStyle_10Tab),
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

  //Create Address

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
                      style: isMobile(context)? AppThemeData.priceTextStyle_14:AppThemeData.priceTextStyle_14.copyWith(fontSize: 11.sp),
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
                          style: isMobile(context)? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
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
                              hintStyle: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
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
                          style: isMobile(context)? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
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
                              hintStyle: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
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
                          style: isMobile(context)? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
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
                                  isFirstDefaultIfInitialValueNotProvided: false,
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
                                    hintStyle: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
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
                          style: isMobile(context)? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
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
                                style: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
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
                          style: isMobile(context)? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
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
                                style: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
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
                                  style: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab),
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
                              style: isMobile(context)? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
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
                                    style: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
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
                                        style: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab),
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
                          style: isMobile(context)? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
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
                              hintStyle: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
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
                          style: isMobile(context)? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
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
                              hintStyle: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
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
                        style: isMobile(context)? AppThemeData.priceTextStyle_14:AppThemeData.priceTextStyle_14.copyWith(fontSize: 11.sp),
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
                            child:  Padding(
                              padding: EdgeInsets.all(2.5.r),
                              child: Icon(
                                Icons.clear,
                                size: 12.r,
                                color: Colors.white,
                              ),
                            )),
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
                          style: isMobile(context)? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
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
                              hintStyle: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
                              contentPadding: EdgeInsets.only(
                                  left: 8.w, right: 8.w, bottom: 8.h),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          AppTags.email.tr,
                          style: isMobile(context)? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
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
                              hintStyle: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
                              contentPadding: EdgeInsets.only(
                                  left: 8.w, right: 8.w, bottom: 8.h),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          AppTags.phone.tr,
                          style: isMobile(context)? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
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
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
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
                                      printLog(country.phoneCode);
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
                          style: isMobile(context)? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
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
                                  style: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
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
                          style: isMobile(context)? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
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
                                  style: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
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
                                  style: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
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
                                      style: isMobile(context)? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    cityModel.data != null
                                        ? Container(
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
                                             EdgeInsets.only(
                                                left: 6.w),
                                            child: Text(
                                              editViewModel
                                                  .data!.address!.city!
                                                  .toString(),
                                              style: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
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
                                              padding: EdgeInsets.all(
                                                  6.r),
                                              child: Text(
                                                editViewModel
                                                    .data!.address!.city!
                                                    .toString(),
                                                style:isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
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
                                      style: isMobile(context)? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
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
                                          isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
                                          contentPadding: EdgeInsets.only(
                                              left: 8.w,
                                              right: 8.w,
                                              bottom: 8.h),
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
                          style: isMobile(context)? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          height: 48.h,
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
                              hintStyle: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
                              contentPadding: EdgeInsets.only(
                                  left: 8.w, right: 8.w, bottom: 8.h,top: 5.h),
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
                      padding: EdgeInsets.only(
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


