import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoori_ecommerce/src/models/home_data_model.dart';

import '../utils/app_theme_data.dart';


class ShopTypeWidget extends StatelessWidget {
  final HomeDataModel? homeDataModel;
  final int index;

  const ShopTypeWidget(
      {Key? key, required this.homeDataModel, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        padding: EdgeInsets.only(right: 15.w),
        itemCount: homeDataModel!.data![index].bestShops!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 0.0.w, left: 15.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200,
                  width: 165,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(7.r)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff404040).withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 10.r,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                homeDataModel!
                                    .data![index].bestShops![index].banner!
                                    .toString(),
                              ),
                            ),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 4, bottom: 4, top: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 35,
                              ),
                              RatingBarIndicator(
                                rating: double.parse(
                                  homeDataModel!
                                      .data![index].bestShops![index].rating!
                                      .toString(),
                                ),
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star_border,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 18.0,
                                direction: Axis.horizontal,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                homeDataModel!
                                    .data![index].bestShops![index].shopName!,
                                style: AppThemeData.titleTextStyle_14,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 55,
                  child: Container(
                    height: 60,
                    width: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(35.r)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff404040).withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 6,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            homeDataModel!.data![index].bestShops![index].logo!
                                .toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
