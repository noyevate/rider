import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/hooks/fetch_single_restaurant_order.dart';
import 'package:rider/models/order_model.dart';
import 'package:rider/models/restaurant_model.dart';
import 'package:rider/shimer/order_shimmer.dart';
import 'package:rider/views/restaurant/subwidget/ordertile_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class RestaurantOrders extends HookWidget {
  const RestaurantOrders({super.key, required this.restaurant});
  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    final hookResult =
        useFetchNewRestaurantOrder(restaurant.id, "Placed", "Completed", "67a03fc6d174fb655800ef88");
    final List<OrderModel> orders = hookResult.data ?? [];
    final bool isLoading = hookResult.isLoading;
    final Exception? error = hookResult.error;
    print("new orders.length: ${orders.length}");

    return Scaffold(
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: Column(
          children: [
            SizedBox(
              height: 60.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 30.w),
              height: 80.h,
              color: Tcolor.BACKGROUND_Regaular,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0, // Align the icon to the left
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Restaurants()));
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 62.h,
                        width: 62.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Tcolor.White,
                        ),
                        child: Icon(
                          HeroiconsMini.chevronLeft,
                          color: Tcolor.Text,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        ReuseableText(
                          title: restaurant.title,
                          style: TextStyle(
                            fontSize: 32.sp,
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
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff404040),
                                ),
                              ),
                              ReuseableText(
                                title: restaurant.time[0].close,
                                style: TextStyle(
                                  fontSize: 17.sp,
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
                                title: "20 km",
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff404040),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            ReuseableText(
                              title: "(${restaurant.ratingCount})",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff404040),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
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
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(orders.length, (i) {
                          var order = orders[i];
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 30.w, right: 30.w, bottom: 20.h),
                            child: OrderTile1(order: order),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
    );
  }
}
