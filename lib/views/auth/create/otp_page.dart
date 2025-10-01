
import 'package:rider/common/color_extension.dart';
import 'package:rider/common/otp_field.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/controllers/create_account_controller.dart';
import 'package:rider/controllers/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';


class OTPPage extends StatelessWidget {
  const OTPPage({super.key, required this.email});

  final String email;

  String getObscuredemail(String email) {
    if (email.length >= 7) {
      return email.replaceRange(5, email.length - 3, '*' * (email.length - 6));
    } else {
      return email; // Handle case for short phone numbers if necessary
    }
  }

  @override
  Widget build(BuildContext context) {
    final OtpController controller = Get.put(OtpController());
    final CreateAccountController accountController = Get.put(CreateAccountController());
    String obscuredEmail = getObscuredemail(email);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(30.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            Container(
              height: 80.h,
              width: 80.h,
              decoration: BoxDecoration(
                color: Tcolor.BACKGROUND_Dark,
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Get.back();
                    accountController.emailController.text = "";
                    accountController.phoneNumberController.text = "";
                    accountController.firstNameController.text = "";
                    accountController.lastNameController.text = "";
                    accountController.passwordController.text = "";
                  },
                  icon: Icon(
                    HeroiconsOutline.arrowLeft,
                    color: Tcolor.Text,
                    size: 32.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            ReuseableText(
              title: "Enter OTP",
              style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.w600,
                color: Tcolor.Text,
              ),
            ),
            SizedBox(height: 10.h),
            ReuseableText(
              title: "Enter the 4-digit code sent to $obscuredEmail to reset your PIN.",
              style: TextStyle(
                fontSize: 24.sp,
                color: Tcolor.TEXT_Label,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 50.h),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OTPField(
                  controller: controller.otp1Controller,
                  focusNode: controller.focusNodes[0],
                  onChanged: (value) => controller.handleOTPInput(value, 0),
                  isError: controller.isOtpWrong.value,
                ),
                SizedBox(width: 20.w),
                OTPField(
                  controller: controller.otp2Controller,
                  focusNode: controller.focusNodes[1],
                  onChanged: (value) => controller.handleOTPInput(value, 1),
                  isError: controller.isOtpWrong.value,
                ),
                SizedBox(width: 20.w),
                OTPField(
                  controller: controller.otp3Controller,
                  focusNode: controller.focusNodes[2],
                  onChanged: (value) => controller.handleOTPInput(value, 2),
                  isError: controller.isOtpWrong.value,
                ),
                SizedBox(width: 20.w),
                OTPField(
                  controller: controller.otp4Controller,
                  focusNode: controller.focusNodes[3],
                  onChanged: (value) => controller.handleOTPInput(value, 3),
                  isError: controller.isOtpWrong.value,
                ),
              ],
            )),
            if (controller.isOtpWrong.value)
            Obx(() => Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Row(
                  children: [
                    Icon(HeroiconsOutline.exclamationCircle, color: Tcolor.ERROR_Reg, size: 24.sp,),
                    SizedBox(width: 10.w),
                    ReuseableText(
                      title: controller.errorMessage.value,
                      style: TextStyle(
                        color: Tcolor.ERROR_Reg,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )),
              
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 50.h),
                child: Obx(() => TextButton(
                  onPressed: controller.canResend.value ? controller.resendCode : null,
                  child: ReuseableText(
                    title: controller.canResend.value ? "Resend code" : "Resend code in ${controller.countdown.value} secs",
                    style: TextStyle(
                      color: controller.canResend.value ? Tcolor.PRIMARY_Button_color_1 : Tcolor.TEXT_Label,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
