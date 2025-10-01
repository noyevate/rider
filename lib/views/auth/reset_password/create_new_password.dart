
// ignore_for_file: deprecated_member_use

import 'package:rider/common/color_extension.dart';
import 'package:rider/common/custom_button.dart';
import 'package:rider/common/page_title.dart';
import 'package:rider/common/password_texfield.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/controllers/password_contrroller.dart';
import 'package:rider/controllers/reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:lottie/lottie.dart';

class ResetNewPassword extends StatefulWidget {
  const ResetNewPassword({super.key});

  @override
  State<ResetNewPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetNewPassword> {
  late final TextEditingController _passwordController1 =
      TextEditingController();
  late final TextEditingController _passwordController2 =
      TextEditingController();

  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordController1.dispose();
    _passwordController2.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var userID = box.read('userID');
    final passwordContrroller = Get.put(PasswordController());
    final controller = Get.put(ResetPasswordController());
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.h),
              child: Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    const PageTitle(),
                  ],
                ),
              )),
          body: Container(
            height: height,
            width: width,
            color: Tcolor.White,
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        ReuseableText(
                          title: "Reset password",
                          style: TextStyle(
                            color: Tcolor.Text,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w700,
                            wordSpacing: 2.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ReuseableText(
                          title: "Protect your account with a strong password",
                          style: TextStyle(
                            color: Tcolor.TEXT_Label,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 90.h),
                        ReuseableText(
                          title: "Password",
                          style: TextStyle(
                            color: Tcolor.TEXT_Label,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 96.h,
                          child: PasswordTextField(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  passwordContrroller.setPassword =
                                      !passwordContrroller.password;
                                },
                                child: passwordContrroller.password
                                    ? Icon(
                                        HeroiconsOutline.eye,
                                        size: 28.sp,
                                      )
                                    : Icon(
                                        HeroiconsOutline.eyeSlash,
                                        size: 26.sp,
                                      ),
                              ),
                              prefixIcon: Icon(
                                HeroiconsOutline.lockClosed,
                                size: 28.sp,
                              ),
                              controller: _passwordController1),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        ReuseableText(
                          title: "Confirm Password",
                          style: TextStyle(
                            color: Tcolor.TEXT_Label,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 96.h,
                          child: PasswordTextField(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  passwordContrroller.setPassword =
                                      !passwordContrroller.password;
                                },
                                child: passwordContrroller.password
                                    ? Icon(
                                        HeroiconsOutline.eye,
                                        size: 28.sp,
                                      )
                                    : Icon(
                                        HeroiconsOutline.eyeSlash,
                                        size: 26.sp,
                                      ),
                              ),
                              prefixIcon: Icon(
                                HeroiconsOutline.lockClosed,
                                size: 28.sp,
                              ),
                              controller: _passwordController2),
                        ),
        
                        SizedBox(
                          height: 100.h,
                        )
                        // Spacer(),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (_passwordController1.text == _passwordController2.text) {
                      if (_passwordController2.text.length >= 8) {
                        controller.changePassword(
                            userID, _passwordController2.text);
                      } else {
                        Get.snackbar(
                          "",
                          "",
                          duration: const Duration(seconds: 3),
                          backgroundColor: Tcolor.BACKGROUND_Regaular,
                          titleText: ReuseableText(
                            title: "Password Incomplete",
                            style: TextStyle(
                                fontSize: 28.sp,
                                color: Tcolor.Text,
                                fontWeight: FontWeight.w600),
                          ),
                          messageText: ReuseableText(
                            title:
                                "ensure your new password is more tha 7 characters.",
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Tcolor.Text_Secondary,
                                fontWeight: FontWeight.w600),
                          ),
                        );
                      }
                    } else {
                      Get.snackbar(
                        "",
                        "",
                        duration: const Duration(seconds: 3),
                        backgroundColor: Tcolor.BACKGROUND_Regaular,
                        titleText: ReuseableText(
                          title: "Incorrect Inputs",
                          style: TextStyle(
                              fontSize: 28.sp,
                              color: Tcolor.Text,
                              fontWeight: FontWeight.w600),
                        ),
                        messageText: ReuseableText(
                          title: "Passwords not the same.",
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Tcolor.Text_Secondary,
                              fontWeight: FontWeight.w600),
                        ),
                      );
                    }
                  },
                  child: CustomButton(
                    title: "Save password",
                    textColor: _passwordController1.text.isNotEmpty &&
                            _passwordController2.text.isNotEmpty
                        ? Tcolor.Text
                        : Tcolor.TEXT_Label,
                    btnColor: _passwordController1.text.isNotEmpty &&
                            _passwordController2.text.isNotEmpty
                        ? Tcolor.PRIMARY_Button_color_2
                        : Tcolor.PRIMARY_T4,
                    btnWidth: MediaQuery.of(context).size.width / 1.1,
                    btnHeight: 96.h,
                    raduis: 100.r,
                    fontSize: 32.sp,
                    showArrow: false,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                )
              ],
            ),
          ),
        ),
        Obx(() {
          if (controller.isLoading) {
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5), // Dim background
                child: Center(
                  child: LottieBuilder.asset(
                    'assets/animation/loading_state.json', // Replace with your Lottie file path
                    width: 200.w,
                    height: 200.h,
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
