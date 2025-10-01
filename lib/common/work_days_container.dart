import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WorkdaySelection extends StatelessWidget {
  final String day; // Day to display (e.g., "Mon", "Tue", etc.)
  final RxList<String> selectedWorkdays; // Reactive list to track selected days

  const WorkdaySelection({
    required this.day,
    required this.selectedWorkdays,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () {
            if (selectedWorkdays.contains(day)) {
              selectedWorkdays.remove(day); // Deselect the day
            } else {
              selectedWorkdays.add(day); // Select the day
            }
          },
          child: Container(
            width: 180.w,
            height: 70.h,
            margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: selectedWorkdays.contains(day) ? Tcolor.PRIMARY_Button_color_2 : Tcolor.Secondary_Checkbox_icon,
                width: 1,
              ),
              color: selectedWorkdays.contains(day)
                  ? Tcolor.PRIMARY_Button_color_2
                  : null //Tcolor.Secondary_Checkbox_icon,
            ),
            child: Center(
              child: ReuseableText(
                title: day,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: selectedWorkdays.contains(day)
                      ? Tcolor.White
                      : Tcolor.Secondary_Checkbox_icon,
                ),
              ),
            ),
          ),
        ));
  }
}
