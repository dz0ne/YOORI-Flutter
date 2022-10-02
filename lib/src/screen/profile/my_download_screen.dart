import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/currency_converter_controller.dart';
import '../../controllers/my_download_controller.dart';
import '../../utils/app_tags.dart';
import '../../utils/app_theme_data.dart';
import '../../utils/responsive.dart';
import '../../widgets/loader/loader_widget.dart';
class MyDownload extends StatelessWidget {
  MyDownload({Key? key}) : super(key: key);
  final MyDownloadController myDownloadController=Get.put(MyDownloadController());
  final currencyConverterController = Get.find<CurrencyConverterController>();

  @override
  Widget build(BuildContext context) {
    Size size =  MediaQuery.of(context).size;
    return Scaffold(
      appBar: isMobile(context)? AppBar(
        backgroundColor: const Color(0xffF8F8F8),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 22.r,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(AppTags.myDownload.tr,style: AppThemeData.headerTextStyle_16,),
      ):AppBar(
        backgroundColor: const Color(0xffF8F8F8),
        elevation: 0,
        toolbarHeight: 60.h,
        leadingWidth: 40.w,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 22.r,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(AppTags.myDownload.tr,style: AppThemeData.headerTextStyleTab,),
      ),
      body: Obx(()=> myDownloadController.myDownloadModel.value.downloadUrl!=null? SizedBox(
          height: size.height,
          width: size.width,
          child: ListView.builder(
              itemCount: myDownloadController.myDownloadModel.value.downloadUrl!.length,
              itemBuilder: (_,index){
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 7.5.h),
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2.r,
                            blurRadius: 10.r,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 5))
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Text(myDownloadController.myDownloadModel.value.downloadUrl![index].productName.toString(),
                                  style: isMobile(context)? AppThemeData.walletTextStyle_12:AppThemeData.walletTextStyle_10Tab)),

                              Text("${currencyConverterController.convertCurrency(myDownloadController.myDownloadModel.value.downloadUrl![index].total!.toStringAsFixed(2))}",
                                  style: isMobile(context)? AppThemeData.balanceTextStyle_16:AppThemeData.buttonDltTextStyle_12),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(myDownloadController.myDownloadModel.value.downloadUrl![index].date.toString(),style: isMobile(context)? AppThemeData.walletTextStyle_12:AppThemeData.walletTextStyle_10Tab),
                              InkWell(
                                onTap: ()async {
                                  Uri url = Uri.parse(
                                      myDownloadController.myDownloadModel.value.downloadUrl![index].url.toString());
                                  if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                  } else {
                                  throw 'could not launch $url';
                                  }
                                },
                                child: Container(
                                    height: 28.h,
                                    width: 90.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffD16D86).withOpacity(0.10),
                                        borderRadius: BorderRadius.circular(5.r)
                                    ),
                                    child: Text(AppTags.download.tr,style: isMobile(context)? AppThemeData.buttonDltTextStyle_13:AppThemeData.buttonDltTextStyle_10Tab),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
          )
      ): const LoaderWidget()
      ),
    );
  }
}
