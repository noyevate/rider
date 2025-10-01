import 'package:rider/common/color_extension.dart';
import 'package:rider/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class OrderNotificationTracker extends StatelessWidget {
  const OrderNotificationTracker({
    super.key,
    required this.order,
  });
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Row(children: [
        Expanded(
          child: Row(
            children: [
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: order.riderStatus =="NRA" ? Tcolor.Order_Tracking_Background_color : Tcolor.Secondary_S1),
                child: Center(
                  child: Image.asset(
                      "assets/img/enroute_to_restaurant_active.png"),
                ),
              ),
              Expanded(
                child: Container(
                  height: 2.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                      color: 
                      order.riderStatus == "RA" ||
                              order.riderStatus == "AR" ||
                              order.riderStatus == "TDP" ||
                              order.riderStatus == "ADP" ||
                              order.riderStatus == "OD"
                          ? Tcolor.Secondary_S1
                          : Tcolor.Order_Tracking_Background_color),
                ),
              ),
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: order.riderStatus == "AR" ||
                            order.riderStatus == "TDP" ||
                            order.riderStatus == "ADP" ||
                            order.riderStatus == "OD"
                        ? Tcolor.Secondary_S1
                        : Tcolor.Order_Tracking_Background_color),
                child: Center(
                  child: Image.asset(
                    "assets/img/restaurant_inactive.png",
                    color: order.riderStatus == "AR" ||
                            order.riderStatus == "TDP" ||
                            order.riderStatus == "ADP" ||
                            order.riderStatus == "OD"
                        ? Tcolor.White
                        : Tcolor.TEXT_Placeholder,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 2.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: order.riderStatus == "TDP" ||
                            order.riderStatus == "ADP" ||
                            order.riderStatus == "OD"
                        ? Tcolor.Secondary_S1
                        : Tcolor.TEXT_Placeholder,
                  ),
                ),
              ),
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        order.riderStatus == "ADP" || order.riderStatus == "OD"
                            ? Tcolor.Secondary_S1
                            : Tcolor.Order_Tracking_Background_color),
                child: Center(
                  child: Center(
                      child: Icon(
                    HeroiconsMini.mapPin,
                    color:
                        order.riderStatus == "ADP" || order.riderStatus == "OD"
                            ? Tcolor.White
                            : Tcolor.Order_Tracking_color,
                    size: 30.sp,
                  )),
                ),
              ),
              Expanded(
                child: Container(
                  height: 2.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                      color: order.riderStatus == "OD"
                          ? Tcolor.Secondary_S1
                          : Tcolor.TEXT_Placeholder),
                ),
              ),
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: order.riderStatus == "OD"
                        ? Tcolor.Secondary_S1
                        : Tcolor.Order_Tracking_Background_color),
                child: Center(
                  child: Center(
                    child: Image.asset(
                      "assets/img/money_inactive.png",
                      color: order.riderStatus == "OD"
                          ? Tcolor.White
                          : Tcolor.Order_Tracking_color,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 2.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                      color: order.riderStatus == "OD"
                          ? Tcolor.Secondary_S1
                          : Tcolor.Order_Tracking_Background_color),
                ),
              ),
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: order.riderStatus == "OD"
                        ? Color(0xff3AA803)
                        : Tcolor.Order_Tracking_Background_color),
                child: Center(
                  child: Center(
                      child: Icon(
                    HeroiconsMini.check,
                    color: order.riderStatus == "OD"
                        ? Tcolor.White
                        : Tcolor.Order_Tracking_color,
                    size: 30.sp,
                  )),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
