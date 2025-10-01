import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/views/profile/profile_delivery_history/widget/delivered_order_history.dart';
import 'package:rider/views/trips/widget/subwidgets/trip_history_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class ProfileDeliveryHistory extends StatelessWidget {
  const ProfileDeliveryHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.h),
        child: Column(
          children: [
            SizedBox(
              height: 60.h,
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
                      title: "Delivery History",
                      style: TextStyle(
                        color: Tcolor.Text,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: Container(
        color: Tcolor.White,
        height: height,
        width: width,
        padding:
                  EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ReuseableText(
                      title: "History",
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500,
                          color: Tcolor.Text)),
                  SizedBox(
                    width: 10.w,
                  ),
                  Icon(
                    MaterialIcons.history,
                    color: Tcolor.Text,
                    size: 35.sp,
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              TripHistoryList(),

           
              //
            ],
          ),
        ),
      ),
    );
  }
}

// class DeliveryHistoryTile extends StatelessWidget {
//   const DeliveryHistoryTile({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => DeliveredOrderHistory(),
//           ),
//         );
//       },
//       highlightColor: Colors.black26,
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ReuseableText(
//                       title: "Delivery to Ikeja from Chicken republic ",
//                       style: TextStyle(
//                           fontSize: 22.sp,
//                           fontWeight: FontWeight.w500,
//                           color: Tcolor.Text),
//                     ),
//                     Row(
//                       children: [
//                         RatingBarIndicator(
//                           itemCount: 5,
//                           rating: 4,
//                           unratedColor: Tcolor.TEXT_Placeholder,
//                           itemSize: 26.sp,
//                           itemBuilder: (context, i) {
//                             return Icon(
//                               HeroiconsSolid.star,
//                               size: 20.sp,
//                               color: Tcolor.Primary_New,
//                             );
//                           },
//                         ),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         ReuseableText(
//                           title: "(3.0)",
//                           style: TextStyle(
//                               fontSize: 20.sp,
//                               fontWeight: FontWeight.w500,
//                               color: Tcolor.Text),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Row(
//                   children: [
//                     Row(
//                       children: [
//                         Icon(
//                           HeroiconsMini.calendar,
//                           color: Color(0xff545454),
//                           size: 20.sp,
//                           weight: 10,
//                         ),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         ReuseableText(
//                           title: "27th, January 2024",
//                           style: TextStyle(
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xff545454)),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       width: 10.w,
//                     ),
//                     Row(
//                       children: [
//                         Icon(
//                           HeroiconsOutline.clock,
//                           color: Color(0xff545454),
//                           size: 18.sp,
//                           weight: 10,
//                         ),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         ReuseableText(
//                           title: "3:00pm - 3:30pm",
//                           style: TextStyle(
//                               fontSize: 20.sp,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xff545454)),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Divider(color: Tcolor.Location_Text_Sheet_colour, thickness: 0.5.sp),
//         ],
//       ),
//     );
//   }
// }
