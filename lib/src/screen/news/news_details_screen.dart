import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/controllers/news_controller.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';

import '../../../config.dart';
import '../../utils/responsive.dart';

class NewsScreen extends GetView<NewsController> {
  NewsScreen({Key? key}) : super(key: key);

  final String title = Get.parameters['title']!;
  final String url = Get.parameters['url']!;
  final String image = Get.parameters['image']!;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
      builder: (newsController) {
        return Scaffold(
          extendBody: true,
          appBar: isMobile(context)? AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              }, // null disables the button
            ),
          ): AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 60.h,
          leadingWidth: 40.w,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25.r,
            ),

            onPressed: () {
              Get.back();
            }, // null disables the button
          ),

        ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(10.r),
              child: Column(
                children: [

                  SizedBox(
                    height: 180.h,
                      width: MediaQuery.of(context).size.width-30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(image,fit: BoxFit.fill,),
                      ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    title,
                    style: isMobile(context)? AppThemeData.buttonTextStyle_14Reg:AppThemeData.buttonTextStyleTab,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: Stack(
                      children: [
                        InAppWebView(
                          key: newsController.webViewKey,
                          // contextMenu: contextMenu,
                          initialUrlRequest: URLRequest(
                            headers: {"apiKey": Config.apiKey},
                            url: Uri.parse(url),
                          ),
                          // initialFile: "assets/index.html",
                          initialUserScripts:
                              UnmodifiableListView<UserScript>([]),
                          initialOptions: newsController.options,
                          pullToRefreshController:
                              newsController.pullToRefreshController,
                          onWebViewCreated: (controller) {
                            newsController.webViewController = controller;
                          },
                          onLoadStart: (controller, url) {},
                          androidOnPermissionRequest:
                              (controller, origin, resources) async {
                            return PermissionRequestResponse(
                                resources: resources,
                                action: PermissionRequestResponseAction.GRANT);
                          },
                          shouldOverrideUrlLoading:
                              (controller, navigationAction) async {
                                return null;
                              },
                          onLoadStop: (controller, url) async {
                            newsController.isLoadingUpdate(false);
                            newsController.pullToRefreshController
                                .endRefreshing();
                          },
                          onLoadError: (controller, url, code, message) {
                            newsController.pullToRefreshController
                                .endRefreshing();
                          },
                          onProgressChanged: (controller, progress) {
                            newsController.progressUpdate(progress);
                            if (progress == 100) {
                              newsController.pullToRefreshController
                                  .endRefreshing();
                            }
                          },
                          onUpdateVisitedHistory:
                              (controller, url, androidIsReload) {},
                          onConsoleMessage: (controller, consoleMessage) {},
                        ),
                        newsController.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
