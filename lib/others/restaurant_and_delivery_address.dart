import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/models/address_model.dart';
import 'package:rider/models/single_restaurant_model.dart';
import 'package:rider/others/broken_straight_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class RestaurntAndDeliveryAddress extends StatelessWidget {
  const RestaurntAndDeliveryAddress({
    super.key,
    required this.orderRestaurant,
    required this.orderDelivery,
  });

  final SingleRestaurantModel? orderRestaurant;
  final AddressModel? orderDelivery;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      title: orderRestaurant!.coords.address,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        title: orderDelivery!.address.addressLine1,
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
          SizedBox(height: 100.h,)
    
        ],
      ),
    );
  }
}
