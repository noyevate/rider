import 'package:get/get.dart';
import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/controllers/order_controller.dart';
import 'package:rider/models/address_model.dart';
import 'package:rider/models/order_model.dart';
import 'package:rider/models/single_restaurant_model.dart';
import 'package:rider/views/home/home_page.dart';
import 'package:rider/views/home/widget/map_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

// class OrderDeliveryResponse extends StatelessWidget {
//   const OrderDeliveryResponse({
//     super.key,
//     this.orderRestaurant,
//     this.orderDelivery,
//     required this.order,
//     required this.src,
//     required this.text1,
//     required this.text2,
//     required this.text3,
//   });

//   final SingleRestaurantModel? orderRestaurant;
//   final AddressModel? orderDelivery;
//   final OrderModel order;
//   final String src;
//   final String text1;
//   final String text2;
//   final String text3;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 3,
//             offset: Offset(0, 4),
//             spreadRadius: 3,
//             blurStyle: BlurStyle.solid,
//           ),
//         ],
//         color: Colors.transparent,
//       ),
//       child: Stack(
//         children: [
//           // Close Button Positioned Correctly
//           Positioned(
//             top: 80.h,
//             left: 30.w,
//             child: GestureDetector(
//               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),),),
//               child: Container(
//                 height: 62.h,
//                 width: 62.w,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Tcolor.White,
//                 ),
//                 child: Icon(
//                   HeroiconsMini.xMark,
//                   color: Tcolor.Text,
//                   size: 40.sp,
//                 ),
//               ),
//             ),
//           ),

//           // Centered Card
//           Align(
//             alignment: Alignment.center,
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
//               height: MediaQuery.of(context).size.height * 0.5, // 50% of screen height
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10,
//                     offset: Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     src,
//                     height: 256.h,
//                     width: 256.w,
//                   ),
//                   SizedBox(height: 40.h),
//                   ReuseableText(
//                     title: text1,
//                     style: TextStyle(
//                       color: Tcolor.Text,
//                       fontSize: 36.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   SizedBox(height: 20.h),
//                   ReuseableText(
//                     title: text2,
//                     style: TextStyle(
//                       color: Tcolor.Location_sheet_color,
//                       fontSize: 25.sp,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   ReuseableText(
//                     title: text3,
//                     style: TextStyle(
//                       color: Tcolor.Location_sheet_color,
//                       fontSize: 25.sp,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   SizedBox(height: 40.h),

//                   // Conditional Button
//                   orderRestaurant != null
//                       ? _viewMapButton(context)
//                       : _backToHomeButton(context),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Extracted Widgets
//   Widget _viewMapButton(BuildContext context) {
//     return Container(
//       width: 210.w,
//       height: 56.h,
//       decoration: BoxDecoration(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(18.r),
//         border: Border.all(color: Colors.transparent),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(18.r),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(18.r),
//           splashColor: Color.fromARGB(255, 218, 213, 213),
//           highlightColor: Colors.black26,
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => MapRoute(
//                   order: order,
//                   orderDelivery: orderDelivery,
//                   orderRestaurant: orderRestaurant,
//                 ),
//               ),
//             );
//           },
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ReuseableText(
//                 title: "View Map Routes",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 24.sp,
//                   color: Tcolor.Secondary_S1,
//                 ),
//               ),
//               SizedBox(height: 10.h),
//               Container(
//                 height: 2.h,
//                 width: 180.w,
//                 color: Tcolor.Secondary_S1,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _backToHomeButton(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//       },
//       child: Container(
//         height: 66.h,
//         width: 176.w,
//         decoration: BoxDecoration(
//           color: Color(0xffD9D9D9),
//           borderRadius: BorderRadius.circular(10.r),
//         ),
//         child: Center(
//           child: ReuseableText(
//             title: "BACK TO HOME",
//             style: TextStyle(
//               color: Tcolor.Text,
//               fontSize: 22.sp,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class OrderDeliveryResponse extends StatelessWidget {
  const OrderDeliveryResponse(
      {super.key,
      this.orderRestaurant,
      this.orderDelivery,
      required this.order,
      required this.src,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.onTap});

  final SingleRestaurantModel? orderRestaurant;
  final AddressModel? orderDelivery;
  final OrderModel order;
  final String src;
  final String text1;
  final String text2;
  final String text3;
  final  VoidCallback  onTap;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 3,
              offset: Offset(0, 4),
              spreadRadius: 3,
              blurStyle: BlurStyle.solid),
        ],
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          Positioned(
            left: 30.w, // Align the icon to the left with padding
            top: 80.h, // Maintain the top padding
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                height: 62.h,
                width: 62.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Tcolor.White,
                ),
                child: Icon(
                  HeroiconsMini.xMark,
                  color: Tcolor.Text,
                  size: 40.sp,
                ),
              ),
            ),
          ),
          Center(
              child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.8, // 90% of screen width
                  height: MediaQuery.of(context).size.height *
                      0.5, // 50% of screen height
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
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60.h,
                      ),
                      Image.asset(
                        src,
                        height: 256.h,
                        width: 256.w,
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      ReuseableText(
                        title: text1,
                        style: TextStyle(
                          color: Tcolor.Text,
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      ReuseableText(
                        title: text2,
                        style: TextStyle(
                          color: Tcolor.Location_sheet_color,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      ReuseableText(
                        title: text3,
                        style: TextStyle(
                          color: Tcolor.Location_sheet_color,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      if (orderRestaurant != null)
                        Container(
                          width: 210.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(18.r),
                            border: Border.all(color: Colors.transparent),
                          ),
                          child: Material(
                            color: Colors
                                .transparent, // Keeps the decoration color visible
                            borderRadius: BorderRadius.circular(18.r),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(18.r),
                              splashColor: const Color.fromARGB(
                                  255, 218, 213, 213), // The dark shade effect
                              highlightColor:
                                  Colors.black26, // Lighter highlight effect
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
                      if (orderRestaurant == null)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          },
                          child: Container(
                            height: 66.h,
                            width: 176.w,
                            decoration: BoxDecoration(
                                color: Color(0xffD9D9D9),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Center(
                              child: ReuseableText(
                                title: "BACK TO HOME",
                                style: TextStyle(
                                  color: Tcolor.Text,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                  ))),
        ],
      ),
    );
  }
}
