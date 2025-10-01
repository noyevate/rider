import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:rider/common/color_extension.dart';
import 'package:rider/common/custom_button.dart';
import 'package:rider/common/format_price.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/controllers/login_controllers.dart';
import 'package:rider/controllers/navigating_controller.dart';
import 'package:rider/controllers/order_controller.dart';
import 'package:rider/hooks/fetch_order_by_id.dart';
import 'package:rider/models/address_model.dart';
import 'package:rider/models/login_response_model.dart';
import 'package:rider/models/order_model.dart';
import 'package:rider/models/rider_rating.dart';
import 'package:rider/models/single_restaurant_model.dart';
import 'package:rider/others/broken_straight_line.dart';
import 'package:rider/others/order_notification_tracker.dart';
import 'package:rider/shimer/order_notification_shimer.dart';
import 'package:rider/views/auth/login/login_page.dart';
import 'package:rider/views/home/widget/map_route.dart';
import 'package:rider/views/home/widget/order_delivery_response.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/hompage_controller.dart';

class OrderNotificationPage extends HookWidget {
  const OrderNotificationPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    // ignore: unused_local_variable
    // LoginResponse? user;
    // final logingController = Get.put(LoginController());

    String? token = box.read('token');
    print("token is: ${box.read('token')}");
    print("the id: ${box.read('userId')}");
    // if (token != null) {
    //   user = logingController.getUserInfo();

    // }

    // if (token == null) {
    //   return const LoginPage();
    // }
    final homeController = Get.put(HomepageController());
    final controller = Get.put(OrderController());
    final riderId = box.read("userid");
    final navigationController = Get.put(NavigationController());

    final hookResult = useFetchSingleOrder(box.read("orderId"));
    final OrderModel? order = hookResult.data ?? null;
    final isLoading = hookResult.isLoading;
    final apiError = hookResult.error;

    final orderPayload = useState<OrderModel?>(null);
    final orderRestaurant = useState<SingleRestaurantModel?>(null);
    final orderDelivery = useState<AddressModel?>(null);
    final rating = useState<Rating?>(null);

    orderPayload.value = order;
    useEffect(() {
      if (orderPayload.value != null) {
        Future.microtask(() async {
          final restaurant = await homeController
              .fetchResturant(orderPayload.value!.restaurantId);
          orderRestaurant.value = restaurant;
        });
      }
      return null; // No cleanup needed
    }, [orderPayload.value]);

    useEffect(() {
      if (orderPayload.value != null) {
        Future.microtask(() async {
          final orderAddress = await homeController
              .fetchAddress(orderPayload.value!.deliveryAddress);
          orderDelivery.value = orderAddress;
        });
      }
      return null; // No cleanup needed
    }, [orderPayload.value]);

    useEffect(() {
      if (orderPayload.value != null) {
        Future.microtask(() async {
          final orderRating = await homeController.fetchRating(
              orderPayload.value!.id, orderPayload.value!.driverId);
          rating.value = orderRating;
        });
      }
      return null; // No cleanup needed
    }, [orderPayload.value]);

    return Scaffold(
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(130.h),
          child: Column(
            children: [
              SizedBox(
                height: 90.h,
              ),
              Container(
                padding: EdgeInsets.only(left: 20.w),
                height: 70.h,
                color: Tcolor.BACKGROUND_Regaular,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0, // Align the icon to the left
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          print("orderID storde:   ${box.read("orderId")}");
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
      body: order == null ? Center(
          child: ReuseableText(
                              title: "an error occured. ${box.read("orderId")}",
                              style: TextStyle(
                                color: Tcolor.TEXT_Placeholder,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
        ):SingleChildScrollView(
        child:  Column(children: [
          SingleChildScrollView(
            child: isLoading || homeController.isLoading || apiError != null
                ? Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: OrderNotificationShimer(),
                  )
                  
                : Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Container(
                      height: 1050.h,
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
                                      child: Image.network(
                                        orderRestaurant.value?.imageUrl ?? '',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              "assets/img/checkers.png");
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 30.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ReuseableText(
                                        title: orderRestaurant.value?.title ??
                                            "....",
                                        style: TextStyle(
                                          color: Tcolor.Text,
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
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
                                            rating:
                                                orderRestaurant.value?.rating ??
                                                    0.0,
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
                                            title:
                                                "(${orderRestaurant.value?.ratingCount ?? 0})",
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
                                              title: orderRestaurant
                                                      .value?.coords.address ??
                                                  "No Address Available",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                title: orderDelivery
                                                        .value
                                                        ?.address
                                                        .addressLine1 ??
                                                    "No Address Available",
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
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 30.w, right: 30.w),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ReuseableText(
                                                  title:
                                                      "What you are delivering",
                                                  style: TextStyle(
                                                    color:
                                                        Tcolor.TEXT_Placeholder,
                                                    fontSize: 22.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 250.w,
                                                  height: 100.h,
                                                  child: ReuseableText(
                                                    title: (order?.orderItems
                                                                    .isNotEmpty ==
                                                                true &&
                                                            order
                                                                    ?.orderItems[
                                                                        0]
                                                                    .additives
                                                                    .isNotEmpty ==
                                                                true)
                                                        ? (order!.orderItems[0]
                                                                    .numberOfPack <
                                                                2
                                                            ? "${order.orderItems[0].numberOfPack} pack of ${order.orderItems[0].additives[0].foodTitle}"
                                                            : "${order.orderItems[0].numberOfPack} packs of ${order.orderItems[0].additives[0].foodTitle}")
                                                        : "No Order Items Available",
                                                    style: TextStyle(
                                                      color: Tcolor.Text,
                                                      fontSize: 24.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.visible,
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
                                                    color:
                                                        Tcolor.TEXT_Placeholder,
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.visible,
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
                                    padding: EdgeInsets.only(
                                        left: 30.w, right: 30.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              title: order.customerPhone,
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
                                                      final Uri phoneUri =
                                                          Uri.parse(
                                                              "tel:${order.customerPhone}");
                                                      if (await canLaunchUrl(
                                                          phoneUri)) {
                                                        await launchUrl(
                                                            phoneUri);
                                                      } else {
                                                        print(
                                                            "Could not launch call");
                                                      }
                                                    }
                                                  : null,
                                              child: Image.asset(
                                                  "assets/img/call_image.png"),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20.h,
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 30.w, right: 30.w),
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
                                                    color:
                                                        Tcolor.TEXT_Placeholder,
                                                    fontSize: 22.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 250.w,
                                                  height: 100.h,
                                                  child: ReuseableText(
                                                    title: "Transfer",
                                                    style: TextStyle(
                                                      color: Tcolor.Text,
                                                      fontSize: 28.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.visible,
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
                                                    color:
                                                        Tcolor.TEXT_Placeholder,
                                                    fontSize: 22.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 300.w,
                                                  height: 100.h,
                                                  child: ReuseableText(
                                                    title:
                                                        "#${formatPrice(order.deliveryFee)}",
                                                    style: TextStyle(
                                                      color: Tcolor.Text,
                                                      fontSize: 24.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.visible,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  OrderNotificationTracker(
                                    order: order,
                                  ),

                                  SizedBox(
                                    height: 40.h,
                                  ),

                                  if (order.orderStatus == "Delivered" &&
                                      order.riderStatus == "OD" &&
                                      rating.value != null) ...[
                                    Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          RatingBarIndicator(
                                            itemCount: 5,
                                            rating: rating.value?.rating ?? 0.0,
                                            unratedColor: Color.fromRGBO(
                                                255, 184, 0, 0.41),
                                            itemSize: 26.sp,
                                            itemBuilder: (context, i) {
                                              return Icon(
                                                HeroiconsSolid.star,
                                                size: 20.sp,
                                                color: Tcolor.Primary_New,
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          ReuseableText(
                                            title:
                                                "(${rating.value?.rating ?? 0.0})",
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Tcolor.Text),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],

                                  if (order.riderStatus == "NRA") ...[
                                    if(orderDelivery.value != null && orderRestaurant.value != null )
                                    Center(
                                      child: Container(
                                        width: 210.w,
                                        height: 56.h,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(18.r),
                                          border: Border.all(
                                              color: Colors.transparent),
                                        ),
                                        child: Material(
                                          color: Colors
                                              .transparent, // Keeps the decoration color visible
                                          borderRadius:
                                              BorderRadius.circular(18.r),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(18.r),
                                            splashColor: const Color.fromARGB(
                                                255,
                                                218,
                                                213,
                                                213), // The dark shade effect
                                            highlightColor: Colors
                                                .black26, // Lighter highlight effect
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => MapRoute(
                                                    order: order,
                                                    orderDelivery: orderDelivery.value,
                                                    orderRestaurant:
                                                        orderRestaurant.value,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  ReuseableText(
                                                    title: "View Map Routes",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 24.sp,
                                                      color: Tcolor.Secondary_S1,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Container(
                                                    height: 2.h,
                                                    width: 180.w,
                                                    color: Tcolor.Secondary_S1,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    CustomButton(
                                      title: "Accept",
                                      showArrow: false,
                                      btnHeight: 70.h,
                                      btnColor: Tcolor.Primary_New,
                                      fontSize: 28.sp,
                                      textColor: Tcolor.Text,
                                      onTap: () async {
                                        if (token == null) {
                                          Get.snackbar(
                                            "Authentication Required",
                                            "log in to continue.",
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor:
                                                Colors.black.withOpacity(0.8),
                                            colorText: Colors.white,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: Get.width * 0.25,
                                                vertical: 20),
                                            borderRadius: 3,
                                            duration:
                                                const Duration(seconds: 10),
                                          );
                                          Get.to(() => const LoginPage());
                                        } else {
                                          var statusCode = await controller
                                              .acceptOrder(order.id, riderId);
                                          if (statusCode == 200) {
                                            showModalBottomSheet(
                                                // ignore: use_build_context_synchronously
                                                context: context,
                                                isScrollControlled:
                                                    true, // Allows full customization
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (context) {
                                                  return SizedBox(
                                                    child:
                                                        OrderDeliveryResponse(
                                                      onTap: () {
                                                        navigationController
                                                            .changeTab(
                                                                1); // Navigate to Trips tab
                                                      },
                                                      order: order,
                                                      orderDelivery:
                                                          orderDelivery.value,
                                                      orderRestaurant:
                                                          orderRestaurant.value,
                                                      src:
                                                          "assets/img/accepted_pickup.png",
                                                      text1:
                                                          "PICK UP CONFIRMED!",
                                                      text2:
                                                          "Proceed to pick up point to pick",
                                                      text3: "up the package",
                                                    ),
                                                  );
                                                });
                                          }
                                        }
                                      },
                                    )
                                  ]
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          )
        ]),
      ),
    );
  }
}
