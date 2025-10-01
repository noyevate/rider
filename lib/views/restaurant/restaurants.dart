import 'package:rider/common/color_extension.dart';
import 'package:rider/common/custom_appbar.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/views/restaurant/widget/nearby_restaurant_list.dart';
import 'package:rider/views/restaurant/widget/popular_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Restaurants extends StatelessWidget {
  const Restaurants({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(224.h),
          child: const CustomAppBar(
            rating: 5.5,
            notificationCount: 3,
            date: '',
          )),
      body: SizedBox(
        width: double.infinity,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize
                    .min, // Ensures the Row takes only necessary space
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReuseableText(
                    title: "Restaurants",
                    style: TextStyle(
                      fontSize: 33.sp,
                      fontWeight: FontWeight.w600,
                      color: Tcolor.TEXT_Body,
                    ),
                  ),
                  Image.asset(
                    "assets/img/icon_black_restaurant.png",
                    height: 30.h,
                    width: 30.w,
                    
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const PopularRestaurant(),
                 
                  
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
