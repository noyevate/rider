import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 70.h,
          width: 70.w,
          decoration: BoxDecoration(
            color: Tcolor.BACKGROUND_Dark,
            borderRadius: BorderRadius.circular(60.r),
          ),
          child: Center(
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                HeroiconsOutline.arrowLeft,
                color: Tcolor.Text,
                size: 24.sp,
              ),
            ),
          ),
        ),
        SizedBox(width: 30.sp,),
        ReuseableText(
            title: title ?? "",
            style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.w500,
                color: Tcolor.Text)),
      ],
    );
  }
}
