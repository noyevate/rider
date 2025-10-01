import 'package:rider/common/color_extension.dart';
import 'package:rider/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget(
      {super.key,
      this.controller,
      this.hintText,
      this.prefix,
      this.keyboardType,
      this.height,
      this.width1,
      this.suffixIcon,
      this.color,
      this.prefixIcon,
      this.onChanged,
      required this.borderColor,
      this.fillColor,
      required this.obscureText,
      this.hintFontSize, this.hintStyle, this.hintColor, this.hintFontWeight, this.cursorHeight, this.cursorColor, required this.readOnly, this.styleColor,
      });

  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final double? height;
  final double? width1;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;

  final Color? color;
  final Color borderColor;
  final Color? fillColor;
  final bool obscureText;

  final double? hintFontSize;
  final TextStyle? hintStyle;
  final Color? hintColor;
  final FontWeight? hintFontWeight;
  final double? cursorHeight;
  final Color? cursorColor;
  final Color? styleColor;
  final bool readOnly;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 90.h,
      width: width1 ?? width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Tcolor.BACKGROUND_Regaular),
        color: Tcolor.BACKGROUND_Regaular,
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        obscureText: obscureText,
        cursorHeight: cursorHeight,
        cursorColor: cursorColor,
        readOnly: readOnly,
        style: TextStyle(
          fontSize: 28.sp,
          color: styleColor ?? Tcolor.TEXT_Body,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: hintFontSize,
            color: hintColor ?? Tcolor.TEXT_Placeholder,
            fontWeight: hintFontWeight,
          ),
          fillColor: fillColor ?? Tcolor.BACKGROUND_Regaular,
          filled: true,
          prefix: prefix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 15.r,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Tcolor.ERROR_Reg,
              width: .5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
              width: .5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
              width: .5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
          ),
        ),
      ),
    );
  }
}
