import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yoori_ecommerce/config.dart';

import 'package:http/http.dart' as http;
import 'package:yoori_ecommerce/src/models/all_brand_model.dart';
import 'package:yoori_ecommerce/src/models/all_campaign_model.dart' as campaign;
import 'package:yoori_ecommerce/src/models/all_category_model.dart';
import 'package:yoori_ecommerce/src/models/all_category_product_model.dart';
import 'package:yoori_ecommerce/src/models/all_news_model.dart' as news;
import 'package:yoori_ecommerce/src/models/all_notifications.dart';
import 'package:yoori_ecommerce/src/models/all_product_model.dart'
    as all_product;
import 'package:yoori_ecommerce/src/models/best_selling_product_model.dart'
    as best_sell;
import 'package:yoori_ecommerce/src/models/campaign_details_model.dart';
import 'package:yoori_ecommerce/src/models/config_model.dart';
import 'package:yoori_ecommerce/src/models/coupon_applied_list.dart';
import 'package:yoori_ecommerce/src/models/coupon_list_model.dart';
import 'package:yoori_ecommerce/src/models/edit_view_model.dart';
import 'package:yoori_ecommerce/src/models/favorite_product_model.dart';
import 'package:yoori_ecommerce/src/models/my_download_model.dart';
import 'package:yoori_ecommerce/src/models/my_reward_model.dart';
import 'package:yoori_ecommerce/src/models/my_wallet_model.dart';
import 'package:yoori_ecommerce/src/models/offer_ending_product_model.dart'
    as offer_ending;
import 'package:yoori_ecommerce/src/models/home_data_model.dart';
import 'package:yoori_ecommerce/src/models/order_list_model.dart';
import 'package:yoori_ecommerce/src/models/product_by_brand_model.dart'
    as brand;
import 'package:yoori_ecommerce/src/models/product_by_campaign_model.dart';
import 'package:yoori_ecommerce/src/models/product_by_category_model.dart'
    as product;
import 'package:yoori_ecommerce/src/models/product_by_shop_model.dart';
import 'package:yoori_ecommerce/src/models/product_details_model.dart';
import 'package:yoori_ecommerce/src/models/profile_data_model.dart';
import 'package:yoori_ecommerce/src/models/search_product_model.dart';
import 'package:yoori_ecommerce/src/models/shipping_address_model/get_city_model.dart';
import 'package:yoori_ecommerce/src/models/shipping_address_model/shipping_address_model.dart';
import 'package:yoori_ecommerce/src/models/shipping_address_model/state_list_model.dart';
import 'package:yoori_ecommerce/src/models/top_shop_model.dart' as top_shop;
import 'package:yoori_ecommerce/src/models/track_order_model.dart';
import 'package:yoori_ecommerce/src/models/user_data_model.dart';
import 'package:yoori_ecommerce/src/models/recent_viewed_product_model.dart'
    as recent_product;
import 'package:yoori_ecommerce/src/models/visit_shop_model.dart';
import 'package:yoori_ecommerce/src/screen/auth_screen/otp_screen.dart';
import 'package:yoori_ecommerce/src/servers/network_service.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/constants.dart';
import 'package:yoori_ecommerce/src/data/local_data_helper.dart';
import 'package:yoori_ecommerce/src/utils/validators.dart';
import '../models/add_to_cart_list_model.dart';
import '../models/add_to_cart_model.dart';
import '../models/all_shop_model.dart' as all_shop;
import '../models/best_shop_model.dart' as best_shop;
import '../models/flash_sale_model.dart' as flash_sale;
import '../models/shipping_address_model/country_list_model.dart';
import '../models/forget_password_model.dart';
import '../models/today_deal_model.dart' as today_deal;
import '../screen/dashboard/dashboard_screen.dart';

class Repository {
  final NetworkService _service = NetworkService();

  String langCurrCode =
      "lang=${LocalDataHelper().getLangCode()}&curr=${LocalDataHelper().getCurrCode()}";

  //firebase auth
  Future<UserDataModel?> postFirebaseAuth({
    String? name,
    String? email,
    String? phone,
    String? image,
    String? providerId,
    String? uid,
  }) async {
    var headers = {"apiKey": Config.apiKey};
    var url = Uri.parse("${NetworkService.apiUrl}/social-login");

    Map<String, dynamic> data = {
      "name": name,
      "email": email.toString(),
      "phone": phone.toString(),
      "image": image,
      "provider": providerId,
      "uid": uid,
    };

    try {
      final response = await http.post(url,
          headers: headers, body: data, encoding: Encoding.getByName("utf-8"));
      printLog("firebase auth repository: ${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['success']) {
          UserDataModel userDataModel = UserDataModel.fromJson(jsonData);
          LocalDataHelper().saveUserToken(userDataModel.data!.token);
          LocalDataHelper().saveUserAllData(userDataModel);
          return userDataModel;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      printLog("firebase auth error on repository: $e");
      return null;
    }
  }

  //User Phone Login
  Future<bool?> postPhoneLogin({String? phoneNumber}) async {
    var headers = {"apiKey": Config.apiKey};
    String? loginOTPScreen = "loginOTPScreen";
    var body = {
      'phone': phoneNumber,
    };
    var url = Uri.parse("${NetworkService.apiUrl}/get-login-otp?$langCurrCode");
    final response = await http.post(url, body: body, headers: headers);

    var data = json.decode(response.body);
    if (data['success']) {
      Get.off(() => OtpScreen(
            phoneNumber: phoneNumber.toString(),
            screen: loginOTPScreen,
          ));
      return data['success'];
    } else {
      showErrorToast(data['message']);
      return false;
    }
  }

  //User Login
  Future<bool?> postPhoneLoginOTP(
      {String? phoneNumber, var otp}) async {

    var headers = {"apiKey": Config.apiKey};
    var body = {
      'phone': phoneNumber,
      'otp': otp,
    };
    var url =
        Uri.parse("${NetworkService.apiUrl}/verify-login-otp?$langCurrCode");
    final response = await http.post(url, body: body, headers: headers);

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      UserDataModel userDataModel = UserDataModel.fromJson(data);
      LocalDataHelper().saveUserToken(userDataModel.data!.token);
      LocalDataHelper().saveUserAllData(userDataModel);

      showShortToast(userDataModel.message.toString());
      return userDataModel.success;
    } else {
      showErrorToast(data['message']);
      return false;
    }
  }

  //User Phone Registration
  Future<bool?> postPhoneRegistration(
      {String? firstName, String? lastName, String? phoneNumber}) async {
    var headers = {"apiKey": Config.apiKey};
    String? registrationOTpScreen = "registrationOTpScreen";
    var body = {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phoneNumber,
    };
    var url =
        Uri.parse("${NetworkService.apiUrl}/register-by-phone?$langCurrCode");
    final response = await http.post(url, body: body, headers: headers);

    var data = json.decode(response.body);
    if (data['success']) {
      Get.off(OtpScreen(
          phoneNumber: phoneNumber.toString(), screen: registrationOTpScreen));
      return data['success'];
    } else {
      showErrorToast(data['message']);
      return false;
    }
  }

  //User Phone Registration OTP
  Future<UserDataModel?> postPhoneRegistrationOTP(
      {String? phoneNumber, var otp}) async {
    UserDataModel? userDataModel;
    var headers = {"apiKey": Config.apiKey};
    var body = {
      'phone': phoneNumber,
      'otp': otp,
    };
    var url = Uri.parse(
        "${NetworkService.apiUrl}/verify-registration-otp?$langCurrCode");
    final response = await http.post(url, body: body, headers: headers);

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      userDataModel = UserDataModel.fromJson(data);
      LocalDataHelper().saveUserToken(userDataModel.data!.token);
      LocalDataHelper().saveUserAllData(userDataModel);

      Get.off(() => DashboardScreen());
      showShortToast(userDataModel.message.toString());
      return userDataModel;
    } else {
      showErrorToast(data['message']);
      return null;
    }
  }

  //User Login
  Future<bool> loginWithEmailPassword(String email, String password) async {
    var headers = {"apiKey": Config.apiKey};
    var body = {
      'email': email,
      'password': password,
    };
    var url = Uri.parse("${NetworkService.apiUrl}/login?$langCurrCode");
    final response = await http.post(url, body: body, headers: headers);

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      UserDataModel userDataModel = UserDataModel.fromJson(data);
      LocalDataHelper().saveUserToken(userDataModel.data!.token);
      LocalDataHelper().saveUserAllData(userDataModel);

      return true;
    } else {
      showErrorToast(data["message"]);
      return false;
    }
  }

  //User Forget Password
  Future postForgetPasswordGetData({String? email}) async {
    var headers = {"apiKey": Config.apiKey};
    var body = {
      'email': email,
    };
    printLog("$email");
    var url = Uri.parse("${NetworkService.apiUrl}/get-verification-link");
    final response = await http.post(url, body: body, headers: headers);
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      ForgetPasswordModel forgetPassword = ForgetPasswordModel.fromJson(data);
      LocalDataHelper().saveForgotPasswordCode(forgetPassword.data!.code.toString());
      return forgetPassword;
    } else {
      showErrorToast(data['message']);
    }
  }

  //Confirm OTP
  Future<bool?> postForgetPasswordConfirmOTP({String? email,String? otp}) async {
    var headers = {"apiKey": Config.apiKey};
    var body = {
      'email': email,
      'otp' :otp
    };
    printLog("$email");
    var url = Uri.parse("${NetworkService.apiUrl}/verify-otp");
    final response = await http.post(url, body: body, headers: headers);
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      return data['success'];
    } else {
      showErrorToast(data['message']);
      return false;
    }
  }

  //User Forget Password Set
  Future<bool?> postForgetPassword(
      { String? code,
        String? email,
        String? password,
        String? confirmPassword,
        String? otp
      }) async {
    var headers = {"apiKey": Config.apiKey};
    var body = {
      'code': code,
      'email': email,
      'otp': otp,
      'password': password,
      'password_confirmation': confirmPassword,
    };
    var url =
        Uri.parse("${NetworkService.apiUrl}/create-password?$langCurrCode");
    final response = await http.post(url, body: body, headers: headers);
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      showShortToast(data['message']);
      return data['success'];
    } else {
      showShortToast(data['message']);
      return false;
    }
  }

  //User SignUp
  Future<bool> signUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      required String confirmPassword}) async {
    var headers = {"apiKey": Config.apiKey};
    var body = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    };
    var url = Uri.parse("${NetworkService.apiUrl}/register?$langCurrCode");
    final response = await http.post(url, body: body, headers: headers);

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      showShortToast(data['message'], bgColor: Colors.green);
      return true;
    } else {
      showErrorToast(data['message']);
      return false;
    }
  }

  //User Coupon Send
  Future applyCouponCode({String? couponCode}) async {
    var headers = {"apiKey": Config.apiKey};
    var body = {
      'coupon_code': couponCode,
      'trx_id': LocalDataHelper().getCartTrxId()
    };
    var url = Uri.parse(
        "${NetworkService.apiUrl}/apply-coupon?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.post(url, body: body, headers: headers);
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      showShortToast(data['message']);
    } else {
      showErrorToast(data['message']);
      return null;
    }
  }

  //User Coupon Delete
  Future postCouponDelete({required int couponId}) async {
    var headers = {"apiKey": Config.apiKey};
    var body = {
      'coupon_id': couponId.toString(),
      'trx_id': LocalDataHelper().getCartTrxId()
    };
    var url = Uri.parse(
        "${NetworkService.apiUrl}/user/delete-coupon?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.post(url, body: body, headers: headers);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      showShortToast(data['success']);
    } else {
      showErrorToast(data['success']);
      return null;
    }
  }

  //Product reply Review
  Future postReviewReply({String? reviewId, String? reply}) async {
    var headers = {"apiKey": Config.apiKey};
    var body = {
      'review_id': reviewId.toString(),
      'reply': reply.toString(),
    };
    var url = Uri.parse(
        "${NetworkService.apiUrl}/user/submit-reply?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.post(url, body: body, headers: headers);

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      showShortToast(data['message']);
    } else {
      showErrorToast(data['message']);
      return null;
    }
  }

  // Review Submit
  Future<bool> postReviewSubmit({
    required String productId,
    required String title,
    required String comment,
    required String rating,
    File? image,
  }) async {
    try {
      var url = Uri.parse(
          "${NetworkService.apiUrl}/user/submit-review?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
      var requestBody = http.MultipartRequest('POST', url);
      requestBody.headers['apiKey'] = Config.apiKey;
      requestBody.fields['product_id'] = productId;
      requestBody.fields['title'] = title;
      requestBody.fields['comment'] = comment;
      requestBody.fields['rating'] = rating;
      if(image!=null){
        var stream = http.ByteStream(image.openRead())..cast();
        var length = await image.length();
        var multipartFile = http.MultipartFile('image', stream, length,
            filename: basename(image.path));
        requestBody.files.add(multipartFile);
      }

      final response = await requestBody.send();
      final result = await http.Response.fromStream(response);
      var data = jsonDecode(result.body);
      if (data['success']) {
        showShortToast(data['message']);
        return data['success'];
      }
      return false;
    } catch (e) {
      throw Exception("$e");
    }
  }

  //Profile Update WithOut Image
  Future<UserDataModel?> postUpdateProfileWithOutImage(
      {required String firstName,
      required String lastName,
      required String phoneNumber,
      required String emailAddress,
      required String? gender,
      required String dob}) async {
    var headers = {"apiKey": Config.apiKey};
    var body = {
      'first_name': firstName.toString(),
      'last_name': lastName.toString(),
      'email': emailAddress.toString(),
      'phone': phoneNumber.toString(),
      'gender': gender.toString(),
      'date_of_birth': dob.toString(),
    };

    printLog(body);
    var url = Uri.parse(
        "${NetworkService.apiUrl}/user/update-profile?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.post(url, body: body, headers: headers);

    var data = json.decode(response.body);
    printLog("----update profile without image: $data");
    printLog(
        "----update profile:user token: ${LocalDataHelper().getUserToken()}");
    if (response.statusCode == 200) {
      UserDataModel userDataModel = UserDataModel.fromJson(data);

      return userDataModel;
    } else {
      return null;
    }
  }

  //Profile Update With Image
  Future<UserDataModel?> postUpdateProfile(
      {required String firstName,
      required String lastName,
      required String phoneNumber,
      required String emailAddress,
      required File image,
      required String gender,
      required String dob}) async {
    try {
      var url = Uri.parse(
          "${NetworkService.apiUrl}/user/update-profile?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
      var requestBody = http.MultipartRequest('POST', url);
      requestBody.headers['apiKey'] = Config.apiKey;
      requestBody.fields['first_name'] = firstName;
      requestBody.fields['last_name'] = lastName;
      requestBody.fields['email'] = emailAddress;
      requestBody.fields['phone'] = phoneNumber;
      requestBody.fields['gender'] = gender.toString();
      requestBody.fields['date_of_birth'] = dob;
      var stream = http.ByteStream(image.openRead())..cast();
      var length = await image.length();
      var multipartFile = http.MultipartFile('image', stream, length,
          filename: basename(image.path));
      requestBody.files.add(multipartFile);

      printLog(requestBody);
      final response = await requestBody.send();
      final result = await http.Response.fromStream(response);
      var data = jsonDecode(result.body);
      printLog("----update profile: $data");

      if (data['success']) {
        UserDataModel userDataModel = UserDataModel.fromJson(data);
        return userDataModel;
      }
      return null;
    } catch (e) {
      throw Exception("$e");
    }
  }

  //Change Password
  Future<bool> postChangePassword(
      {String? currentPass, String? newPass, String? confirmPass}) async {
    var headers = {"apiKey": Config.apiKey};
    var body = {
      'current_password': currentPass,
      'new_password': newPass,
      'confirm_password': confirmPass,
    };
    var url = Uri.parse(
        "${NetworkService.apiUrl}/user/change-password?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.post(url, body: body, headers: headers);

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      showErrorToast(data['message']);
      return false;
    }
  }

  //User Find variant(not use)
  Future<UserDataModel?> postFindVariant(String email, String password) async {
    UserDataModel userDataModel;
    var headers = {"apiKey": Config.apiKey};
    var body = {
      'product_id': "productId",
      'color_id': "colorId",
      'attribute_ids': "attributeIds",
    };
    var url = Uri.parse("${NetworkService.apiUrl}/find_variant");
    final response = await http.post(url, body: body, headers: headers);

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      userDataModel = UserDataModel.fromJson(data);
      showShortToast(data['message']);
      return userDataModel;
    } else {
      showErrorToast(data['message']);
      return null;
    }
  }

  //User AtToCart With TrxId
  Future addToCartWithTrxId(
      {String? productId,
      String? quantity,
      String? variantsIds,
      String? variantsNames,
      String? trxId}) async {
    var headers = {"apiKey": Config.apiKey};
    var body = {
      'product_id': productId.toString(),
      'quantity': quantity.toString(),
      'variants_ids': variantsIds.toString(),
      'variants_name': variantsNames.toString(),
      'trx_id': trxId,
    };
    printLog("addToCart: productId ${productId.toString()}");
    printLog("addToCart: quantity ${quantity.toString()}");
    printLog("addToCart: variants_ids ${variantsIds.toString()}");
    printLog("addToCart: variants_name ${variantsNames.toString()}");
    printLog("addToCart: trx_id $trxId");

    var url = Uri.parse(
        "${NetworkService.apiUrl}/cart-store?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.post(url, body: body, headers: headers);

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      AddToCartModel addToCartModel = AddToCartModel.fromJson(data);
      LocalDataHelper().saveCartTrxId(addToCartModel.data!.trxId.toString());
      showShortToast(data["message"]);
    } else {
      showErrorToast(data['message']);
    }
  }

  //User AtToCart WithOut TrxId
  Future addToCartWithOutTrxId({
    String? productId,
    String? quantity,
    String? variantsIds,
    String? variantsNames,
  }) async {
    var headers = {"apiKey": Config.apiKey};
    var body = {
      'product_id': productId.toString(),
      'quantity': quantity.toString(),
      'variants_ids': variantsIds.toString(),
      'variants_name': variantsNames.toString(),
    };
    var url = Uri.parse(
        "${NetworkService.apiUrl}/cart-store?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.post(url, body: body, headers: headers);

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      AddToCartModel addToCartModel = AddToCartModel.fromJson(data);
      LocalDataHelper().saveCartTrxId(addToCartModel.data!.trxId.toString());
      showShortToast(data["message"]);
    } else {
      showErrorToast(data['message']);
    }
  }

  // UpdateProduct
  Future updateCartProduct({
    required String cartId,
    required int quantity,
  }) async {
    var headers = {"apiKey": Config.apiKey};
    var body = {'quantity': quantity.toString()};
    var url = Uri.parse("${NetworkService.apiUrl}/cart-update/$cartId");
    final response = await http.post(url, body: body, headers: headers);

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      showShortToast(data["message"]);
    } else {
      showErrorToast(data['message']);
    }
  }

  //User Create Address
  Future postCreateAddress({
    required String name,
    required String email,
    required String phoneNo,
    required int countryId,
    required int stateId,
    required int cityId,
    required String postalCode,
    required String address,
  }) async {
    var headers = {"apiKey": Config.apiKey};
    var bodyData = {
      'name': name.toString(),
      'email': email.toString(),
      'phone_no': phoneNo.toString(),
      'country_id': countryId.toString(),
      'state_id': stateId.toString(),
      'city_id': cityId.toString(),
      'postal_code': postalCode.toString(),
      'address': address.toString()
    };
    var url = Uri.parse(
        "${NetworkService.apiUrl}/user/shipping-addresses?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.post(url, body: bodyData, headers: headers);
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      showShortToast(data["message"]);
    } else {
      showErrorToast(data['message']);
    }
  }

  //User Edit Address
  Future updateEditAddress({
    required String name,
    required String email,
    required String phoneNo,
    required int countryId,
    required int stateId,
    required int cityId,
    required String postalCode,
    required String address,
    required int addressId,
  }) async {
    var headers = {"apiKey": Config.apiKey};
    var bodyData = {
      'name': name.toString(),
      'email': email.toString(),
      'phone_no': phoneNo.toString(),
      'country_id': countryId.toString(),
      'state_id': stateId.toString(),
      'city_id': cityId.toString(),
      'postal_code': postalCode.toString(),
      'address': address.toString()
    };
    var url = Uri.parse(
        "${NetworkService.apiUrl}/user/shipping-addresses/$addressId?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.post(url, body: bodyData, headers: headers);
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      showShortToast(data["message"]);
    } else {
      showErrorToast(data['message']);
    }
  }

  //Delete Cart
  Future<bool> deleteCartProduct({String? productId}) async {
    var headers = {"apiKey": Config.apiKey};
    var url = Uri.parse(
        "${NetworkService.apiUrl}/cart-delete/$productId?$langCurrCode");
    final response = await http.delete(url, headers: headers);
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      showShortToast(AppTags.productDeletedFromCart.tr);
      return true;
    } else {
      showErrorToast(data['message']);
      return false;
    }
  }

  //Delete User Address
  Future deleteUserAddress({String? addressId}) async {
    var headers = {"apiKey": Config.apiKey};
    var url = Uri.parse(
        "${NetworkService.apiUrl}/user/shipping-addresses/$addressId?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.delete(url, headers: headers);
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      showShortToast(data["message"]);
    } else {
      showErrorToast(data['message']);
    }
  }

  //Profile Data
  Future<EditViewModel> getEditViewAddress(int addressId) async {
    EditViewModel editViewModel;
    var headers = {"apiKey": Config.apiKey};
    var url = Uri.parse(
        "${NetworkService.apiUrl}/user/shipping-addresses/$addressId/edit?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.get(url, headers: headers);
    var data = json.decode(response.body.toString());
    if (response.statusCode == 200) {
      editViewModel = EditViewModel.fromJson(data);
      return editViewModel;
    } else {
      return EditViewModel.fromJson(data);
    }
  }

  //Cart Item List
  Future<AddToCartListModel> getCartItemList() async {
    AddToCartListModel addToCartListModel;
    var headers = {"apiKey": Config.apiKey};
    Uri url;
    if (LocalDataHelper().getUserToken() == null) {
      url = Uri.parse(
          "${NetworkService.apiUrl}/carts?trx_id=${LocalDataHelper().getCartTrxId()}&$langCurrCode");
    } else {
      printLog("userToken: ${LocalDataHelper().getUserToken()}");
      url = Uri.parse(
          "${NetworkService.apiUrl}/carts?token=${LocalDataHelper().getUserToken()}&trx_id=${LocalDataHelper().getCartTrxId()}&$langCurrCode");
    }
    final response = await http.get(url, headers: headers);
    var data = json.decode(response.body.toString());
    addToCartListModel = AddToCartListModel.fromJson(data);
    return addToCartListModel;
  }

  //Tracking  Order
  Future<TrackingOrderModel?> getTrackingOrder({String? trackId}) async {
    TrackingOrderModel trackingOrderModel;
    var headers = {"apiKey": Config.apiKey};
    var url = Uri.parse(
        "${NetworkService.apiUrl}/track-order?invoice_no=$trackId&token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.get(url, headers: headers);
    var data = json.decode(response.body);
    printLog(data);
    if (data['success']) {
      trackingOrderModel = TrackingOrderModel.fromJson(data);
      return trackingOrderModel;
    } else {
      return TrackingOrderModel.fromJson(data);
    }
  }

  //Order List
  Future<OrderListModel> getOrderList() async {
    var url =
        "${NetworkService.apiUrl}/orders?token=${LocalDataHelper().getUserToken()}&$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return OrderListModel.fromJson(response);
  }

  //Guest Order List
  Future<OrderListModel> getGuestOrderList({String? trxId}) async {
    var url =
        "${NetworkService.apiUrl}/order-by-trx?trx_id=$trxId";
    final response = await _service.fetchJsonData(url);
    return OrderListModel.fromJson(response);
  }

  //Profile Data
  Future<ProfileDataModel?> getProfileData() async {
    String? token = LocalDataHelper().getUserToken();
    if (token == null) {
      return null;
    }
    var url =
        "${NetworkService.apiUrl}/user/profile?token=$token&$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return ProfileDataModel.fromJson(response);
  }

  //Home Container
  Future<HomeDataModel> getHomeScreenData() async {
    String? token = LocalDataHelper().getUserToken();
    var url = "${NetworkService.apiUrl}/home-screen?$langCurrCode&token=$token";
    final response = await _service.fetchJsonData(url);
    return HomeDataModel.fromJson(response);
  }

  //Config Data
  Future<ConfigModel> getConfigData() async {
    var url = "${NetworkService.apiUrl}/configs?$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return ConfigModel.fromJson(response);
  }

  //Flash Sale
  Future<List<flash_sale.Data>> getFlashSaleProduct({required int page}) async {
    var url =
        "${NetworkService.apiUrl}/get-flash-deals-products?page=$page&$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return flash_sale.FlashSaleModel.fromJson(response).data;
  }

  //Best Selling Product
  Future<List<best_sell.Data>> getBestSellingProduct(
      {required int page}) async {
    var url =
        "${NetworkService.apiUrl}/get-best-selling-products?page=$page&$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return best_sell.BestSellingProductsModel.fromJson(response).data;
  }

  //Offer Ending Product
  Future<List<offer_ending.Data>> getOfferEndingProduct(
      {required int page}) async {
    var url =
        "${NetworkService.apiUrl}/get-offer-ending-products?page=$page&$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return offer_ending.OfferEndingProductsModel.fromJson(response).data;
  }

  //All Product
  Future<List<all_product.Data>> getAllProduct({required int page}) async {
    var url = "${NetworkService.apiUrl}/get-products?page=$page&$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return all_product.AllProductModel.fromJson(response).data;
  }

  // //Search Product
  Future<SearchProductModel> getSearchProducts(
      {required String searchKey}) async {
    var url =
        "${NetworkService.apiUrl}/search?key=$searchKey&token=${LocalDataHelper().getUserToken()}&$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return SearchProductModel.fromJson(response);
  }

  //View Product
  Future<List<recent_product.Data>> getRecentViewedProduct(
      {required int page}) async {
    var url =
        "${NetworkService.apiUrl}/viewed-products?page=$page&$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return recent_product.RecentViewedProductModel.fromJson(response).data;
  }

  //Today Deal
  Future<List<today_deal.Data>> getTodayDealProduct({required int page}) async {
    var url =
        "${NetworkService.apiUrl}/get-today-deals-products?page=$page&$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return today_deal.TodayDealModel.fromJson(response).data;
  }

  //Favorite Product
  Future<FavouriteData?> getFavoriteProduct() async {
    String? token = LocalDataHelper().getUserToken();
    if (token == null) return null;
    var url =
        "${NetworkService.apiUrl}/user/favourite-products?token=$token&$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return FavouriteData.fromJson(response);
  }

  //Product By Brand
  Future<List<brand.Data>> getProductByBrand(
      {int? id, required int page}) async {
    var url =
        "${NetworkService.apiUrl}/products-by-brand/$id?page=$page&$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return brand.ProductByBrandModel.fromJson(response).data;
  }

  //Product By Shop
  Future<ProductByShopModel> getProductByShop(int id) async {
    ProductByShopModel productByShopModel;
    var headers = {"apiKey": Config.apiKey};
    var url = Uri.parse(
        "${NetworkService.apiUrl}/products-by-shop/$id?$langCurrCode");
    final response = await http.get(url, headers: headers);
    try {
      var data = json.decode(response.body);
      productByShopModel = ProductByShopModel.fromJson(data);
      return productByShopModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  //Product By Category
  Future<List<product.CategoryProductData>> getProductByCategoryItem(
      {int? id, required int page}) async {
    var url =
        "${NetworkService.apiUrl}/products-by-category/$id?page=$page&$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return product.ProductByCategoryModel.fromJson(response).data;
  }

  //Product By Campaign
  Future<ProductByCampaignModel> getProductByCampaign(int id) async {
    ProductByCampaignModel productByCampaignModel;
    var headers = {"apiKey": Config.apiKey};
    var url = Uri.parse(
        "${NetworkService.apiUrl}/products-by-campaign/$id?$langCurrCode");
    final response = await http.get(url, headers: headers);

    try {
      var data = json.decode(response.body);
      productByCampaignModel = ProductByCampaignModel.fromJson(data);
      return productByCampaignModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  //All Category
  Future<AllCategoryModel?> getAllCategory({int page = 1}) async {
    AllCategoryModel? allCategoryModel;
    var headers = {"apiKey": Config.apiKey};
    var url = Uri.parse(
        "${NetworkService.apiUrl}/category/all?page=$page&$langCurrCode");
    final response = await http.get(url, headers: headers);

    var data = json.decode(response.body);
    if (allCategoryModel != null) {
      if (page == 1) {
        allCategoryModel.data!.clear();
      }
      allCategoryModel.data!.addAll(AllCategoryModel.fromJson(data).data!);

      return allCategoryModel;
    } else {
      allCategoryModel = AllCategoryModel.fromJson(data);
      return allCategoryModel;
    }
  }

  //All Category Content
  Future<AllCategoryProductModel?> getAllCategoryContent({int page = 1}) async {
    var url = "${NetworkService.apiUrl}/category/all?page=$page&$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return AllCategoryProductModel.fromJson(response);
  }

  //All Campaign
  Future<List<campaign.Data>> getAllCampaign({int page = 1}) async {
    var url = "${NetworkService.apiUrl}/get-campaigns?page=$page&$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return campaign.AllCampaignModel.fromJson(response).data!;
  }

  //All Brand
  Future<List<Brand>> getAllBrand({int page = 1}) async {
    var url = "${NetworkService.apiUrl}/all-brand?page=$page&$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return AllBrandModel.fromJson(response).brands;
  }

  //All News
  Future<List<news.Data>> getAllNews({int page = 1}) async {
    var url = "${NetworkService.apiUrl}/all-post/?page=$page&$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return news.AllNewsModel.fromJson(response).data;
  }

  //All Shop
  Future<List<all_shop.Data>> getAllShop({int page = 1}) async {
    String? token = LocalDataHelper().getUserToken();
    var url =
        "${NetworkService.apiUrl}/all-shop?page=$page&$langCurrCode&token=$token";
    final response = await _service.fetchJsonData(url);
    return all_shop.AllShopModel.fromJson(response).data;
  }

  //All Visit Shop
  Future<VisitShopModel> getVisitShop(int shopId) async {
    VisitShopModel? visitShopModel;
    var headers = {"apiKey": Config.apiKey};
    var url = Uri.parse("${NetworkService.apiUrl}/shop/$shopId?$langCurrCode");
    final response = await http.get(url, headers: headers);

    var data = json.decode(response.body.toString());
    try {
      if (visitShopModel != null) {
        visitShopModel = VisitShopModel.fromJson(data);
        // visitShopModel.data!.addAll(VisitShopModel.fromJson(data).data!);
        return visitShopModel;
      } else {
        visitShopModel = VisitShopModel.fromJson(data);
        return visitShopModel;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //All Best Shop
  Future<List<best_shop.Data>> getBestShop({int page = 1}) async {
    String? token = LocalDataHelper().getUserToken();
    var url =
        "${NetworkService.apiUrl}/best-shop?page=$page&$langCurrCode&token=$token";
    final response = await _service.fetchJsonData(url);
    return best_shop.BestShopModel.fromJson(response).data;
  }

  //All Top Shop
  Future<List<top_shop.Data>> getTopShop({int page = 1}) async {
    String? token = LocalDataHelper().getUserToken();
    var url =
        "${NetworkService.apiUrl}/top-shop?page=$page&$langCurrCode&token=$token";
    final response = await _service.fetchJsonData(url);
    return top_shop.TopShopModel.fromJson(response).data;
  }

  //Product Details
  Future<ProductDetailsModel> getProductDetails(int productId) async {
    ProductDetailsModel detailsModel;
    var headers = {"apiKey": Config.apiKey};
    var url = Uri.parse(
        "${NetworkService.apiUrl}/product-details/$productId?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.get(url, headers: headers);
    try {
      var data = json.decode(response.body);
      detailsModel = ProductDetailsModel.fromJson(data);
      return detailsModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  //Shipping Address
  Future<ShippingAddressModel> getShippingAddress() async {
    ShippingAddressModel shippingAddressModel;
    var headers = {"apiKey": Config.apiKey};
    var url = Uri.parse(
        "${NetworkService.apiUrl}/user/shipping-addresses?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.get(url, headers: headers);

    try {
      var data = json.decode(response.body);
      shippingAddressModel = ShippingAddressModel.fromJson(data);
      return shippingAddressModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  //Country List
  Future<CountryListModel> getCountryList() async {
    CountryListModel countryListModel;
    var headers = {"apiKey": Config.apiKey};
    var url = Uri.parse("${NetworkService.apiUrl}/get-countries?$langCurrCode");
    final response = await http.get(url, headers: headers);

    try {
      var data = json.decode(response.body);

      countryListModel = CountryListModel.fromJson(data);
      return countryListModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  //State List
  Future<StateListModel> getStateList({int? countryId}) async {
    StateListModel stateListModel;
    var headers = {"apiKey": Config.apiKey};
    var url = Uri.parse(
        "${NetworkService.apiUrl}/get-states/$countryId?$langCurrCode");
    final response = await http.get(url, headers: headers);
    try {
      var data = json.decode(response.body);
      stateListModel = StateListModel.fromJson(data);
      return stateListModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  //State List
  Future<GetCitisModel> getCityList({int? stateId}) async {
    GetCitisModel getCitisModel;
    var headers = {"apiKey": Config.apiKey};
    var url =
        Uri.parse("${NetworkService.apiUrl}/get-cities/$stateId?$langCurrCode");
    final response = await http.get(url, headers: headers);
    try {
      var data = json.decode(response.body);
      getCitisModel = GetCitisModel.fromJson(data);
      return getCitisModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  //isFavourite
  Future<bool> addOrRemoveFromFavoriteList(var productId) async {
    var headers = {"apiKey": Config.apiKey};
    var url = Uri.parse(
        "${NetworkService.apiUrl}/user/favourite/$productId?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.get(url, headers: headers);
    var data = json.decode(response.body);
    return data["success"];
  }

  //Follow Unfollow
  Future<bool> followOrUnfollowShopList(var shopId) async {
    var headers = {"apiKey": Config.apiKey};
    var url = Uri.parse(
        "${NetworkService.apiUrl}/user/followed-shop/$shopId?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.get(url, headers: headers);
    var data = json.decode(response.body);
    printLog("===${data["success"]}==");
    return data["success"];
  }

  //isLike and Unlike
  Future getLikeAndUnlike({required int reviewId}) async {
    var headers = {"apiKey": Config.apiKey};
    var body = {
      'review_id': reviewId.toString(),
    };
    var url = Uri.parse(
        "${NetworkService.apiUrl}/user/like-unlike-review?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.post(url, body: body, headers: headers);
    if (response.statusCode == 200) {
    } else {
      return null;
    }
  }

  //Campaign Details
  Future<CampaignDetailsModel?> getCampaignDetails(int campaignId) async {
    var url =
        "${NetworkService.apiUrl}/campaign-details/$campaignId?$langCurrCode";
    final response = await _service.fetchJsonData(url);
    return CampaignDetailsModel.fromJson(response);
  }

  //Coupon list
  Future<CouponAppliedList> getAppliedCouponList() async {
    var url =
        "${NetworkService.apiUrl}/applied-coupons?trx_id=${LocalDataHelper().getCartTrxId()}";
    final response = await _service.fetchJsonData(url);
    return CouponAppliedList.fromJson(response);
  }

  //Voucher list
  Future<CouponListModel?> getVoucherList() async {
    CouponListModel couponListModel;
    var headers = {"apiKey": Config.apiKey};
    var url = Uri.parse(
        "${NetworkService.apiUrl}/coupons?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.get(url, headers: headers);
    var data = json.decode(response.body.toString());
    if (response.statusCode == 200) {
      couponListModel = CouponListModel.fromJson(data);
      return couponListModel;
    } else {
      return null;
    }
  }

  //LogOut
  Future logOut() async {
    var headers = {"apiKey": Config.apiKey};
    var url = Uri.parse(
        "${NetworkService.apiUrl}/user/logout?token=${LocalDataHelper().getUserToken()}&$langCurrCode");
    final response = await http.post(url, headers: headers);
    var data = json.decode(response.body.toString());
    if (response.statusCode == 200) {
      showShortToast(data['message']);
    } else {
      showErrorToast(data['message']);
    }
  }

  //Pdf Downloader(not use)
  getPDF() async {
    var headers = {"apiKey": Config.apiKey};
    try {
      final response = await http.get(
          Uri.parse(
              "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"),
          headers: headers);

      if (response.statusCode == 200) {
        showShortToast(response.body);
        return;
      }
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      File file = File('$tempPath/hasan.pdf');
      await file.writeAsBytes(response.bodyBytes);
    } catch (e) {
      throw Exception(e);
    }
  }

  // get all notifications
  Future<AllNotifications?> getAllNotifications(int page) async {
    String? token = LocalDataHelper().getUserToken();
    if (token == null) {
      return null;
    } else {
      try {
        String url =
            "${NetworkService.apiUrl}/user/notifications?page=$page&token=$token&$langCurrCode";
        return _service.fetchJsonData(url).then((response) {
          if (response != null) return AllNotifications.fromJson(response);
        }).catchError(
            (err) => printLog('All notification data fetching error: $err'));
      } catch (e) {
        throw Exception("Data not found");
      }
    }
  }

  // My Wallet
  Future<MyWalletModel?> getMyWallet() async {
    String? token = LocalDataHelper().getUserToken();
    if (token == null) {
      return null;
    } else {
      try {
        String url =
            "${NetworkService.apiUrl}/user/my-wallet?token=$token&$langCurrCode";
        return _service.fetchJsonData(url).then((response) {
          printLog("---------getMyWallet: $response");
          if (response != null) return MyWalletModel.fromJson(response);
        }).catchError(
            (err) => printLog('All my wallet data fetching error: $err'));
      } catch (e) {
        throw Exception("Data not found");
      }
    }
  }

  // My Reward
  Future<MyRewardModel?> getMyReward() async {
    String? token = LocalDataHelper().getUserToken();
    if (token == null) {
      return null;
    } else {
      try {
        String url =
            "${NetworkService.apiUrl}/user/my-reward?token=$token&$langCurrCode";
        return _service.fetchJsonData(url).then((response) {
          printLog("---------getMyReward: $response");
          if (response != null) return MyRewardModel.fromJson(response);
        }).catchError(
            (err) => printLog('All my reward data fetching error: $err'));
      } catch (e) {
        throw Exception("Data not found");
      }
    }
  }

  // Convert Reward
  Future<bool> postConvertReward({required String reward}) async {
    String? token = LocalDataHelper().getUserToken();
    var headers = {"apiKey": Config.apiKey};
    var body = {
      'converted_reward': reward,
    };
    var url = Uri.parse(
        "${NetworkService.apiUrl}/user/convert-reward?token=$token&$langCurrCode");
    final response = await http.post(url, body: body, headers: headers);

    var data = json.decode(response.body);
    if (data['success']) {
      printLog(data['success']);
      showShortToast(data['message']);
      return true;
    } else {
      showErrorToast(data['message']);
      return false;
    }
  }

  // My Download
  Future<MyDownloadModel?> getMyDownload() async {
    String? token = LocalDataHelper().getUserToken();
    if (token == null) {
      return null;
    } else {
      try {
        String url =
            "${NetworkService.apiUrl}/user/digital-product-order-list?token=$token&$langCurrCode";
        return _service.fetchJsonData(url).then((response) {
          printLog("---------getMyDownload: $response");
          if (response != null) return MyDownloadModel.fromJson(response);
        }).catchError(
            (err) => printLog('All my download data fetching error: $err'));
      } catch (e) {
        throw Exception("Data not found");
      }
    }
  }

  Future<bool?> deleteNotification(int id) async {
    String? token = LocalDataHelper().getUserToken();
    if (token == null) {
      return false;
    } else {
      try {
        String url =
            "${NetworkService.apiUrl}/user/delete-notification/$id?token=${LocalDataHelper().getUserToken()}&$langCurrCode";
        return _service.fetchJsonData(url).then((response) {
          if (response != null) {
            if (response["success"]) return true;
          }
          return false;
        }).catchError(
            (err) => printLog('All notification data fetching error: $err'));
      } catch (e) {
        throw Exception("Data not found");
      }
    }
  }

  Future<bool> deleteAllNotification() async {
    String? token = LocalDataHelper().getUserToken();
    if (token == null) {
      return false;
    } else {
      try {
        String url =
            "${NetworkService.apiUrl}/user/delete-all-notifications?token=${LocalDataHelper().getUserToken()}&$langCurrCode";
        return _service.fetchJsonData(url).then((response) {
          if (response != null) {
            if (response["success"]) return true;
          }
          return false;
        }).catchError(
            (err) => printLog('All notification data fetching error: $err'));
      } catch (e) {
        throw Exception("Data not found");
      }
    }
  }

  //Delete Account
  Future<bool> deleteAccount() async {
    String? token = LocalDataHelper().getUserToken();
    if (token == null) {
      return false;
    } else {
      try {
        String url =
            "${NetworkService.apiUrl}/user/delete-account?token=${LocalDataHelper().getUserToken()}&$langCurrCode";
        return _service.fetchJsonData(url).then(
          (response) {
            if (response != null) {
              showShortToast(response["message"]);
              if (response["success"]) return true;
            }
            return false;
          },
        ).catchError((err) => printLog('error: $err'));
      } catch (e) {
        throw Exception("Data not found");
      }
    }
  }
}
