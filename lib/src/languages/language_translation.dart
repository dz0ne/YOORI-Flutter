import 'package:get/get.dart';
import 'english.dart';
import 'arabic.dart';
import 'bangla.dart';


class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS,
    'bn_BD': bnBD,
    'ar_SA': arSA,
  };
}