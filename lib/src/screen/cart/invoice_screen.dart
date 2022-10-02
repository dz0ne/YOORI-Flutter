import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yoori_ecommerce/src/controllers/currency_converter_controller.dart';
import 'package:yoori_ecommerce/src/controllers/invoice_screen_controller.dart';
import 'package:yoori_ecommerce/src/servers/network_service.dart';
import 'package:yoori_ecommerce/src/data/local_data_helper.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';

import '../../utils/app_tags.dart';
import '../../utils/responsive.dart';
import '../../widgets/loader/shimmer_invoice.dart';

class InvoiceScreen extends StatelessWidget {
  InvoiceScreen({Key? key}) : super(key: key);
  final trackingId = Get.parameters['trackingId'];

  final currencyConverterController = Get.find<CurrencyConverterController>();
  final InvoiceScreenController invoiceScreenController = Get.put(InvoiceScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:isMobile(context)? AppBar(
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
          trackingId.toString(),
          style: AppThemeData.headerTextStyle_16,
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
        centerTitle: true,
        title: Text(trackingId.toString(),
          style: AppThemeData.headerTextStyle_14,
        ),
      ),
      body: Obx(()=> invoiceScreenController.isLoading.value
          ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: 250.h,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: const Color(0xFFEEEEEE),
                    ),
                    child: DataTable(
                      sortColumnIndex: 1,
                      sortAscending: true,
                      columnSpacing: 8,
                      dataRowHeight: 70,
                      columns: [
                        DataColumn(
                          label: Text(
                            '#',
                            style: TextStyle(
                              fontSize: isMobile(context)? 14.sp:11.sp,
                              fontFamily: "Poppins Medium",
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            AppTags.products.tr,
                            style: TextStyle(
                              fontSize: isMobile(context)? 14.sp:11.sp,
                              fontFamily: "Poppins Medium",
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            AppTags.qty.tr,
                            style:  TextStyle(
                              fontSize: isMobile(context)? 14.sp:11.sp,
                              fontFamily: "Poppins Medium",
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            AppTags.total.tr,
                            style:  TextStyle(
                              fontSize: isMobile(context)? 14.sp:11.sp,
                              fontFamily: "Poppins Medium",
                            ),
                          ),
                        ),
                      ],
                      rows: invoiceScreenController.trackingOrderModel!.data!.order!.orderDetails!
                          .map(
                            (invoice) => DataRow(
                          cells: [
                            DataCell(
                              Text(
                                invoice.id.toString().padLeft(2, "0"),
                                style:  TextStyle(
                                  fontSize: isMobile(context)? 13.sp:10.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 180.w,
                                height: 37.h,
                                child: Text(
                                  invoice.productName!.toString(),
                                  style: TextStyle(
                                    fontSize: isMobile(context)? 13.sp:10.sp,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                invoice.quantity
                                    .toString()
                                    .padLeft(2, "0"),
                                style: TextStyle(
                                  fontSize: isMobile(context)? 13.sp:10.sp,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            DataCell(
                              Text(
                                currencyConverterController
                                    .convertCurrency(invoice
                                    .formattedTotalPayable!
                                    .toString()),
                                style:  TextStyle(
                                  fontSize: isMobile(context)? 13.sp:10.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Color(0xFFEEEEEE),
              thickness: 1,
            ),
            SizedBox(
              height: 15.h,
            ),
            invoiceScreenController.trackingOrderModel!.data!.order!.billingAddress != null
                ? Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.r),
                ),
                border: Border.all(
                  color: const Color(0xFFEEEEEE),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      AppTags.accountDetails.tr,
                      style: TextStyle(
                        fontSize: isMobile(context)? 14.sp:11.sp,
                        fontFamily: "Poppins Medium",
                      ),
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppTags.name.tr}:",
                          style:  TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                            fontFamily: "Poppins Medium",
                          ),
                        ),
                        Text(
                          invoiceScreenController.trackingOrderModel!
                              .data!.order!.billingAddress!.name!
                              .toString(),
                          style: TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppTags.email.tr}:",
                          style: TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                            fontFamily: "Poppins Medium",
                          ),
                        ),
                        Text(
                          invoiceScreenController.trackingOrderModel!
                              .data!.order!.billingAddress!.email!
                              .toString(),
                          style: TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "${AppTags.shippingAddress.tr}:",
                              style: TextStyle(
                                fontSize: isMobile(context)? 13.sp:10.sp,
                                fontFamily: "Poppins Medium",
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 200.w,
                              child: Text(
                                invoiceScreenController.trackingOrderModel!.data!.order!
                                    .billingAddress!.address
                                    .toString(),
                                style: TextStyle(
                                  fontSize: isMobile(context)? 13.sp:10.sp,
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppTags.orderDate.tr}:",
                          style:  TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                            fontFamily: "Poppins Medium",
                          ),
                        ),
                        Text(
                          invoiceScreenController.trackingOrderModel!.data!.order!.date!
                              .toString(),
                          style:  TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppTags.paymentStatus.tr}:",
                          style:  TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                            fontFamily: "Poppins Medium",
                          ),
                        ),
                        Text(
                          invoiceScreenController.trackingOrderModel!
                              .data!.order!.paymentStatus!
                              .toString(),
                          style:  TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppTags.deliveryStatus.tr}:",
                          style:  TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                            fontFamily: "Poppins Medium",
                          ),
                        ),
                        Text(
                          invoiceScreenController.trackingOrderModel!
                              .data!.order!.orderStatus
                              .toString(),
                          style: TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              ),
            )
                : Container(height: 80.h),
            SizedBox(
              height: 15.h,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.r),
                ),
                border: Border.all(
                  color: const Color(0xFFEEEEEE),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppTags.subtotal.tr,
                          style: TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                          ),
                        ),
                        Text(
                          currencyConverterController.convertCurrency(
                              invoiceScreenController.trackingOrderModel!
                                  .data!.order!.formattedSubTotal
                                  .toString()),
                          style:  TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppTags.discountOffer.tr,
                          style:  TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                          ),
                        ),
                        Text(
                          currencyConverterController.convertCurrency(
                              invoiceScreenController.trackingOrderModel!
                                  .data!.order!.formattedDiscount
                                  .toString()),
                          style: TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppTags.deliveryCharge.tr,
                          style: TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                          ),
                        ),
                        Text(
                          currencyConverterController.convertCurrency(
                              invoiceScreenController.trackingOrderModel!
                                  .data!.order!.formattedShippingCost
                                  .toString()),
                          style:  TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppTags.tax.tr,
                          style: TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                          ),
                        ),
                        Text(
                          currencyConverterController.convertCurrency(
                              invoiceScreenController.trackingOrderModel!
                                  .data!.order!.formattedTax
                                  .toString()),
                          style:  TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color(0xFFEEEEEE),
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppTags.totalCost.tr,
                          style:  TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          currencyConverterController.convertCurrency(
                              invoiceScreenController.trackingOrderModel!
                                  .data!.order!.formattedTotalPayable
                                  .toString()),
                          style:  TextStyle(
                            fontSize: isMobile(context)? 13.sp:10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () async {
                  Uri url = Uri.parse(
                      "${NetworkService.apiUrl}/invoice-download/${invoiceScreenController.trackingOrderModel!.data!.order!.id}?token=${LocalDataHelper().getUserToken()}");

                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'could not launch $url';
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: AppThemeData.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: Text(
                    AppTags.downloadInvoice.tr,
                    style: isMobile(context)? AppThemeData.buttonTextStyle_14:AppThemeData.buttonTextStyle_11Tab,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ) : const ShimmerInvoice(),)

    );
  }
}


//
// class InvoiceScreen extends StatefulWidget {
//   final String? trackingId;
//   const InvoiceScreen({Key? key, this.trackingId}) : super(key: key);
//
//   @override
//   State<InvoiceScreen> createState() => _InvoiceScreenState();
// }
//
// class _InvoiceScreenState extends State<InvoiceScreen> {
//   bool isLoading = false;
//   final currencyConverterController = Get.find<CurrencyConverterController>();
//
//   TrackingOrderModel? trackingOrderModel;
//   Future getAllCampaign() async {
//     trackingOrderModel =
//         await Repository().getTrackingOrder(trackId: widget.trackingId);
//     setState(() {
//       isLoading = true;
//     });
//   }
//
//   @override
//   void initState() {
//     getAllCampaign();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:isMobile(context)? AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         centerTitle: true,
//         title: Text(
//           widget.trackingId.toString(),
//           style: AppThemeData.headerTextStyle_16,
//         ),
//       ): AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         toolbarHeight: 60.h,
//         leadingWidth: 40.w,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//             size: 25.r,
//           ),
//
//           onPressed: () {
//             Get.back();
//           }, // null disables the button
//         ),
//         centerTitle: true,
//         title: Text(
//           widget.trackingId.toString(),
//           style: AppThemeData.headerTextStyle_14,
//         ),
//       ),
//       body: isLoading
//           ? Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Column(
//                 children: [
//                   SingleChildScrollView(
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 250.h,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.vertical,
//                         child: Theme(
//                           data: Theme.of(context).copyWith(
//                             dividerColor: const Color(0xFFEEEEEE),
//                           ),
//                           child: DataTable(
//                             sortColumnIndex: 1,
//                             sortAscending: true,
//                             columnSpacing: 8,
//                             dataRowHeight: 70,
//                             columns: [
//                               DataColumn(
//                                 label: Text(
//                                   '#',
//                                   style: TextStyle(
//                                     fontSize: isMobile(context)? 14.sp:11.sp,
//                                     fontFamily: "Poppins Medium",
//                                   ),
//                                 ),
//                               ),
//                               DataColumn(
//                                 label: Text(
//                                   AppTags.products.tr,
//                                   style: TextStyle(
//                                     fontSize: isMobile(context)? 14.sp:11.sp,
//                                     fontFamily: "Poppins Medium",
//                                   ),
//                                 ),
//                               ),
//                               DataColumn(
//                                 label: Text(
//                                   AppTags.qty.tr,
//                                   style:  TextStyle(
//                                     fontSize: isMobile(context)? 14.sp:11.sp,
//                                     fontFamily: "Poppins Medium",
//                                   ),
//                                 ),
//                               ),
//                               DataColumn(
//                                 label: Text(
//                                   AppTags.total.tr,
//                                   style:  TextStyle(
//                                     fontSize: isMobile(context)? 14.sp:11.sp,
//                                     fontFamily: "Poppins Medium",
//                                   ),
//                                 ),
//                               ),
//                             ],
//                             rows: trackingOrderModel!.data!.order!.orderDetails!
//                                 .map(
//                                   (invoice) => DataRow(
//                                     cells: [
//                                       DataCell(
//                                         Text(
//                                           invoice.id.toString().padLeft(2, "0"),
//                                           style:  TextStyle(
//                                             fontSize: isMobile(context)? 13.sp:10.sp,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                       DataCell(
//                                         SizedBox(
//                                           width: 180.w,
//                                           height: 37.h,
//                                           child: Text(
//                                             invoice.productName!.toString(),
//                                             style: TextStyle(
//                                               fontSize: isMobile(context)? 13.sp:10.sp,
//                                               color: Colors.black,
//                                             ),
//                                             maxLines: 2,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ),
//                                       ),
//                                       DataCell(
//                                         Text(
//                                           invoice.quantity
//                                               .toString()
//                                               .padLeft(2, "0"),
//                                           style: TextStyle(
//                                             fontSize: isMobile(context)? 13.sp:10.sp,
//                                             color: Colors.black,
//                                           ),
//                                           textAlign: TextAlign.start,
//                                         ),
//                                       ),
//                                       DataCell(
//                                         Text(
//                                           currencyConverterController
//                                               .convertCurrency(invoice
//                                                   .formattedTotalPayable!
//                                                   .toString()),
//                                           style:  TextStyle(
//                                             fontSize: isMobile(context)? 13.sp:10.sp,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                                 .toList(),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const Divider(
//                     color: Color(0xFFEEEEEE),
//                     thickness: 1,
//                   ),
//                   SizedBox(
//                     height: 15.h,
//                   ),
//                   trackingOrderModel!.data!.order!.billingAddress != null
//                       ? Container(
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(10.r),
//                             ),
//                             border: Border.all(
//                               color: const Color(0xFFEEEEEE),
//                               width: 1,
//                             ),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 10.w),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: 15.h,
//                                 ),
//                                 Text(
//                                   AppTags.accountDetails.tr,
//                                   style: TextStyle(
//                                     fontSize: isMobile(context)? 14.sp:11.sp,
//                                     fontFamily: "Poppins Medium",
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "${AppTags.name.tr}:",
//                                       style:  TextStyle(
//                                         fontSize: isMobile(context)? 13.sp:10.sp,
//                                         fontFamily: "Poppins Medium",
//                                       ),
//                                     ),
//                                     Text(
//                                       trackingOrderModel!
//                                           .data!.order!.billingAddress!.name!
//                                           .toString(),
//                                       style: TextStyle(
//                                         fontSize: isMobile(context)? 13.sp:10.sp,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "${AppTags.email.tr}:",
//                                       style: TextStyle(
//                                         fontSize: isMobile(context)? 13.sp:10.sp,
//                                         fontFamily: "Poppins Medium",
//                                       ),
//                                     ),
//                                     Text(
//                                       trackingOrderModel!
//                                           .data!.order!.billingAddress!.email!
//                                           .toString(),
//                                       style: TextStyle(
//                                         fontSize: isMobile(context)? 13.sp:10.sp,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       children: [
//                                         Text(
//                                           "${AppTags.shippingAddress.tr}:",
//                                           style: TextStyle(
//                                             fontSize: isMobile(context)? 13.sp:10.sp,
//                                             fontFamily: "Poppins Medium",
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Column(
//                                       children: [
//                                         SizedBox(
//                                           //width: 200,
//                                           child: Text(
//                                             trackingOrderModel!.data!.order!
//                                                 .billingAddress!.address
//                                                 .toString(),
//                                             style: TextStyle(
//                                               fontSize: isMobile(context)? 13.sp:10.sp,
//                                             ),
//                                             maxLines: 2,
//                                             textAlign: TextAlign.end,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "${AppTags.orderDate.tr}:",
//                                       style:  TextStyle(
//                                         fontSize: isMobile(context)? 13.sp:10.sp,
//                                         fontFamily: "Poppins Medium",
//                                       ),
//                                     ),
//                                     Text(
//                                       trackingOrderModel!.data!.order!.date!
//                                           .toString(),
//                                       style:  TextStyle(
//                                         fontSize: isMobile(context)? 13.sp:10.sp,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "${AppTags.paymentStatus.tr}:",
//                                       style:  TextStyle(
//                                         fontSize: isMobile(context)? 13.sp:10.sp,
//                                         fontFamily: "Poppins Medium",
//                                       ),
//                                     ),
//                                     Text(
//                                       trackingOrderModel!
//                                           .data!.order!.paymentStatus!
//                                           .toString(),
//                                       style:  TextStyle(
//                                         fontSize: isMobile(context)? 13.sp:10.sp,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "${AppTags.deliveryStatus.tr}:",
//                                       style:  TextStyle(
//                                         fontSize: isMobile(context)? 13.sp:10.sp,
//                                         fontFamily: "Poppins Medium",
//                                       ),
//                                     ),
//                                     Text(
//                                       trackingOrderModel!
//                                           .data!.order!.orderStatus
//                                           .toString(),
//                                       style: TextStyle(
//                                         fontSize: isMobile(context)? 13.sp:10.sp,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 15.h,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       : Container(height: 80.h),
//                   SizedBox(
//                     height: 15.h,
//                   ),
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(10.r),
//                       ),
//                       border: Border.all(
//                         color: const Color(0xFFEEEEEE),
//                         width: 1,
//                       ),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10.w),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 15.h,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 AppTags.subtotal.tr,
//                                 style: TextStyle(
//                                   fontSize: isMobile(context)? 13.sp:10.sp,
//                                 ),
//                               ),
//                               Text(
//                                 currencyConverterController.convertCurrency(
//                                     trackingOrderModel!
//                                         .data!.order!.formattedSubTotal
//                                         .toString()),
//                                 style:  TextStyle(
//                                   fontSize: isMobile(context)? 13.sp:10.sp,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 AppTags.discountOffer.tr,
//                                 style:  TextStyle(
//                                   fontSize: isMobile(context)? 13.sp:10.sp,
//                                 ),
//                               ),
//                               Text(
//                                 currencyConverterController.convertCurrency(
//                                     trackingOrderModel!
//                                         .data!.order!.formattedDiscount
//                                         .toString()),
//                                 style: TextStyle(
//                                   fontSize: isMobile(context)? 13.sp:10.sp,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 AppTags.deliveryCharge.tr,
//                                 style: TextStyle(
//                                   fontSize: isMobile(context)? 13.sp:10.sp,
//                                 ),
//                               ),
//                               Text(
//                                 currencyConverterController.convertCurrency(
//                                     trackingOrderModel!
//                                         .data!.order!.formattedShippingCost
//                                         .toString()),
//                                 style:  TextStyle(
//                                   fontSize: isMobile(context)? 13.sp:10.sp,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 AppTags.tax.tr,
//                                 style: TextStyle(
//                                   fontSize: isMobile(context)? 13.sp:10.sp,
//                                 ),
//                               ),
//                               Text(
//                                 currencyConverterController.convertCurrency(
//                                     trackingOrderModel!
//                                         .data!.order!.formattedTax
//                                         .toString()),
//                                 style:  TextStyle(
//                                   fontSize: isMobile(context)? 13.sp:10.sp,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const Divider(
//                             color: Color(0xFFEEEEEE),
//                             thickness: 1,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 AppTags.totalCost.tr,
//                                 style:  TextStyle(
//                                   fontSize: isMobile(context)? 13.sp:10.sp,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Text(
//                                 currencyConverterController.convertCurrency(
//                                     trackingOrderModel!
//                                         .data!.order!.formattedTotalPayable
//                                         .toString()),
//                                 style:  TextStyle(
//                                   fontSize: isMobile(context)? 13.sp:10.sp,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 15.h,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const Spacer(),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 48.h,
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         Uri url = Uri.parse(
//                             "${NetworkService.apiUrl}/invoice-download/${trackingOrderModel!.data!.order!.id}?token=${LocalDataHelper().getUserToken()}");
//
//                         if (await canLaunchUrl(url)) {
//                           await launchUrl(url);
//                         } else {
//                           throw 'could not launch $url';
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         primary: AppThemeData.buttonColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.r),
//                         ),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.all(10.r),
//                         child: Text(
//                           AppTags.downloadInvoice.tr,
//                           style: isMobile(context)? AppThemeData.buttonTextStyle_14:AppThemeData.buttonTextStyle_11Tab,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30.h,
//                   ),
//                 ],
//               ),
//             )
//           : const ShimmerInvoice(),
//     );
//   }
// }
