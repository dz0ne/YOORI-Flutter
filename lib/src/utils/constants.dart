import 'package:flutter/foundation.dart';

const printLogTag = "[YOORI-Flutter]";
//make print log enable to false to stop print printLog
const printLogEnable = true;

printLog(dynamic data) {
  if (printLogEnable) {
    if (kDebugMode) {
      print("$printLogTag${data.toString()}");
    }
  }
}
