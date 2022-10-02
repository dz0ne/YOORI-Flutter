import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/controllers/wv_screen_controller.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';

import '../../../widgets/loader/loader_widget.dart';


class WVScreen extends StatelessWidget {
  WVScreen({
    Key? key,
  }) : super(key: key);
  final wvController = Get.put(WVController());

  final String url = Get.parameters['url']!;
  final String title = Get.parameters['title']!;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          title: Text(
          title,
            style: AppThemeData.headerTextStyle_16,
          ),
        ),
        body: WillPopScope(
          onWillPop: () {
            return wvController.popScope();
          },
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    InAppWebView(
                      key: wvController.webViewKey1,
                      initialUrlRequest: URLRequest(
                        url: Uri.parse(
                          url,
                        ),
                      ),
                      initialUserScripts: UnmodifiableListView<UserScript>([]),
                      initialOptions: wvController.options,
                      pullToRefreshController:
                          wvController.pullToRefreshController,
                      onWebViewCreated: (controller) {
                        wvController.webViewController = controller;
                      },
                      onLoadStart: (controller, url) {
                        wvController.isLoadingUpdate(true);
                      },
                      androidOnPermissionRequest:
                          (controller, origin, resources) async {
                        return PermissionRequestResponse(
                            resources: resources,
                            action: PermissionRequestResponseAction.GRANT);
                      },
                      shouldOverrideUrlLoading:
                          (controller, navigationAction) async {
                        return NavigationActionPolicy.ALLOW;
                      },
                      onLoadStop: (controller, url) async {
                        wvController.isLoadingUpdate(false);
                        wvController.webViewController!
                            .evaluateJavascript(
                                source: "javascript:(function() { "
                                    "var head = document.getElementsByTagName('header')[0];"
                                    "head.parentNode.removeChild(head);"
                                    "})()")
                            .then((value) =>
                                debugPrint('Page finished loading Javascript'))
                            .catchError((onError) => debugPrint('$onError'));

                        wvController.webViewController!
                            .evaluateJavascript(
                                source: "javascript:(function() { "
                                    "var footer = document.getElementsByTagName('footer')[0];"
                                    "footer.parentNode.removeChild(footer);"
                                    "})()")
                            .then((value) =>
                                debugPrint('Page finished loading Javascript'))
                            .catchError((onError) => debugPrint('$onError'));
                        wvController.isLoadingUpdate(false);
                        wvController.pullToRefreshController.endRefreshing();
                      },
                      onLoadError: (controller, url, code, message) {
                        wvController.pullToRefreshController.endRefreshing();
                      },
                      onProgressChanged: (controller, progress) {
                        wvController.progressUpdate(progress);
                        if (progress == 100) {
                          wvController.pullToRefreshController.endRefreshing();
                        }
                      },
                      onUpdateVisitedHistory:
                          (controller, url, androidIsReload) {},
                      onConsoleMessage: (controller, consoleMessage) {},
                      gestureRecognizers: {}..add(
                          Factory<VerticalDragGestureRecognizer>(
                            () => VerticalDragGestureRecognizer(),
                          ),
                        ),
                    ),
                    wvController.isLoading.value
                        ? const Center(child: LoaderWidget())
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
