import 'package:rider/common/color_extension.dart';
import 'package:rider/common/custom_button.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/views/auth/create/create_account.dart';
import 'package:rider/views/auth/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WalkThrough extends StatelessWidget {
  const WalkThrough({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Tcolor.White,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   height: 110.h,
            // ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  height: 1400.h,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100.h,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/img/CHOPNOWRIDE.png",
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ReuseableText(
                          title: "Welcome to",
                          style: TextStyle(
                            color: Tcolor.Text,
                            fontSize: 80.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        ReuseableText(
                          title: "ChopNow!",
                          style: TextStyle(
                            color: Tcolor.Text,
                            fontSize: 80.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        ReuseableText(
                          title:
                              "Start growing your restaurant business with our ",
                          style: TextStyle(
                            color: Tcolor.TEXT_Body,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        ReuseableText(
                          title:
                              "innovative ordering and delivery solutions, designed",
                          style: TextStyle(
                            color: Tcolor.TEXT_Body,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        ReuseableText(
                          title:
                              "to help you reach new customers and increase sales.",
                          style: TextStyle(
                            color: Tcolor.TEXT_Body,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 80.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Get.to(() => const CreateAccount(),
                            //     transition: Transition.rightToLeft,
                            //     duration: const Duration(milliseconds: 700));
                          },
                          child: CustomButton(
                            title: "Create account",
                            showArrow: false,
                            btnHeight: 90.h,
                            raduis: 100.r,
                            textColor: Tcolor.Text,
                            fontSize: 32.sp,
                            btnColor: Tcolor.PRIMARY_Button_color_2,
                            onTap: () {
                              Future.delayed(const Duration(milliseconds: 400),
                                  () {
                                Get.to(() => CreateAccount(),
                                  transition: Transition.leftToRight,
                                  duration: const Duration(milliseconds: 400));
                              });
                              
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        CustomButton(
                          title: "Login",
                          showArrow: true,
                          btnColor: Colors.transparent,
                          btnHeight: 90.h,
                          raduis: 100.r,
                          textColor: Tcolor.Text,
                          fontSize: 32.sp,
                          arrowColor: Tcolor.Text,
                          border: Border.all(color: Tcolor.BORDER_Regular),
                          onTap: () {
                            // Navigate to Login page
                            Future.delayed(const Duration(milliseconds: 400),
                                  () {
                                Get.to(() => LoginPage(),
                                  transition: Transition.leftToRight,
                                  duration: const Duration(milliseconds: 400));
                              });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
