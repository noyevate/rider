// ignore_for_file: unused_local_variable

import 'package:rider/common/color_extension.dart';
import 'package:rider/common/custom_button.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/controllers/hompage_controller.dart';
import 'package:rider/models/address_model.dart';
import 'package:rider/models/order_model.dart';
import 'package:rider/models/single_restaurant_model.dart';
import 'package:rider/services/distance.dart';
import 'package:rider/views/home/widget/order_details.dart';
import 'package:rider/views/restaurant/subwidget/order_details_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:rider/models/distance_time_model.dart';

class OrderTile1 extends HookWidget {
  const OrderTile1({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomepageController());

    final orderRestaurant = useState<SingleRestaurantModel?>(null);
    final orderDelivery = useState<AddressModel?>(null);

    useEffect(() {
      Future.microtask(() async {
        final restaurant = await controller.fetchResturant(order.restaurantId);
        orderRestaurant.value =
            restaurant; // Update the state with fetched additives
      });
      return null; // No cleanup needed
    }, [order.restaurantId]);

    useEffect(() {
      Future.microtask(() async {
        final address = await controller.fetchAddress(order.deliveryAddress);
        orderDelivery.value =
            address; // Update the state with fetched additives
      });
      return null; // No cleanup needed
    }, [order.deliveryAddress]);

    final distanceCalculator = Distance();
    var speedKmPerHr = 30.0;

    DistanceTime? distanceTime;
    if (orderRestaurant.value != null && orderDelivery.value != null) {
      distanceTime = distanceCalculator.calculateDistanceTimePrice(
          orderRestaurant.value!.coords.latitude,
          orderRestaurant.value!.coords.longitude,
          orderDelivery.value!.address.latitude,
          orderDelivery.value!.address.longitude,
          speedKmPerHr);
    }

    return Container(
        height: 350.h,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r), color: Tcolor.White),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 30.w,
                right: 30.w,
                top: 20.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReuseableText(
                          title: order.orderItems[0].additives[0].foodTitle,
                          style: TextStyle(
                              color: Tcolor.Text,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 5.h,
                      ),
                      ReuseableText(
                          title: orderRestaurant.value == null
                              ? "Restaurant:"
                              : "Restaurant: ${orderRestaurant.value!.title}",
                          style: TextStyle(
                              color: Tcolor.TEXT_Body,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(
                    width: 130.w,
                    child: CustomButton(
                      title: orderRestaurant.value != null &&
                              orderDelivery.value != null
                          ? "${distanceTime!.distance.round()}km away"
                          : "__",
                      showArrow: false,
                      btnHeight: 60.sp,
                      btnWidth: 130.w,
                      btnColor: Tcolor.Primary_New,
                      raduis: 6.r,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Divider(
                color: Tcolor.Location_Text_Sheet_colour, thickness: 0.5.sp),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: Row(
                children: [
                  Container(
                    height: 120.h,
                    width: 120.w,
                    color: Tcolor.White,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              height: 90.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Tcolor.Primary_New),
                              child: Center(
                                child: Image.asset(
                                  "assets/img/food_icon2.png",
                                  width: 38.w,
                                  height: 38.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 35,
                          right: 20.w,
                          child: Container(
                            height: 30.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Tcolor.White),
                            child: Center(
                              child: Container(
                                height: 18.h,
                                width: 18.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Tcolor.TEXT_Body),
                                child: Center(
                                  child: ReuseableText(
                                      title: "2",
                                      style: TextStyle(
                                          color: Tcolor.White,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            HeroiconsMini.mapPin,
                            color: Tcolor.Text,
                            size: 32.sp,
                          ),
                          ReuseableText(
                              title: "Drop off (2km away from restaurant)",
                              style: TextStyle(
                                  color: const Color.fromARGB(250, 0, 0, 0),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        width: 440.w,
                        child: Text(
                          orderDelivery.value == null
                              ? ""
                              : orderDelivery.value!.address.addressLine1,
                          style: TextStyle(
                              color: Tcolor.TEXT_Label,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Aeonik'),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      title: "IGNORE",
                      showArrow: false,
                      btnColor: Colors.transparent,
                      border: Border.all(
                        color: Tcolor.Primary_New,
                      ),
                      btnWidth: width / 2.5,
                      raduis: 6.r,
                      textColor: Tcolor.Text,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      onTap: () {},
                    ),
                    CustomButton(
                      title: "ACCEPT",
                      showArrow: false,
                      btnColor: orderRestaurant.value != null &&
                              orderDelivery.value != null
                          ? Tcolor.Primary_New
                          : Tcolor.TEXT_Placeholder,
                      btnWidth: width / 2.5,
                      raduis: 6.r,
                      textColor: Tcolor.Text,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      onTap: orderRestaurant.value != null &&
                              orderDelivery.value != null
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderDetails1(
                                      orderRestaurant: orderRestaurant.value,
                                      orderDelivery: orderDelivery.value,
                                      order: order),
                                ),
                              );
                              // Get.to(() => OrderDetails(
                              //     orderRestaurant: orderRestaurant.value,
                              //     orderDelivery: orderDelivery.value,
                              //     order: order), preventDuplicates: false);
                            }
                          : null, // Disable tap if data is not ready
                    )
                  ]),
            )
          ],
        ));
  }
}
