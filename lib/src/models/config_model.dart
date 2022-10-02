class ConfigModel {
  bool? success;
  String? message;
  Data? data;

  ConfigModel({this.success, this.message, this.data});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  AppConfig? appConfig;
  AndroidVersion? androidVersion;
  IosVersion? iosVersion;
  List<Addons>? addons;
  List<Languages>? languages;
  List<Currencies>? currencies;
  List<Pages>? pages;
  CurrencyConfig? currencyConfig;

  Data(
      {this.appConfig,
      this.androidVersion,
      this.iosVersion,
      this.addons,
      this.languages,
      this.currencies});

  Data.fromJson(Map<String, dynamic> json) {
    appConfig = json['app_config'] != null
        ? AppConfig.fromJson(json['app_config'])
        : null;
    androidVersion = json['android_version'] != null
        ? AndroidVersion.fromJson(json['android_version'])
        : null;
    iosVersion = json['ios_version'] != null
        ? IosVersion.fromJson(json['ios_version'])
        : null;

    if (json['addons'] != null) {
      addons = <Addons>[];
      json['addons'].forEach((v) {
        addons!.add(Addons.fromJson(v));
      });
    }
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(Languages.fromJson(v));
      });
    }
    if (json['currencies'] != null) {
      currencies = <Currencies>[];
      json['currencies'].forEach((v) {
        currencies!.add(Currencies.fromJson(v));
      });
    }
    if (json['pages'] != null) {
      pages = <Pages>[];
      json['pages'].forEach((v) {
        pages!.add(Pages.fromJson(v));
      });
    }
    currencyConfig = json['currency_config'] != null
        ? CurrencyConfig.fromJson(json['currency_config'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (appConfig != null) {
      data['app_config'] = appConfig!.toJson();
    }
    if (androidVersion != null) {
      data['android_version'] = androidVersion!.toJson();
    }
    if (iosVersion != null) {
      data['ios_version'] = iosVersion!.toJson();
    }

    if (addons != null) {
      data['addons'] = addons!.map((v) => v.toJson()).toList();
    }
    if (languages != null) {
      data['languages'] = languages!.map((v) => v.toJson()).toList();
    }
    if (currencies != null) {
      data['currencies'] = currencies!.map((v) => v.toJson()).toList();
    }
    if (pages != null) {
      data['pages'] = pages!.map((v) => v.toJson()).toList();
    }
    if (currencyConfig != null) {
      data['currency_config'] = currencyConfig!.toJson();
    }
    return data;
  }
}

class Pages {
  int? id;
  String? type;
  String? title;
  String? link;

  Pages({this.id, this.type, this.title, this.link});

  Pages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['title'] = title;
    data['link'] = link;
    return data;
  }
}

class CurrencyConfig {
  String? currencySymbolFormat;
  String? decimalSeparator;
  String? noOfDecimals;

  CurrencyConfig(
      {this.currencySymbolFormat, this.decimalSeparator, this.noOfDecimals});

  CurrencyConfig.fromJson(Map<String, dynamic> json) {
    currencySymbolFormat = json['currency_symbol_format'];
    decimalSeparator = json['decimal_separator'];
    noOfDecimals = json['no_of_decimals'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency_symbol_format'] = currencySymbolFormat;
    data['decimal_separator'] = decimalSeparator;
    data['no_of_decimals'] = noOfDecimals;
    return data;
  }
}

class AppConfig {
  bool? loginMandatory;
  bool? introSkippable;
  String? privacyPolicyUrl;
  String? termsConditionUrl;
  String? supportUrl;
  bool? sellerSystem;
  bool? colorSystem;
  bool? pickupPointSystem;
  bool? walletSystem;
  bool? couponSystem;

  AppConfig(
      {this.loginMandatory,
      this.introSkippable,
      this.privacyPolicyUrl,
      this.termsConditionUrl,
      this.supportUrl,
      this.sellerSystem,
      this.colorSystem,
      this.pickupPointSystem,
      this.walletSystem,
      this.couponSystem});

  AppConfig.fromJson(Map<String, dynamic> json) {
    loginMandatory = json['login_mandatory'];
    introSkippable = json['intro_skippable'];
    privacyPolicyUrl = json['privacy_policy_url'];
    termsConditionUrl = json['terms_condition_url'];
    supportUrl = json['support_url'];
    sellerSystem = json['seller_system'];
    colorSystem = json['color_system'];
    pickupPointSystem = json['pickup_point_system'];
    walletSystem = json['wallet_system'];
    couponSystem = json['coupon_system'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login_mandatory'] = loginMandatory;
    data['intro_skippable'] = introSkippable;
    data['privacy_policy_url'] = privacyPolicyUrl;
    data['terms_condition_url'] = termsConditionUrl;
    data['support_url'] = supportUrl;
    data['seller_system'] = sellerSystem;
    data['color_system'] = colorSystem;
    data['pickup_point_system'] = pickupPointSystem;
    data['wallet_system'] = walletSystem;
    data['coupon_system'] = couponSystem;
    return data;
  }
}

class AndroidVersion {
  String? apkVersion;
  String? apkCode;
  String? apkFileUrl;
  String? whatsNew;
  bool? isSkippable;

  AndroidVersion(
      {this.apkVersion,
      this.apkCode,
      this.apkFileUrl,
      this.whatsNew,
      this.isSkippable});

  AndroidVersion.fromJson(Map<String, dynamic> json) {
    apkVersion = json['apk_version'];
    apkCode = json['apk_code'];
    apkFileUrl = json['apk_file_url'];
    whatsNew = json['whats_new'];
    isSkippable = json['update_skippable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['apk_version'] = apkVersion;
    data['apk_code'] = apkCode;
    data['apk_file_url'] = apkFileUrl;
    data['whats_new'] = whatsNew;
    data['update_skippable'] = isSkippable;
    return data;
  }
}

class IosVersion {
  String? ipaVersion;
  String? ipaCode;
  String? ipaFileUrl;
  String? whatsNew;
  bool? isSkippable;

  IosVersion(
      {this.ipaVersion,
      this.ipaCode,
      this.ipaFileUrl,
      this.whatsNew,
      this.isSkippable});

  IosVersion.fromJson(Map<String, dynamic> json) {
    ipaVersion = json['ipa_version'];
    ipaCode = json['ipa_code'];
    ipaFileUrl = json['ipa_file_url'];
    whatsNew = json['whats_new'];
    isSkippable = json['update_skippable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ipa_version'] = ipaVersion;
    data['ipa_code'] = ipaCode;
    data['ipa_file_url'] = ipaFileUrl;
    data['whats_new'] = whatsNew;
    data['update_skippable'] = isSkippable;
    return data;
  }
}

class Addons {
  int? id;
  String? name;
  String? addonIdentifier;
  String? purchaseCode;
  String? version;
  bool status = false;
  String? image;
  AddonData? addonData;

  Addons(
      {this.id,
      this.name,
      this.addonIdentifier,
      this.purchaseCode,
      this.version,
      this.status = false,
      this.image,
      this.addonData});

  Addons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    addonIdentifier = json['addon_identifier'];
    purchaseCode = json['purchase_code'];
    version = json['version'];
    status = json['status'];
    image = json['image'];
    addonData = json['data'] != null ? AddonData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['addon_identifier'] = addonIdentifier;
    data['purchase_code'] = purchaseCode;
    data['version'] = version;
    data['status'] = status;
    data['image'] = image;
    if (addonData != null) {
      data['data'] = addonData?.toJson();
    }
    return data;
  }
}

class Languages {
  int? id;
  String? name;
  String? code;
  String? textDirection;
  String? flagImage;

  Languages(
      {this.id, this.name, this.code, this.textDirection, this.flagImage});

  Languages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    textDirection = json['text_direction'];
    flagImage = json['flag_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['text_direction'] = textDirection;
    data['flag_image'] = flagImage;
    return data;
  }
}


class AddonData {
  String? title;
  String? subTitle;
  String? sticker;
  bool? refundWithShoppingCost;
  int? refundRequestTime;
  String? conversionRate;

  AddonData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['sub_title'];
    sticker = json['sticker'];
    refundWithShoppingCost = json['refund_with_shipping_cost'];
    refundRequestTime = json['refund_request_time'];
    conversionRate = json['conversion_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['sub_title'] = subTitle;
    data['sticker'] = sticker;
    data['refund_with_shipping_cost'] = refundWithShoppingCost;
    data['refund_request_time'] = refundRequestTime;
    data['conversion_rate'] = conversionRate;
    return data;
  }
}

class Currencies {
  int? id;
  String? name;
  String? symbol;
  String? code;
  dynamic exchangeRate;

  Currencies({this.id, this.name, this.symbol, this.code, this.exchangeRate});

  Currencies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    code = json['code'];
    exchangeRate = json['exchange_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['symbol'] = symbol;
    data['code'] = code;
    data['exchange_rate'] = exchangeRate;
    return data;
  }
}
