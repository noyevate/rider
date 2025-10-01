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

class OrderDetails1 extends StatelessWidget {
  const OrderDetails1(
      {super.key,
      this.orderRestaurant,
      this.orderDelivery,
      required this.order});
  final SingleRestaurantModel? orderRestaurant;
  final AddressModel? orderDelivery;
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.h),
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
    );
  }
}
