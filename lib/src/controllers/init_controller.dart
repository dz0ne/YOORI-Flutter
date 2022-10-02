import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../config.dart';

class InitController extends GetxController {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  void configOneSignal() {
    OneSignal.shared.setAppId(Config.oneSignalAppId);
    //show notification content
    OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);
  }

  @override
  void onInit() async {
    configOneSignal();
    super.onInit();
  }
}
