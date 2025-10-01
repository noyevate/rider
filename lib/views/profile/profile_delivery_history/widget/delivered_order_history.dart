import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/others/broken_straight_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class DeliveredOrderHistory extends StatelessWidget {
  const DeliveredOrderHistory({super.key});

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
            SingleChildScrollView(
              child: Container(
                height: 930.h,
                width: width,
                decoration: BoxDecoration(
                    color: Tcolor.White,
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(color: Tcolor.BORDER_Regular)),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 100.h,
                            width: 100.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.r),
                              child: Image.asset(
                                "assets/img/test_image_chicken_republic.png",
                                height: 20.h,
                                width: 20.h,
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
                                title: "Chicken Republic, Ikeja Lagos",
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
                                    rating: 4,
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
                                    title: "(${40})",
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
                      height: 10.h,
                    ),
                    Divider(
                      color: Tcolor.Location_Text_Sheet_colour,
                      thickness: 0.5.sp,
                    ),
                    SizedBox(
                      height: 10.h,
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
                                      title: "Chicken Republic, Ikeja Lagos",
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
                                        title:
                                            "21b, Kotun Street, victoria Island",
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      title:
                                          "2 plates of fried rice and chicken",
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      title: "Kamaru Usman",
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
                                title: "0801 234 5678",
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
                              Image.asset("assets/img/call_image.png")
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
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      title: "Cash",
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      title: "#1000.00",
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
                          //   height: 100.h,
                          
                        ],
                      ),
                    ),
                    // 
                    // 
                    // 
                    // 

                    Padding(
                          padding: EdgeInsets.only(left: 30.w, right: 30.w),
                          child: Row(children: [
                            Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Tcolor.Secondary_S1),
                              child: Center(
                                child: Image.asset(
                                    "assets/img/enroute_to_restaurant_active.png"),
                              ),
                            ),
                            Container(
                              height: 2.h,
                              width: 80.w,
                              decoration:
                                  BoxDecoration(color: Tcolor.Secondary_S1),
                            ),
                            Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Tcolor.Secondary_S1),
                              child: Center(
                                child: Image.asset(
                                    "assets/img/restaurant_active.png"),
                              ),
                            ),
                            Container(
                              height: 2.h,
                              width: 80.w,
                              decoration:
                                  BoxDecoration(color: Tcolor.Secondary_S1),
                            ),
                            Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Tcolor.Secondary_S1),
                              child: Center(
                                child: Center(
                                    child: Icon(
                                  HeroiconsMini.mapPin,
                                  color: Tcolor.White,
                                  size: 30.sp,
                                )),
                              ),
                            ),
                            Container(
                              height: 2.h,
                              width: 80.w,
                              decoration:
                                  BoxDecoration(color: Tcolor.Secondary_S1),
                            ),
                            Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Tcolor.Secondary_S1),
                              child: Center(
                                child: Center(
                                    child: Image.asset(
                                        "assets/img/money_active.png")),
                              ),
                            ),
                            Container(
                              height: 2.h,
                              width: 80.w,
                              decoration:
                                  BoxDecoration(color: Tcolor.TEXT_Placeholder),
                            ),
                            Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Color(0xff3AA803)),
                              child: Center(
                                child: Center(
                                    child: Icon(
                                  HeroiconsMini.check,
                                  color: Tcolor.White,
                                  size: 30.sp,
                                )),
                              ),
                            ),
                          ]),
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
