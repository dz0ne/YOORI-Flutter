// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:yoori_ecommerce/src/utils/constants.dart';
//
// class InternetCheckController extends GetxController {
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription _streamSubscription;
//   RxString deviceConnectionStatus = 'None'.obs;
//   Rx<ConnectivityResult> connectionStatus = ConnectivityResult.none.obs;
//
//   Future<void> getConnectionType() async {
//     connectionStatus.value = await Connectivity().checkConnectivity();
//     try {
//       connectionStatus.value = await (_connectivity.checkConnectivity());
//     } on PlatformException catch (e) {
//       printLog(e);
//     }
//     return _updateState(connectionStatus.value);
//   }
//
//   _updateState(ConnectivityResult result) {
//     switch (result) {
//       case ConnectivityResult.wifi:
//         deviceConnectionStatus.value = 'wifi';
//         //_showNotificationMessageWhenConnected();
//
//         break;
//       case ConnectivityResult.mobile:
//         deviceConnectionStatus.value = 'mobile';
//         _showNotificationMessageWhenConnected();
//
//         break;
//       case ConnectivityResult.none:
//         _showNotificationMessageWhenDisconnected();
//         break;
//       default:
//         Get.snackbar('Network Error', 'Failed to get Network Status');
//         break;
//     }
//     printLog(result);
//   }
//
//   void _showNotificationMessageWhenConnected() {
//
//     Get.snackbar(
//       'Device connection established',
//       'Your device is connected with ${deviceConnectionStatus.value} network',
//       snackPosition: SnackPosition.BOTTOM,
//       duration: const Duration(seconds: 3),
//       icon: Icon(
//         connectionStatus.value == ConnectivityResult.wifi
//             ? Icons.wifi
//             : connectionStatus.value == ConnectivityResult.mobile
//                 ? Icons.network_cell
//                 : connectionStatus.value == ConnectivityResult.ethernet
//                     ? Icons.network_wifi
//                     : Icons.ac_unit_sharp,
//         color: Colors.white,
//       ),
//       forwardAnimationCurve: Curves.decelerate,
//       shouldIconPulse: false,
//     );
//   }
//
//   void _showNotificationMessageWhenDisconnected() {
//
//     Get.snackbar(
//       'Device network connection lost',
//       'Please check your internet connection',
//       snackPosition: SnackPosition.BOTTOM,
//       duration: const Duration(seconds: 5),
//       icon: connectionStatus.value == ConnectivityResult.none
//           ? const Icon(Icons.network_check_rounded)
//           : Container(),
//       isDismissible: false,
//       forwardAnimationCurve: Curves.decelerate,
//       reverseAnimationCurve: Curves.easeInBack,
//     );
//   }
//
//   @override
//   void onInit() async {
//     await getConnectionType();
//     _streamSubscription =
//         _connectivity.onConnectivityChanged.listen(_updateState);
//     super.onInit();
//   }
//
//   @override
//   void onClose() {
//     _streamSubscription.cancel();
//   }
// }
