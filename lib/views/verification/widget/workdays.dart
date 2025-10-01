// ignore_for_file: invalid_use_of_protected_member

import 'package:rider/common/color_extension.dart';
import 'package:rider/common/custom_button.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/common/verification_tracker.dart';
import 'package:rider/common/work_days_container.dart';
import 'package:rider/controllers/verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WorkDays extends StatelessWidget {
  const WorkDays({super.key, required this.back, required this.next});

  final Function back;
  final Function next;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerificationController());
    return SizedBox(
        height: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 60.h),
          ReuseableText(
            title: "Choose Work Days",
            style: TextStyle(
              color: Tcolor.Text,
              fontSize: 40.sp,
              fontWeight: FontWeight.w600,
              wordSpacing: 2.sp,
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Container(
                  height: 370.h,
                  width: width,
                  decoration: BoxDecoration(
                      color: Tcolor.Secondary_Work_Days,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      ReuseableText(
                        title: "Morning Shifts (8:00am - 2:00pm)",
                        style: TextStyle(
                          color: Tcolor.Text,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w500,
                          wordSpacing: 2.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      ReuseableText(
                        title:
                            "Choose what days you’d like to work in the morning",
                        style: TextStyle(
                          color: Tcolor.Text,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                          wordSpacing: 2.sp,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Padding(
                        padding: EdgeInsets.only(right: 20.w, left: 20.w),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WorkdaySelection(
                                    day: "Monday",
                                    selectedWorkdays:
                                        controller.selectedWorkdaysMorning),
                                WorkdaySelection(
                                    day: "Tuesday",
                                    selectedWorkdays:
                                        controller.selectedWorkdaysMorning),
                                WorkdaySelection(
                                    day: "Wednessday",
                                    selectedWorkdays:
                                        controller.selectedWorkdaysMorning),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WorkdaySelection(
                                    day: "Thursday",
                                    selectedWorkdays:
                                        controller.selectedWorkdaysMorning),
                                WorkdaySelection(
                                    day: "Friday",
                                    selectedWorkdays:
                                        controller.selectedWorkdaysMorning),
                                WorkdaySelection(
                                    day: "Saturday",
                                    selectedWorkdays:
                                        controller.selectedWorkdaysMorning),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WorkdaySelection(
                                    day: "Sunday",
                                    selectedWorkdays:
                                        controller.selectedWorkdaysMorning),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 50.h),
                Container(
                  height: 370.h,
                  width: width,
                  decoration: BoxDecoration(
                      color: Tcolor.Secondary_Work_Days,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      ReuseableText(
                        title: "Evening Shifts (2:00pm - 9:00pm)",
                        style: TextStyle(
                          color: Tcolor.Text,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w500,
                          wordSpacing: 2.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      ReuseableText(
                        title:
                            "Choose what days you’d like to work in the evening",
                        style: TextStyle(
                          color: Tcolor.Text,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                          wordSpacing: 2.sp,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Padding(
                        padding: EdgeInsets.only(right: 20.w, left: 20.w),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WorkdaySelection(
                                    day: "Monday",
                                    selectedWorkdays:
                                        controller.selectedWorkdaysEvening),
                                WorkdaySelection(
                                    day: "Tuesday",
                                    selectedWorkdays:
                                        controller.selectedWorkdaysEvening),
                                WorkdaySelection(
                                    day: "Wednessday",
                                    selectedWorkdays:
                                        controller.selectedWorkdaysEvening),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WorkdaySelection(
                                    day: "Thursday",
                                    selectedWorkdays:
                                        controller.selectedWorkdaysEvening),
                                WorkdaySelection(
                                    day: "Friday",
                                    selectedWorkdays:
                                        controller.selectedWorkdaysEvening),
                                WorkdaySelection(
                                    day: "Saturday",
                                    selectedWorkdays:
                                        controller.selectedWorkdaysEvening),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WorkdaySelection(
                                    day: "Sunday",
                                    selectedWorkdays:
                                        controller.selectedWorkdaysEvening),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
            height: 40.h,
          ),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      VerificationTracker(
                        title: '1',
                        color: Tcolor.Secondary_Checkbox_icon,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      VerificationTracker(
                        title: '2',
                        color: Tcolor.Secondary_Checkbox_icon,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      VerificationTracker(
                        title: '3',
                        color: Tcolor.Primary_Checkbox_icon,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      VerificationTracker(
                        title: '4',
                        color: Tcolor.Secondary_Checkbox_icon,
                      ),
                    ],
                  ),
                ),
                SizedBox(
            height: 40.h,
          ),

          Obx(() => CustomButton(
                  title: "Continue",
                  textColor: Tcolor.Text,
                  btnColor: controller.selectedWorkdaysEvening.isNotEmpty || controller.selectedWorkdaysMorning.isNotEmpty
                      ? Tcolor.PRIMARY_Button_color_2
                      : Tcolor.PRIMARY_Button_Disabled,
                  btnWidth: MediaQuery.of(context).size.width / 1.1,
                  btnHeight: 90.h,
                  raduis: 100.r,
                  fontSize: 32.sp,
                  showArrow: false,
                  onTap: controller.selectedWorkdaysEvening.isNotEmpty || controller.selectedWorkdaysMorning.isNotEmpty ?() {
                    next();
                     
                  } : null,
                ))
                
              ],
            ),
          ),)
        ]),
        );
  }
}
