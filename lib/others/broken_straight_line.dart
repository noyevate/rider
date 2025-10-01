import 'package:rider/common/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrokenStraightLine extends StatelessWidget {
  const BrokenStraightLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 13.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4.w,
            height: 5.w,
            color: Tcolor.TEXT_Placeholder,
          ),
          
          SizedBox(
            height: 5.h,
          ),
          Container(
            width: 4.w,
            height: 10.w,
            color: Tcolor.TEXT_Placeholder,
          ),
          SizedBox(
            height: 5.w,
          ),
          Container(
            width: 4.w,
            height: 10.w,
            color: Tcolor.TEXT_Placeholder,
          ),
          SizedBox(
            height: 5.w,
          ),
          Container(
            width: 4.w,
            height: 10.w,
            color: Tcolor.TEXT_Placeholder,
          ),
          SizedBox(
            height: 5.w,
          ),
          Container(
            width: 4.w,
            height: 10.w,
            color: Tcolor.TEXT_Placeholder,
          ),
          SizedBox(
            height: 5.w,
          ),
          Container(
            width: 4.w,
            height: 5.w,
            color: Tcolor.TEXT_Placeholder,
          ),
          
        ],
      ),
    );
  }
}
