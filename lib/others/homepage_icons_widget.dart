import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomepageIconsWidget extends StatelessWidget {
  const HomepageIconsWidget({
    super.key, required this.imagePath, required this.title1, this.height1, this.width1, required this.color1, 
  });

  final String imagePath;
  final String title1;
  final double? height1;
  final double? width1;
  final Color color1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensures the column takes only required space
      mainAxisAlignment: MainAxisAlignment.center, // Align items in the center
      crossAxisAlignment: CrossAxisAlignment.center, // Align children horizontally in the center
      children: [
        Container(
          height: 120.h,
          width: 120.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color1,
          ),
          child: Center(
            child: Image.asset(
              imagePath,
              height: height1,
              width: width1,

            ),
          ),
        ),
        SizedBox(height: 10.h), // Add spacing between the image and text
        ReuseableText(
          title: title1, 
          style: TextStyle(color: Tcolor.TEXT_Body, fontSize: 28.sp, fontWeight: FontWeight.w500),
        ), 
      ],
    );
  }
}
