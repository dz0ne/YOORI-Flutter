import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsHelper {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
 // static final FirebaseAnalyticsObserver _observer = FirebaseAnalyticsObserver(analytics: _analytics);

  setAnalyticsData(
      {required String screenName,
      String eventTitle = "",
      Map<String, dynamic>? additionalData}) async {
    await _analytics.setAnalyticsCollectionEnabled(true);
    _analytics.logScreenView(screenName: screenName);
    if (additionalData != null) {
      _analytics.logEvent(name: eventTitle, parameters: additionalData);
    }
  }
}
