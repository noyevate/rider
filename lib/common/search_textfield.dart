import 'package:rider/common/color_extension.dart';
import 'package:rider/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield(
      {super.key,
      this.height1,
      this.width1,
      this.controller,
      this.onChanged,
      this.onTap,
      required this.focusNode,
      this.styleColor});

  final double? height1;
  final double? width1;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final FocusNode focusNode;
  final Color? styleColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height1 ?? 104.h,
        width:  width,
        decoration: BoxDecoration(
          border: Border.all(color: Tcolor.TEXT_Placeholder, width: 0.5.w),
          color: Tcolor.White,
        ),
        child: TextField(
          enabled: true,
          controller: controller,
          cursorColor: Tcolor.Text,
          cursorHeight: 40.sp,
          cursorWidth: 0.5,
          onChanged: onChanged,
          focusNode: focusNode,
          style: TextStyle(
            fontSize: 28.sp,
            color: styleColor ?? Tcolor.TEXT_Body,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: "Search for nearby restaurant",
            hintStyle: TextStyle(
                color: Tcolor.TEXT_Placeholder,
                fontSize: 24.sp,
                fontWeight: FontWeight.w500),
            prefixIcon: Icon(
              HeroiconsMini.magnifyingGlass,
              size: 36.sp,
            ),
            contentPadding: EdgeInsets.only(left: 32.h, top: 30.sp),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
