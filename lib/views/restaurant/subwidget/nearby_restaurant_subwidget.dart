import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/models/restaurant_model.dart';
import 'package:rider/views/restaurant/subwidget/restaurant_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class NearbyRestaurantSubwidget extends StatelessWidget {
  const NearbyRestaurantSubwidget({super.key, required this.restaurant});
  final RestaurantModel restaurant;
  

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();


      var latitude = box.read("presentLat");
      var longitude = box.read("presentLng");

      var distance = ((Geolocator.distanceBetween(latitude, longitude, restaurant.coords.latitude, restaurant.coords.longitude) / 1000).round());
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RestaurantOrders(restaurant: restaurant,)));
      },
      child: Container(
        height: 100.h,
        width: 322.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.43)),
          color: Tcolor.White,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Stack(
                children: [
                  Image.network(
                    restaurant.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 60.h,
                      width: width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 16,
                              offset: Offset(0, 4),
                              blurStyle: BlurStyle.inner,
                              spreadRadius: 4),
                        ],
                        color: Color.fromRGBO(
                            255, 255, 255, 0.43), // Semi-transparent overla
                      ),
                      child: Column(
                        children: [
                          ReuseableText(
                            title: restaurant.title,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Tcolor.Text,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 0, right: 10.h),
                            child: Wrap(
                              spacing: 10.w,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runSpacing: 5.h,
                              children: [
                                ReuseableText(
                                  title: restaurant.time[0].open,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff404040),
                                  ),
                                ),
                                ReuseableText(
                                  title: restaurant.time[0].close,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff404040),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                Container(
                                  width: 8.w,
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xff404040),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                ReuseableText(
                                  title: "$distance KM",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff404040),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RatingBarIndicator(
                            itemCount: 5,
                            rating: restaurant.rating,
                            unratedColor: Color.fromRGBO(165, 119, 0, 0.41),
                            itemSize: 15.sp,
                            itemBuilder: (context, i) {
                              return Icon(
                                HeroiconsSolid.star,
                                size: 24.sp,
                                color: Color(0xffA57700),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  //
                  //
                  //
                  //

                  Padding(
                    padding:
                        EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 30.h,
                        width: 88.w,
                        color: Color.fromRGBO(8, 102, 52, 0.75),
                        child: Center(
                          child: ReuseableText(
                            title: "OPEN",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Tcolor.White,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
