import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:yoori_ecommerce/src/models/config_model.dart';
import 'package:yoori_ecommerce/src/data/local_data_helper.dart';

class CurrencyConverterController extends GetxController {
  late String appCurrencyCode;
  late String appCurrencySymbol;
  late String currencySymbolFormat;
  late String decimalSeparator;
  late String numberOfDecimals;
  late int currencyIndex;

  late NumberFormat formatter;
  @override
  void onInit() {
    fetchCurrencyData();
    super.onInit();
  }

  void fetchCurrencyData() {
    ConfigModel data = LocalDataHelper().getConfigData();
    appCurrencyCode = LocalDataHelper().getCurrCode() ?? "USD";
    currencyIndex = data.data!.currencies!
        .indexWhere(((currIndex) => currIndex.code == appCurrencyCode));
    appCurrencySymbol = data.data!.currencies![currencyIndex].symbol!;
    currencySymbolFormat = data.data!.currencyConfig!.currencySymbolFormat!;
    decimalSeparator = data.data!.currencyConfig!.decimalSeparator!;
    numberOfDecimals = data.data!.currencyConfig!.noOfDecimals!;
  }

  convertCurrency(price) {
    ConfigModel data = LocalDataHelper().getConfigData();
    if (appCurrencyCode == "USD") {
      MoneyFormatter formatter = MoneyFormatter(
        amount: double.parse(price),
        settings: MoneyFormatterSettings(
          symbol: appCurrencySymbol,
          thousandSeparator: decimalSeparator == "." ? ',' : ".",
          decimalSeparator: decimalSeparator,
          symbolAndNumberSeparator: symbolNumberSeparator(),
          fractionDigits: int.parse(numberOfDecimals),
        ),
      );
      if (symblePosition() == "right") {
        return formatter.output.symbolOnRight;
      } else {
        return formatter.output.symbolOnLeft;
      }
    } else {
      final convertedPrice = double.parse(price) *
          data.data!.currencies![currencyIndex].exchangeRate!;
      MoneyFormatter formatter = MoneyFormatter(
        amount: convertedPrice,
        settings: MoneyFormatterSettings(
          symbol: appCurrencySymbol,
          thousandSeparator: decimalSeparator == "." ? ',' : ".",
          decimalSeparator: decimalSeparator,
          symbolAndNumberSeparator: symbolNumberSeparator(),
          fractionDigits: int.parse(numberOfDecimals),
        ),
      );
      if (symblePosition() == "right") {
        return formatter.output.symbolOnRight;
      } else {
        return formatter.output.symbolOnLeft;
      }
    }
  }

  symbolNumberSeparator() {
    ConfigModel data = LocalDataHelper().getConfigData();
    if (data.data!.currencyConfig!.currencySymbolFormat! == "amount_symbol" ||
        data.data!.currencyConfig!.currencySymbolFormat! == "symbol_amount") {
      return "";
    } else {
      return " ";
    }
  }

  symblePosition() {
    ConfigModel data = LocalDataHelper().getConfigData();
    if (data.data!.currencyConfig!.currencySymbolFormat! == "amount_symbol" ||
        data.data!.currencyConfig!.currencySymbolFormat! == "amount__symbol") {
      return "right";
    } else {
      return "left";
    }
  }
}
