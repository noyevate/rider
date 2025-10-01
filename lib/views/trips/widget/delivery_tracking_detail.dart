import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rider/common/color_extension.dart';
import 'package:rider/common/custom_button.dart';
import 'package:rider/common/format_price.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/controllers/trips_controller.dart';
import 'package:rider/models/address_model.dart';
import 'package:rider/models/current_trip_order_model.dart';
import 'package:rider/models/order_model.dart';
import 'package:rider/models/payout_model.dart';
import 'package:rider/models/payout_response_model.dart';
import 'package:rider/models/single_restaurant_model.dart';
import 'package:rider/others/broken_straight_line.dart';
import 'package:rider/views/trips/trips.dart';
import 'package:rider/views/trips/widget/subwidgets/trip_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controllers/order_controller.dart';

class DeliveryTrackingDetail extends StatelessWidget {
  const DeliveryTrackingDetail(
      {super.key,
      required this.restaurant,
      required this.order,
      this.orderDelivery});
  final SingleRestaurantModel? restaurant;
  final CurrentTripOrderModel? order;
  final AddressModel? orderDelivery;

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    final tripController = Get.put(TripsController());
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Tcolor.BACKGROUND_Regaular,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(130.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 90.h,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30.w),
                    height: 70.h,
                    color: Tcolor.BACKGROUND_Regaular,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0, // Align the icon to the left
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Trips()));
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
                          child: ReuseableText(
                            title: "Delivery Details",
                            style: TextStyle(
                              color: Tcolor.Text,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Container(
                    height: 1000.h,
                    width: width,
                    decoration: BoxDecoration(
                        color: Tcolor.White,
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: Tcolor.BORDER_Regular)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 30.w, right: 30.w, top: 20.h),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 100.h,
                                  width: 100.w,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.r),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.network(
                                        restaurant!.imageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              "assets/img/checkers.png");
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReuseableText(
                                      title: restaurant!.title,
                                      style: TextStyle(
                                        color: Tcolor.Text,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    ReuseableText(
                                      title: "150 Deliveries",
                                      style: TextStyle(
                                        color: Tcolor.TEXT_Label,
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        RatingBarIndicator(
                                          itemCount: 5,
                                          rating: restaurant!.rating,
                                          unratedColor: Tcolor.Primary_14,
                                          itemSize: 26.sp,
                                          itemBuilder: (context, i) {
                                            return Icon(
                                              HeroiconsSolid.star,
                                              size: 24.sp,
                                              color: Tcolor.Primary_New,
                                            );
                                          },
                                        ),
                                        ReuseableText(
                                          title: "(${restaurant!.ratingCount})",
                                          style: TextStyle(
                                            color: Tcolor.Primary_New,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                          //
                          //
                          SizedBox(
                            height: 5.h,
                          ),
                          Divider(
                            color: Tcolor.Location_Text_Sheet_colour,
                            thickness: 0.5.sp,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          //
                          //

                          Padding(
                            padding: EdgeInsets.only(left: 30.w, right: 30.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      HeroiconsMini.mapPin,
                                      color: Tcolor.SUCCESS_Light_1,
                                      size: 32.sp,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ReuseableText(
                                            title: "Pickup Location",
                                            style: TextStyle(
                                              color: Tcolor.TEXT_Label,
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          ReuseableText(
                                            title: restaurant!.coords.address,
                                            style: TextStyle(
                                              color: Tcolor.Text,
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            softWrap:
                                                true, // Allow the text to wrap to the next line
                                            overflow: TextOverflow
                                                .visible, // Ensure visibility of overflowed text
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                BrokenStraightLine(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      HeroiconsMini.mapPin,
                                      color: Tcolor.Red,
                                      size: 32.sp,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ReuseableText(
                                            title: "Delivery location",
                                            style: TextStyle(
                                              color: Tcolor.TEXT_Label,
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                            child: ReuseableText(
                                              title: orderDelivery!
                                                  .address.addressLine1,
                                              style: TextStyle(
                                                color: Tcolor.Text,
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              softWrap:
                                                  true, // Allow the text to wrap to the next line
                                              overflow: TextOverflow
                                                  .visible, // Ensure visibility of overflowed text
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 100.h,
                                )
                              ],
                            ),
                          ),

                          //
                          //
                          //

                          Padding(
                            padding: EdgeInsets.only(left: 30.w, right: 30.w),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ReuseableText(
                                          title: "What you are delivering",
                                          style: TextStyle(
                                            color: Tcolor.TEXT_Placeholder,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 280.w,
                                          height: 100.h,
                                          child: ReuseableText(
                                            title: order!.orderItems[0]
                                                        .numberOfPack <
                                                    2
                                                ? "${order!.orderItems[0].numberOfPack} pack of ${order!.orderItems[0].additives[0].foodTitle}"
                                                : "${order!.orderItems[0].numberOfPack} packs of ${order!.orderItems[0].additives[0].foodTitle}",
                                            style: TextStyle(
                                              color: Tcolor.Text,
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ReuseableText(
                                          title: "Recipient",
                                          style: TextStyle(
                                            color: Tcolor.TEXT_Placeholder,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 300.w,
                                          height: 100.h,
                                          child: ReuseableText(
                                            title: order!.customerName,
                                            style: TextStyle(
                                              color: Tcolor.Text,
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // SizedBox(
                                //   height: 50.h,
                                // )
                              ],
                            ),
                          ),
                          //
                          //
                          SizedBox(
                            height: 10.h,
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 30.w, right: 30.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReuseableText(
                                  title: "Recipient Phone no",
                                  style: TextStyle(
                                    color: Tcolor.TEXT_Placeholder,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    ReuseableText(
                                      title: order!.customerPhone,
                                      style: TextStyle(
                                        color: Tcolor.Text,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    GestureDetector(
                                        onTap: order != null
                                            ? () async {
                                                final Uri phoneUri = Uri.parse(
                                                    "tel:${order!.customerPhone}");
                                                if (await canLaunchUrl(
                                                    phoneUri)) {
                                                  await launchUrl(phoneUri);
                                                } else {
                                                  print(
                                                      "Could not launch call");
                                                }
                                              }
                                            : null,
                                        child: Image.asset(
                                            "assets/img/call_image.png"))
                                  ],
                                ),
                              ],
                            ),
                          ),

                          //
                          //
                          //
                          SizedBox(
                            height: 20.h,
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 30.w, right: 30.w),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ReuseableText(
                                          title: "Payment ",
                                          style: TextStyle(
                                            color: Tcolor.TEXT_Placeholder,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 280.w,
                                          height: 100.h,
                                          child: ReuseableText(
                                            title: "Transfer",
                                            style: TextStyle(
                                              color: Tcolor.Text,
                                              fontSize: 28.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ReuseableText(
                                          title: "Fee",
                                          style: TextStyle(
                                            color: Tcolor.TEXT_Placeholder,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 300.w,
                                          height: 100.h,
                                          child: ReuseableText(
                                            title:
                                                "#${formatPrice(order!.deliveryFee)}",
                                            style: TextStyle(
                                              color: Tcolor.Text,
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          TripTracker(
                            trip: order,
                          ),
                          SizedBox(
                            height: 40.h,
                          ),

                          if (order!.riderStatus != "OD")
                            Padding(
                                padding:
                                    EdgeInsets.only(left: 30.w, right: 30.w),
                                child: Obx(
                                  () => CustomButton(
                                      title: orderController.status.value ==
                                              "RA"
                                          ? "At the restaurant"
                                          : orderController.status.value == "AR"
                                              ? "To delivery point"
                                              : orderController.status.value ==
                                                      "TDP"
                                                  ? "At delivery point"
                                                  : orderController
                                                              .status.value ==
                                                          "ADP"
                                                      ? "Ready to deliver"
                                                      : "",
                                      showArrow: false,
                                      btnHeight: 70.h,
                                      btnColor: Tcolor.Primary_New,
                                      fontSize: 28.sp,
                                      textColor: Tcolor.Text,
                                      onTap: orderController.status.value ==
                                              "RA"
                                          ? () async {
                                              print("at restaurant");
                                              int? statusCode =
                                                  await orderController
                                                      .updateRiderStaus(
                                                          order!.id, "AR");
                                              if (statusCode == 200 &&
                                                  context.mounted) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Trips()));
                                              }
                                            }
                                          : orderController.status.value == "AR"
                                              ? () async {
                                                  print("To delivery point");
                                                  PayoutModel model = PayoutModel(
                                                      amount: order!.orderTotal,
                                                      accountBank:
                                                          restaurant!.bank,
                                                      accountNumber: restaurant!
                                                          .accountNumber,
                                                      full_name: restaurant!.accountName,
                                                      narration:
                                                          "payment for ${order!.orderItems[0].additives[0].foodTitle}");
                                                  final data =
                                                      payoutModelToJson(model);
                                                  PayoutResponseModel response =
                                                      await tripController
                                                          .restaurantPayout(
                                                              data);
                                                  if (response
                                                          .response.status ==
                                                      "success") {
                                                    int? statusCode =
                                                        await orderController
                                                            .updateRiderStaus(
                                                                order!.id,
                                                                "TDP");
                                                    if (statusCode == 200 &&
                                                        context.mounted) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Trips()));
                                                    }
                                                  }
                                                }
                                              : orderController.status.value ==
                                                      "TDP"
                                                  ? () async {
                                                      print(
                                                          "At delivery point");
                                                      int? statusCode =
                                                          await orderController
                                                              .updateRiderStaus(
                                                                  order!.id,
                                                                  "ADP");
                                                      if (statusCode == 200 &&
                                                          context.mounted) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Trips()));
                                                      }
                                                    }
                                                  : orderController
                                                              .status.value ==
                                                          "ADP"
                                                      ? () async {
                                                          print(
                                                              "Read to deliveer");
                                                              int? statusCode =
                                                          await orderController
                                                              .updateRiderStaus(
                                                                  order!.id,
                                                                  "OD");
                                                      if (statusCode == 200 &&
                                                          context.mounted) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Trips()));
                                                        }}
                                                      : null),
                                )),
                          SizedBox(
                            height: 40.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(() {
          if (orderController.isLoading) {
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5), // Dim background
                child: Center(
                  child: LottieBuilder.asset(
                    'assets/animation/loading_state.json', // Replace with your Lottie file path
                    width: 200.w,
                    height: 200.h,
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
