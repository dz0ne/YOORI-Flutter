import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yoori_ecommerce/src/data/local_data_helper.dart';

class PaymentController extends GetxController {
  bool isLoading = true;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  late PullToRefreshController pullToRefreshController;
  late ContextMenu contextMenu;
  String url = "https://www.linkedin.com/";
  double progress = 0;
  final urlController = TextEditingController();
  bool showButton = false;
  String langCode = "en";
  String currencyCode = "USD";

  @override
  void onInit() {
    super.onInit();
    langCode = LocalDataHelper().getLangCode() ?? "en";
    currencyCode = LocalDataHelper().getCurrCode() ?? "USD";
    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {
                await webViewController?.clearFocus();
              })
        ],
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {},
        onHideContextMenu: () {},
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {});

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.purple,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  progressUpdate(value) {
    progress = value;
    update();
  }

  isLoadingUpdate(value) {
    isLoading = value;
    update();
  }

  showButtonUpdate(value) {
    showButton = value;
    update();
  }
}
