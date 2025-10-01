import 'package:rider/common/color_extension.dart';
import 'package:rider/models/current_trip_order_model.dart';
import 'package:rider/models/order_model.dart';
import 'package:rider/models/trip_history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class TripHistorRiderStatusTracker extends StatelessWidget {
  const TripHistorRiderStatusTracker({
    super.key, required this.trip
  });
  final TripHistoryModel trip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Row(children: [
        Container(
          height: 50.h,
          width: 50.w,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Tcolor.Secondary_S1),
          child: Center(
            child: Image.asset("assets/img/enroute_to_restaurant_active.png"),
          ),
        ),


        Container(
          height: 2.h,
          width: 80.w,
          decoration: BoxDecoration(
            color: trip!.riderStatus == "RA" || trip!.riderStatus == "AR" || trip!.riderStatus == "TDP" || trip!.riderStatus == "ADP" || trip!.riderStatus == "OD"
                  ? Tcolor.Secondary_S1
                  : Tcolor.Order_Tracking_Background_color
          ),
        ),
        Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: trip!.riderStatus == "AR" || trip!.riderStatus == "TDP" || trip!.riderStatus == "ADP" || trip!.riderStatus == "OD"
                  ? Tcolor.Secondary_S1
                  : Tcolor.Order_Tracking_Background_color
              ),
          child: Center(
            child: Image.asset(
              "assets/img/restaurant_inactive.png",
              color: trip!.riderStatus == "AR" || trip!.riderStatus == "TDP" || trip!.riderStatus == "ADP" || trip!.riderStatus == "OD"
                  ? Tcolor.White
                  : Tcolor.TEXT_Placeholder,
            ),
          ),
        ),



        Container(
          height: 2.h,
          width: 80.w,
          decoration: BoxDecoration(
            color: trip!.riderStatus == "TDP" || trip!.riderStatus == "ADP" || trip!.riderStatus == "OD"
                  ? Tcolor.Secondary_S1
                  :  Tcolor.TEXT_Placeholder,
          ),
        ),
        Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: trip!.riderStatus == "ADP" || trip!.riderStatus == "OD"
                  ? Tcolor.Secondary_S1
                  : Tcolor.Order_Tracking_Background_color),
          child: Center(
            child: Center(
                child: Icon(
              HeroiconsMini.mapPin,
              color: trip!.riderStatus == "ADP" || trip!.riderStatus == "OD"
                  ? Tcolor.White
                  :
              Tcolor.Order_Tracking_color,
              size: 30.sp,
            )),
          ),
        ),




        Container(
          height: 2.h,
          width: 80.w,
          decoration: BoxDecoration(
            color: trip!.riderStatus == "OD"
                  ? Tcolor.Secondary_S1
                  :Tcolor.TEXT_Placeholder
          ),
        ),
        Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: trip!.riderStatus == "OD"
                  ? Tcolor.Secondary_S1
                  : Tcolor.Order_Tracking_Background_color),
          child: Center(
            child: Center(child: Image.asset("assets/img/money_inactive.png",
            color: trip!.riderStatus == "OD"
                  ? Tcolor.White
                  :
              Tcolor.Order_Tracking_color, 
            ),
            ),
          ),
        ),



        Container(
          height: 2.h,
          width: 80.w,
          decoration: BoxDecoration(
            color: trip!.riderStatus == "OD"
                  ? Tcolor.Secondary_S1
                  : Tcolor.Order_Tracking_Background_color
            ),
        ),
        Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: trip!.riderStatus == "OD" ? Color(0xff3AA803) : Tcolor.Order_Tracking_Background_color),
          child: Center(
            child: Center(
                child: Icon(
              HeroiconsMini.check,
              color: trip!.riderStatus == "OD"
                  ? Tcolor.White
                  :  Tcolor.Order_Tracking_color,
              size: 30.sp,
            )),
          ),
        ),
      ]),
    );
  }
}
