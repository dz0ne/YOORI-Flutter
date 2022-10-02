import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import '../../../controllers/details_screen_controller.dart';
import '../../../models/product_details_model.dart';
import '../../../utils/responsive.dart';

class DetailsImageViewScreen extends StatelessWidget {
  final ProductDetailsModel? productDetailsModel;
  DetailsImageViewScreen({Key? key,this.productDetailsModel}) : super(key: key);
  final detailsController = Get.put(DetailsPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height-30,
          child: Stack(
           // alignment: Alignment.center,
            children: [
              Card(
                elevation: 0,
                child: PhotoViewGallery.builder(
                  itemCount: productDetailsModel!.data!.images!.length,
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                      basePosition: Alignment.center,
                      imageProvider: NetworkImage(productDetailsModel!.data!.images![index]),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered,
                    );
                  },
                  scrollPhysics: const BouncingScrollPhysics(),
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  onPageChanged: (index){
                    detailsController.itemCounterUpdate(index);
                  },
                ),
              ),
              Positioned(
                left: 20.w,
                  top: 40.h,
                  child: InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30.r),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2.r,
                                blurRadius: 10.r,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 5))
                          ],
                        ),
                        child: Icon(Icons.clear,size: 20.r,color: Colors.white,),
                    ),
                  )
              ),
              Obx(() => Positioned(
                  right: MediaQuery.of(context).size.width/2,
                  top: 40.h,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 16.r,
                          color: AppThemeData.headlineTextColor
                              .withOpacity(0.01),
                          offset: const Offset(0, 1),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 3.h, horizontal: 8.w),
                      child: Text(
                        "${detailsController.productImageNumber.value + 1}/${productDetailsModel!.data!.images!.length}",
                        style: isMobile(context)
                            ? AppThemeData.orderHistoryTextStyle_12.copyWith(color: Colors.white,fontSize: 14.sp,fontFamily: "Poppins Medium")
                            : AppThemeData.orderHistoryTextStyle_9Tab.copyWith(color: Colors.white,fontSize: 11.sp,fontFamily: "Poppins Medium"),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}