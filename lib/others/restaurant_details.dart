import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/models/single_restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class RestaurantDetails extends StatelessWidget {
  const RestaurantDetails({
    super.key,
    required this.orderRestaurant,
  });

  final SingleRestaurantModel? orderRestaurant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Row(
        children: [
          SizedBox(
            height: 100.h,
            width: 100.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.network(orderRestaurant!.logoUrl),
            ),
          ),
          SizedBox(
            width: 30.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReuseableText(
                title: orderRestaurant!.title,
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
                    rating: orderRestaurant!.rating,
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
                    title: "(${orderRestaurant!.ratingCount})",
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
    );
  }
}
