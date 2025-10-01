import 'package:rider/common/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String) onChanged;
  final bool isError;

  const OTPField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w, // Adjusted width for better spacing with four fields
      height: 70.h, // Adjusted height for better spacing with four fields
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.phone,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 32.sp,
          color: isError ? Tcolor.ERROR_Reg : Tcolor.TEXT_Body,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Tcolor.BACKGROUND_Regaular,
          counterText: '',
          contentPadding: EdgeInsets.symmetric(vertical: 15.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color:  Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color:  Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color:  Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
