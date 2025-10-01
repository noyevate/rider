import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/shorten_address.dart';
import 'package:rider/hooks/fetch_single_restaurant_order.dart';
import 'package:rider/models/distance_time_model.dart';
import 'package:rider/models/order_model.dart';
import 'package:rider/models/restaurant_search.dart';
import 'package:rider/services/distance.dart';
import 'package:rider/shimer/order_shimmer.dart';
import 'package:rider/views/home/widget/subwidget/restaurant_search_order_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class HomePageRestuarantOrders extends HookWidget {
  const HomePageRestuarantOrders({super.key, required this.restaurant});

  final RestaurantSearch restaurant;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final riderId = box.read("riderId"); 
    final hookResult =
        useFetchNewRestaurantOrder(restaurant.id, "Placed", "Completed", riderId);
    final List<OrderModel> orders = hookResult.data ?? [];
    final bool isLoading = hookResult.isLoading;
    final Exception? error = hookResult.error;
    print("new orders.length: ${orders.length}");

    final distanceCalculator = Distance();
    var speedKmPerHr = 30.0;

    final presentLat = box.read("presentLat");
    final presentLng = box.read("presentLng");

    
      print("pre_latitue: lat = ${box.read("presentLat")}");

    DistanceTime? distanceTime;

    distanceTime = distanceCalculator.calculateDistanceTimePrice(
        restaurant.coords.latitude,
        restaurant.coords.longitude,
        presentLat,
        presentLng,
        speedKmPerHr);

    return Scaffold(
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.h),
        child: Column(
          children: [
            SizedBox(
              height: 80.h,
            ),
            ReuseableText(
              title:
                  "${restaurant.title} ${shortenCharacters(restaurant.coords.address)}...",
              style: TextStyle(
                color: Tcolor.Text,
                fontSize: 33.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            ReuseableText(
              title: presentLng != null || presentLat != null
                  ? "(${(distanceTime.distance).round()} km away)"
                  : "(__ away)",
              style: TextStyle(
                color: Tcolor.Text,
                fontSize: 33.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: isLoading
          ? OrderShimmer()
          : orders.isEmpty
              ? Center(
                  child: ReuseableText(
                      title: "No order for this restaurant...",
                      style: TextStyle(
                          color: Tcolor.TEXT_Placeholder,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500)),
                )
              : SizedBox(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(orders.length, (i) {
                        var order = orders[i];
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 30.w, right: 30.w, bottom: 20.h),
                          child: RestaurantSearchOrderTile(order: order),
                        );
                      }),
                    ),
                  ),
    )
    );
  }
}
