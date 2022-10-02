import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data/local_data_helper.dart';
import '../models/edit_view_model.dart';
import '../models/shipping_address_model/country_list_model.dart';
import '../models/shipping_address_model/get_city_model.dart';
import '../models/shipping_address_model/shipping_address_model.dart';
import '../models/shipping_address_model/state_list_model.dart';
import '../servers/repository.dart';
import 'currency_converter_controller.dart';

class AddressScreenController extends GetxController{
  final currencyConverterController = Get.find<CurrencyConverterController>();
  String? token = LocalDataHelper().getUserToken();
  var isLoader = true.obs;

  var shippingIndex = 0.obs;
  void onShippingTapped(int? index) {
      shippingIndex.value = index!;
  }

  var billingIndex = 0.obs;
  void onBillingTapped(int? index) {
      billingIndex.value = index!;
  }

  String? phoneCode = "880";
  dynamic selectPickUpAddress;
  dynamic selectedCountry; // Option 2
  dynamic selectedState; // Option 2// Option 2
  dynamic selectedCity;

  selectCountryUpdate(value) {
    selectedCountry = value;
    update();
  }
  selectStateUpdate(value) {
    selectedState = value;
    update();
  }
  selectCityUpdate(value) {
    selectedCity = value;
    update();
  }// Option 2


  Rx<ShippingAddressModel> shippingAddressModel = ShippingAddressModel().obs;
  Future getShippingAddress() async {
    shippingAddressModel.value = await Repository().getShippingAddress();

  }

  CountryListModel countryListModel = CountryListModel();
  Future getCountryList() async {
    countryListModel = await Repository().getCountryList();
  }

  StateListModel stateListModel = StateListModel();
  Future getStateList(int? countryId) async {
    stateListModel = await Repository().getStateList(countryId: countryId);
  }

  GetCitisModel cityModel = GetCitisModel();
  Future getCityList(int? stateId) async {
    cityModel = await Repository().getCityList(stateId: stateId);
  }

  EditViewModel editViewModel = EditViewModel();
  Future getEditViewAddress(int addressId) async {
    editViewModel = await Repository().getEditViewAddress(addressId);
  }
  //Create address
  Future createAddress({
    required String name,
    required String email,
    required String phoneNo,
    required int countryId,
    required int stateId,
    required int cityId,
    required String postalCode,
    required String address,
    }) async{
    await Repository()
        .postCreateAddress(
      name: name,
      email: email,
      phoneNo: phoneNo,
      countryId: countryId,
      stateId: countryId,
      cityId: countryId,
      postalCode: postalCode,
      address: address,
    );
  }

  //Edit address
  Future editAddress({
    required String name,
    required String email,
    required String phoneNo,
    required int countryId,
    required int stateId,
    required int cityId,
    required String postalCode,
    required String address,
    required int addressId})async{
    await Repository().updateEditAddress(
      name: name,
      email: email,
      phoneNo: phoneNo,
      countryId: countryId,
      stateId: stateId,
      cityId: cityId,
      postalCode: postalCode,
      address: address,
      addressId: addressId,
    );
  }

  //Delete address
  Future deleteAddress({String? addressId})async{
    await Repository()
        .deleteUserAddress(
        addressId: addressId);
  }

  @override
  void onInit() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    getCountryList();
    getShippingAddress();
    super.onInit();
  }

}