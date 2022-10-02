import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/controllers/my_reward_controller.dart';
import 'package:yoori_ecommerce/src/models/user_data_model.dart';
import '../../utils/app_tags.dart';
import '../../utils/app_theme_data.dart';
import '../../utils/responsive.dart';
import '../../widgets/loader/loader_widget.dart';

class MyRewardScreen extends StatelessWidget {
  final UserDataModel userDataModel;
  final String? conversionRate;
  MyRewardScreen({Key? key,required this.userDataModel,this.conversionRate}) : super(key: key);


  final MyRewardController myRewardController = Get.put(MyRewardController());


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:isMobile(context)? AppBar(
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
      ),
      body: Obx(()=> myRewardController.myRewardModel.value.data!=null? Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: ListView(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height:isMobile(context)? 220.h:260.h,
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0xffF8F8F8),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(
                        vertical: 8.0.h, horizontal: 10.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //SizedBox(height: 5,),
                        Container(
                          width: 74.w,
                          height: 74.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0,
                                color: Theme.of(context)
                                    .scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2.r,
                                  blurRadius: 10.r,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 5))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                userDataModel.data!.image!.toString(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "${userDataModel.data!.firstName!.toString()} ${userDataModel.data!.lastName!.toString()}",
                          style: isMobile(context)? AppThemeData.headerTextStyle_16:AppThemeData.headerTextStyle_14,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: -15,
                    child: SizedBox(
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            //height:isMobile(context)? 102.h:120.h,
                            width: 132.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2.r,
                                    blurRadius: 10.r,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 5))
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 10.h),
                                Text(AppTags.totalRewards.tr,style: isMobile(context)? AppThemeData.profileTextStyle_13:AppThemeData.profileTextStyle_10Tab,),
                                SizedBox(height: 5.h),
                                Text(myRewardController.myRewardModel.value.data!.reward!.rewardSum.toString(),
                                    style: isMobile(context)? AppThemeData.balanceTextStyle_16:AppThemeData.buttonDltTextStyle_12),
                                SizedBox(height: 6.h),
                                InkWell(
                                  onTap: (){
                                    convertRewardWallet(context);
                                  },
                                  child: Container(
                                    height: 28.h,
                                    width: 80.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff56A8C7)
                                            .withOpacity(0.16),
                                        borderRadius:
                                        BorderRadius.circular(5)),
                                    child: Text(
                                      AppTags.convert.tr,
                                      style: isMobile(context)? AppThemeData.paymentTypeTextStyle_13:AppThemeData.addAddressTextStyle_10Tab,overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 6.h),
                              ],
                            ),

                          ) ,
                          Container(
                            height: isMobile(context)? 102.h:120.h,
                            width: 132.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2.r,
                                    blurRadius: 10.r,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 5))
                              ],),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 10.h),
                                Text(AppTags.lastWallet.tr,style: isMobile(context)? AppThemeData.profileTextStyle_13:AppThemeData.profileTextStyle_10Tab,),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myRewardController.myRewardModel.value.data!.reward!.lastConversion.toString(),style: AppThemeData.paymentTypeTextStyle_12,textAlign: TextAlign.center,),
                                ),
                                //const SizedBox(height: 10)
                              ],
                            ),

                          )
                        ],
                      ),
                    )
                )
              ],

            ),
            SizedBox(height: 25.h),
            ListView.builder(
                shrinkWrap: true,
                itemCount: myRewardController.myRewardModel.value.data!.rewardDetails!.length,
                physics:  const NeverScrollableScrollPhysics(),
                itemBuilder: (_,index){
                  return  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 7.5.h),
                    child: Container(
                      //height: 100,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2.r,
                              blurRadius: 10.r,
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 5))
                        ],

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: Text(myRewardController.myRewardModel.value.data!.rewardDetails![index].productName.toString(),style: AppThemeData.walletTextStyle_12)),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${AppTags.quantity.tr}: ${myRewardController.myRewardModel.value.data!.rewardDetails![index].productQty}",style: AppThemeData.walletTextStyle_12,),
                                Text("${AppTags.totalRewards.tr}: ${myRewardController.myRewardModel.value.data!.rewardDetails![index].reward}",style: AppThemeData.buttonDltTextStyle_12),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          ],
        ),
      ): const LoaderWidget()),
    );
  }
  convertRewardWallet(context) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.NO_HEADER,
      btnOkColor: const Color(0xFF333333),
      body: Obx(() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(3.r),
                    child: Icon(
                      Icons.clear,
                      size: 18.r,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              AppTags.rewardPoint.tr,
              style: AppThemeData.priceTextStyle_14,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              height: isMobile(context)? 42.h:45.h,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xffF4F4F4)),
                borderRadius:  BorderRadius.all(Radius.circular(5.r)),
              ),
              child: TextField(
                controller: myRewardController.convertRewardController,
                maxLines: 1,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppTags.enterYourAmount.tr,
                  hintStyle: AppThemeData.hintTextStyle_13,
                  contentPadding: EdgeInsets.only(
                    left: 8.w,
                    right: 8.w,
                    bottom: 8.h,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h,),
            Text("${AppTags.availablePointsToConvert.tr}: ${myRewardController.myRewardModel.value.data!.reward!.rewardSum.toString()}",style: AppThemeData.profileTextStyle_13,),
            SizedBox(height: 10.h,),
            Text("${conversionRate!} ${AppTags.rewardPoint.tr} = \$1.0",style: AppThemeData.profileTextStyle_13,),
            SizedBox(height: 10.h,),
            myRewardController.convertedReward.value.isNotEmpty?Text("${AppTags.totalAmountYouWillGet.tr}: ${double.parse(myRewardController.convertedReward.value)/double.parse(conversionRate!)}",style: AppThemeData.profileTextStyle_13,)
                :Text("${AppTags.totalAmountYouWillGet.tr}: \$0.0",style: AppThemeData.profileTextStyle_13,),
            SizedBox(height: 10.h,),
          ],
        ),
      ),
      ),

      btnOkText: AppTags.convertReward.tr,
      buttonsTextStyle: TextStyle(fontSize: 13.sp),

      buttonsBorderRadius: BorderRadius.circular(5),
      btnOkOnPress: () {
        myRewardController.postConvertReward(myRewardController.convertedReward.value);
      },
    ).show();
  }
}
