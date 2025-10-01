import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationTracker extends StatelessWidget {
  const VerificationTracker({super.key, required this.title, required this.color});
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Tcolor.White,
        border: Border.all(color: color)
      ),
      child: Center(child: ReuseableText(title: title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: color))),
    );
  }
}
