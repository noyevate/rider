import 'package:flutter/material.dart';
import 'package:rider/common/color_extension.dart';
import 'package:rider/common/date_of_year.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:rider/controllers/order_controller.dart';
import 'package:rider/controllers/profile_controllers.dart';

class CustomAppBar extends StatelessWidget {
  final double rating;
  final int notificationCount;
  final String date;

  const CustomAppBar({
    Key? key,
    required this.rating,
    required this.notificationCount,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final orderController = Get.find<OrderController>();
    final controller = Get.put(ProfileController());
    var firstName = box.read("first_name");
    var userImageUrl = box.read("userImagUrl");
    var rating = box.read('rating');
     controller.userImageUrl_.value  = userImageUrl;

    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFD09603), Color(0xFFFFB800)],
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0.h,
            right: 90.w,
            child: Container(
              height: 150.h,
              width: 150.w,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFD09603), Color(0xFFFFB800)],
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(100.r))),
            ),
          ),
          Positioned(
            bottom: 150.h,
            right: 40.w,
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFD09603), Color(0xFFFFB800)],
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(100.r))),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80.h),
              // Date

              Padding(
                padding: EdgeInsets.only(left: 32.w, right: 20.w),
                child: Row(
                  children: [
                    Icon(
                      HeroiconsMini.calendar,
                      size: 32.sp,
                      color: Tcolor.White,
                    ),
                    ReuseableText(
                      title: getFormattedDate(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Divider(
                color: Color.fromARGB(255, 200, 200, 148),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 32.w, right: 20.w),
                    child: Row(
                      children: [
                        // Profile Picture
                        Container(
                            height: 95.h,
                            width: 102.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Stack(
                              children: [
                                Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      print(controller.userImageUrl_.value);
                                    },
                                    child: SizedBox(
                                      height: 90.h,
                                      width: 95.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10.r),
                                        child: Image.network(
                                          controller.userImageUrl_.value,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[
                                                  300], // Background color for placeholder
                                              child: Icon(Icons.person,
                                                  size: 40,
                                                  color: Color(
                                                      0xFFD09603)), // Fallback icon
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 16.h,
                                    width: 16.w,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReuseableText(
                                  title: "Hi, ${firstName}",
                                  style: TextStyle(
                                    color: Tcolor.Text,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Image.asset(
                                  "assets/img/motot_helment.png",
                                  height: 25.h,
                                  width: 30.w,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            RatingBarIndicator(
                              itemCount: 5,
                              rating: rating,
                              unratedColor: Tcolor.TEXT_Placeholder,
                              itemSize: 26.sp,
                              itemBuilder: (context, i) {
                                return Icon(
                                  HeroiconsSolid.star,
                                  size: 24.sp,
                                  color: Tcolor.White,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 35.w),
                    child: Column(
                      children: [
                        // SizedBox(height: 200.h),
                        Container(
                          height: 90.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color.fromARGB(
                                        122, 251, 251, 251),
                                    blurRadius: 0.5)
                              ]),
                          child: Center(
                            child: Stack(
                              children: [
                                Image.asset("assets/img/Vector.png"),
                                Positioned(
                                    bottom: 25.h,
                                    left: 20.w,
                                    child: Container(
                                      height: 25.h,
                                      width: 25.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromRGBO(255, 53, 46, 1)),
                                      child: Obx(
                                        () => Center(
                                          child: ReuseableText(
                                            title: orderController
                                                .totalOrder.value
                                                .toString(),
                                            style: TextStyle(
                                              color: Tcolor.White,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//   Positioned(
        //     bottom: 0.h,
        //     right: 90.w,
        //     child: Container(
        //       height: 150.h,
        //       width: 150.w,
        //       decoration: BoxDecoration(
        //         gradient: LinearGradient(
        //   colors: [Color(0xFFD09603), Color(0xFFFFB800)],
        //   begin: Alignment.topLeft,
        //   end: Alignment.centerRight,
        // ),
        // borderRadius: BorderRadius.all(Radius.circular(100.r))                

        //       ),
        //     ),
        //   ),
