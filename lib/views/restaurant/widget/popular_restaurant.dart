import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/hooks/fetch_nearby_restaurant.dart';
import 'package:rider/hooks/fetch_popular_restaurant.dart';
import 'package:rider/models/restaurant_model.dart';
import 'package:rider/shimer/restaurant_shimer.dart';
import 'package:rider/views/restaurant/subwidget/restaurant_widget.dart';
import 'package:rider/views/restaurant/subwidget/nearby_restaurant_Widget.dart';
import 'package:rider/views/restaurant/widget/nearby_restaurant_list.dart';
import 'package:rider/views/restaurant/widget/popular_restaurant_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/common/size.dart';

class PopularRestaurant extends HookWidget {
  const PopularRestaurant({super.key});

  @override
  Widget build(BuildContext context) {


    // Popular restaurant
    final hookResult = useFetchPopularRestaurants();
    final List<RestaurantModel> popularRestuarants = hookResult.data ?? [];
    final bool isLoading = hookResult.isLoading;
    final Exception? error = hookResult.error;
    print("popularRestuarants.length: ${popularRestuarants.length}");

    
    //  NearBy Restaurant
    final hookResult2 = useFetchRestaurants("241105");
    final List<RestaurantModel> nearbyRestaurant = hookResult2.data ?? [];
    final bool isLoading2 = hookResult2.isLoading;
    final Exception? error2 = hookResult2.error;
    print("nearbyRestaurant.statuscode: ${nearbyRestaurant.length}");

    
    


    return Container(
      height: 1000.h,
      width: width,
      color: Tcolor.White,
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReuseableText(
                  title: "Popular Restaurants",
                  style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w500,
                      color: Tcolor.Text),
                ),
                isLoading ? RestaurantShimer() :
                Container(
                  width: 110.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Material(
                    color: Colors
                        .transparent, // Keeps the decoration color visible
                    borderRadius: BorderRadius.circular(18.r),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18.r),
                      // splashColor: const Color.fromARGB(
                      //     255, 218, 213, 213), // The dark shade effect
                      highlightColor:
                          Colors.black26, // Lighter highlight effect
                      onTap: () {
                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PopularRestaurantList(popularRestaurants: popularRestuarants,)));
                      },
                      child: Center(
                        child: ReuseableText(
                          title: "See All...",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 22.sp,
                            color: Color.fromRGBO(146, 50, 255, 0.9),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 300.h,
            width: width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(popularRestuarants.length, (i) {
                var popularRestaurant = popularRestuarants[i];
                return Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: RestaurantWidget(restaurant: popularRestaurant,
                    
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Divider(
            color: Tcolor.Location_Text_Sheet_colour,
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReuseableText(
                  title: "Nearby restaurants",
                  style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w500,
                      color: Tcolor.Text),
                ),
                isLoading2 ? RestaurantShimer() :
                Container(
                  width: 110.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Material(
                    color: Colors
                        .transparent, // Keeps the decoration color visible
                    borderRadius: BorderRadius.circular(18.r),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18.r),
                      // splashColor: const Color.fromARGB(
                      //     255, 218, 213, 213), // The dark shade effect
                      highlightColor:
                          Colors.black26, // Lighter highlight effect
                      onTap: () {
                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NearbyRestaurantList(nearbyRestaurant: nearbyRestaurant,)));
                      },
                      child: Center(
                        child: ReuseableText(
                          title: "See All...",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 22.sp,
                            color: Color.fromRGBO(146, 50, 255, 0.9),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300.h,
            width: width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(nearbyRestaurant.length, (i) {
                var restaurant2 = nearbyRestaurant[i];
                return Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: NearbyRestaurantwidget(restaurant: restaurant2,
                    
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
