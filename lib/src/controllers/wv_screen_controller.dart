import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class WVController extends GetxController {
  var isLoading = true.obs;
  final GlobalKey webViewKey1 = GlobalKey();

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
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    contextMenu = ContextMenu(
      menuItems: [
        ContextMenuItem(
          androidId: 1,
          iosId: "1",
          title: "Special",
          action: () async {
            await webViewController?.clearFocus();
          },
        )
      ],
      options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
      onCreateContextMenu: (hitTestResult) async {},
      onHideContextMenu: () {},
      onContextMenuActionItemClicked: (contextMenuItemClicked) async {},
    );

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

  Future<bool> popScope() async {
    if (await webViewController!.canGoBack()) {
      webViewController?.goBack();
      return false;
    } else {
      return false;
    }
  }

  progressUpdate(value) {
    progress = value;
    update();
  }

  isLoadingUpdate(value) {
    isLoading.value = value;
  }
}
