import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/models/address_model.dart';
import 'package:rider/models/order_model.dart';
import 'package:rider/models/single_restaurant_model.dart';
import 'package:rider/others/order_details_body.dart';
import 'package:rider/views/home/home_page.dart';
import 'package:rider/views/home/widget/map_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

import '../../../controllers/order_controller.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails(
      {super.key,
      this.orderRestaurant,
      this.orderDelivery,
      required this.order});
  final SingleRestaurantModel? orderRestaurant;
  final AddressModel? orderDelivery;
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Tcolor.BACKGROUND_Regaular,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(150.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 90.h,
                  ),
                  SizedBox(
                    // padding: EdgeInsets.only(left: 30.w),
                    height: 70.h,
                    // color: Tcolor.BACKGROUND_Regaular,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 30.w, // Align the icon to the left
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage()
                          ));
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
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Column(
              children: [
                Container(
                  height: 930.h,
                  width: width,
                  decoration: BoxDecoration(
                      color: Tcolor.White,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: Tcolor.BORDER_Regular)),
                  child: OrderDetailsBody(
                      orderRestaurant: orderRestaurant,
                      orderDelivery: orderDelivery,
                      order: order),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  width: 210.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Material(
                    color: Colors.transparent, // Keeps the decoration color visible
                    borderRadius: BorderRadius.circular(18.r),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18.r),
                      splashColor: const Color.fromARGB(
                          255, 218, 213, 213), // The dark shade effect
                      highlightColor: Colors.black26, // Lighter highlight effect
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapRoute(
                              order: order,
                              orderDelivery: orderDelivery,
                              orderRestaurant: orderRestaurant,
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
              ],
            ),
          ),
        ),

        Obx(() {
          if (controller.isLoading) {
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5), // Dim background
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height *
                        0.5, // 50% of screen height
                    width: MediaQuery.of(context).size.width *
                        0.8, // 90% of screen width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 150.h,
                          ),
                          Image.asset("assets/img/processing.png"),
                          SizedBox(
                            height: 30.h,
                          ),
                          ReuseableText(
                            title: "Processing",
                            style: TextStyle(
                              color: Tcolor.Text,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // LottieBuilder.asset(
                  //   'assets/animation/loading_state.json', // Replace with your Lottie file path
                  //   width: 200.w,
                  //   height: 200.h,
                  // ),
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
