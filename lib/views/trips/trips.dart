import 'package:rider/common/color_extension.dart';
import 'package:rider/common/custom_appbar.dart';
import 'package:rider/common/custom_button.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/controllers/hompage_controller.dart';
import 'package:rider/hooks/fetch_current_trip.dart';
import 'package:rider/models/current_trip_order_model.dart';
import 'package:rider/models/single_restaurant_model.dart';
import 'package:rider/shimer/trips_shimmer.dart';
import 'package:rider/views/trips/widget/delivery_tracking_detail.dart';
import 'package:rider/views/trips/widget/subwidgets/trip_history_list.dart';
import 'package:rider/views/trips/widget/subwidgets/trip_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

import '../../models/address_model.dart';

class Trips extends HookWidget {
  const Trips({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final riderId = box.read("userid");

    final homeController = Get.put(HomepageController());

    final hookResult = fetchCurrentTrip(riderId);
    final CurrentTripOrderModel? order = hookResult.data;
    final bool isLoading = hookResult.isLoading;
    final Exception? error = hookResult.error;
//    Only fetch restaurant when riderTrips.value is not null

    final riderTrips = useState<CurrentTripOrderModel?>(null);
    final orderRestaurant = useState<SingleRestaurantModel?>(null);
    final orderDelivery = useState<AddressModel?>(null);

    riderTrips.value = order;
    useEffect(() {
      if (riderTrips.value != null) {
        Future.microtask(() async {
          final restaurant = await homeController
              .fetchResturant(riderTrips.value!.restaurantId);
          print("Trip Restaurant title: ${restaurant.title}");
          orderRestaurant.value = restaurant;

          print("Fetched Restaurant: ${restaurant}");
        });
      }
      return null; // No cleanup needed
    }, [riderTrips.value]);

    useEffect(() {
      if (riderTrips.value != null) {
        Future.microtask(() async {
          final orderAddress = await homeController
              .fetchAddress(riderTrips.value!.deliveryAddress);
          print("deliver address: ${orderAddress.address.addressLine1}");
          orderDelivery.value = orderAddress;
        });
      }
      return null; // No cleanup needed
    }, [riderTrips.value]);

    print("pre_latitue: lat = ${box.read("presentLat")}");

    double distance = 0;
    if (orderRestaurant.value != null && orderDelivery.value != null) {
      distance = Geolocator.distanceBetween(
        orderRestaurant.value!.coords.latitude,
        orderRestaurant.value!.coords.longitude,
        orderDelivery.value!.address.latitude,
        orderDelivery.value!.address.longitude,
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(224.h),
        child: const CustomAppBar(
          rating: 5.5,
          notificationCount: 3,
          date: '',
        ),
      ),
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      body: Column(
        children: [
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  ReuseableText(
                      title: "Active Trip",
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500,
                          color: Tcolor.Text)),
                  SizedBox(
                    width: 20.w,
                  ),
                  Image.asset("assets/img/active_trip_motobike.png")
                ]),
                SizedBox(
                  height: 20.h,
                ),
                isLoading || homeController.isLoading || error != null
                    ? TripsShimmer()
                    : order == null
                        ? SizedBox(
                            height: 400.h,
                            width: width,
                            child: Center(
                              child: ReuseableText(
                                  title: "No active trips found.",
                                  style: TextStyle(
                                      color: Tcolor.Text,
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w500)),
                            ),
                          )
                        : Container(
                            height: 400.h,
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: Tcolor.White,
                                border: Border.all(
                                    color: Tcolor.TEXT_Placeholder,
                                    width: 0.3)),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ReuseableText(
                                              title: riderTrips.value != null
                                                  ? riderTrips
                                                      .value!
                                                      .orderItems[0]
                                                      .additives[0]
                                                      .foodTitle
                                                  : "",
                                              style: TextStyle(
                                                  color: Tcolor.Text,
                                                  fontSize: 28.sp,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          ReuseableText(
                                              title: orderRestaurant.value !=
                                                          null &&
                                                      orderDelivery.value !=
                                                          null
                                                  ? "Restaurant: ${orderRestaurant.value!.title}"
                                                  : "",
                                              style: TextStyle(
                                                  color: Tcolor.TEXT_Body,
                                                  fontSize: 22.sp,
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 130.w,
                                        child: CustomButton(
                                          title: "See details",
                                          showArrow: false,
                                          btnHeight: 60.sp,
                                          btnWidth: 130.w,
                                          btnColor: orderRestaurant.value !=
                                                      null &&
                                                  orderDelivery.value != null &&
                                                  riderTrips.value != null
                                              ? Tcolor.Primary_New
                                              : Tcolor.TEXT_Placeholder,
                                          raduis: 6.r,
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.w500,
                                          textColor: Tcolor.Text,
                                          onTap: orderRestaurant.value !=
                                                      null &&
                                                  orderDelivery.value != null &&
                                                  riderTrips.value != null
                                              ? () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DeliveryTrackingDetail(
                                                                restaurant:
                                                                    orderRestaurant
                                                                        .value,
                                                                order:
                                                                    riderTrips
                                                                        .value,
                                                                orderDelivery:
                                                                    orderDelivery
                                                                        .value,
                                                              )));
                                                }
                                              : null,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Divider(
                                    color: Tcolor.Location_Text_Sheet_colour,
                                    thickness: 0.5.sp),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 30.w, right: 30.w),
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                      color:
                                                          Tcolor.Primary_New),
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
                                                    shape: BoxShape.circle,
                                                    color: Tcolor.White),
                                                child: Center(
                                                  child: Container(
                                                    height: 18.h,
                                                    width: 18.w,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Tcolor.TEXT_Body),
                                                    child: Center(
                                                      child: ReuseableText(
                                                          title: "2",
                                                          style: TextStyle(
                                                              color:
                                                                  Tcolor.White,
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                HeroiconsMini.mapPin,
                                                color: Tcolor.Text,
                                                size: 32.sp,
                                              ),
                                              ReuseableText(
                                                  title: orderDelivery.value !=
                                                              null &&
                                                          orderRestaurant
                                                                  .value !=
                                                              null &&
                                                          riderTrips.value !=
                                                              null
                                                      ? "Drop off (${(distance / 1000).round()}km away from restaurant)"
                                                      : "Calculating distance...",
                                                  style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              250, 0, 0, 0),
                                                      fontSize: 24.sp,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          SizedBox(
                                            width: 440.w,
                                            child: Text(
                                              orderDelivery.value != null &&
                                                      orderRestaurant.value !=
                                                          null &&
                                                      riderTrips.value != null
                                                  ? orderDelivery.value!.address
                                                      .addressLine1
                                                  : "Getting address.",
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
                                  padding:
                                      EdgeInsets.only(left: 30.w, right: 30.w),
                                  child: Row(
                                    children: [
                                      ReuseableText(
                                          title: "Status: ",
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  250, 0, 0, 0),
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.w500)),
                                      if (riderTrips.value != null)
                                        ReuseableText(
                                            title: riderTrips.value!.riderStatus ==
                                                    "RA"
                                                ? "Enroute to pick up point"
                                                : riderTrips.value!
                                                            .riderStatus ==
                                                        "AR"
                                                    ? ": At the restaurant"
                                                    : riderTrips.value!
                                                                .riderStatus ==
                                                            "TDP"
                                                        ? "Enroute to the delivery point"
                                                        : riderTrips.value!
                                                                    .riderStatus ==
                                                                "ADP"
                                                            ? " At the delivery point"
                                                            : riderTrips.value!
                                                                        .riderStatus ==
                                                                    "OD"
                                                                ? "Delivery Completed"
                                                                : "verifying rider status",
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    250, 0, 0, 0),
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                TripTracker(
                                  trip: riderTrips.value,
                                ),
                              ],
                            ),
                          ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 400.h,
          // ),
          SizedBox(
            height: 15.h,
          ),
          Divider(color: Tcolor.Location_Text_Sheet_colour, thickness: 0.5.sp),
          SizedBox(
            height: 15.h,
          ),
          Expanded(
            child: Container(
              color: Tcolor.White,
              height: height,
              child: Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ReuseableText(
                              title: "History",
                              style: TextStyle(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Tcolor.Text)),
                          SizedBox(
                            width: 10.w,
                          ),
                          Icon(
                            MaterialIcons.history,
                            color: Tcolor.Text,
                            size: 35.sp,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      TripHistoryList(),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
