
import 'package:rider/common/color_extension.dart';
import 'package:rider/controllers/password_contrroller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key, this.onEditingComplete, this.initialValue, this.controller, this.prefixIcon, this.color, this.suffixIcon});
  final void Function()? onEditingComplete;
  final String? initialValue;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Color? color;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final passwordController = Get.put(PasswordController());
    return Obx(() => TextFormField(
      cursorColor: Tcolor.Text,
      textInputAction: TextInputAction.next,
      onEditingComplete: onEditingComplete,
      keyboardType: TextInputType.visiblePassword,
      initialValue: initialValue,
      obscureText: passwordController.password,
      controller: controller,
      validator: (value) {
        if(value!.isEmpty) {
          return "Enter a valid Password";
        } else {
          return null;
        }
      },
      style: TextStyle(color: Tcolor.TEXT_Body, fontWeight: FontWeight.w500, fontSize: 28.sp),
      decoration: InputDecoration(
        hintText: "********",
        prefixIcon: prefixIcon,
        isDense: true,
        // contentPadding: EdgeInsets.all(12.h),
        suffixIcon: suffixIcon,
          
          fillColor: Tcolor.BACKGROUND_Regaular,
          filled: true,
          
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 15.r,
          ),
          hintStyle: TextStyle(
            color: color ?? Tcolor.TEXT_Placeholder,
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
          ),


      ),
    )
    );
  }
}