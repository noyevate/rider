import 'package:rider/common/color_extension.dart';
import 'package:rider/common/form_field.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/common/verification_tracker.dart';
import 'package:rider/controllers/verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:rider/common/custom_button.dart';

class BankVerification extends StatelessWidget {
  const BankVerification({super.key, required this.back, required this.next});
  final Function back;
  final Function next;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerificationController());
    return SizedBox(
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60.h),
          ReuseableText(
            title: "Verification Details",
            style: TextStyle(
              color: Tcolor.Text,
              fontSize: 40.sp,
              fontWeight: FontWeight.w600,
              wordSpacing: 2.sp,
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          ReuseableText(
            title: "Choose Bank",
            style: TextStyle(
              color: Tcolor.TEXT_Label,
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Obx(() {
            return GestureDetector(
              child: FormFieldWidget(
                readOnly: true,
                obscureText: false,
                styleColor: Tcolor.TEXT_Placeholder,
                borderColor: Colors.transparent,
                suffixIcon: PopupMenuButton<String>(
                  icon: Icon(
                    HeroiconsOutline.chevronDown,
                    size: 28.sp,
                    color: Tcolor.TEXT_Label,
                  ),
                  onSelected: (String selectedOption) {
                    controller.bank.value = selectedOption;
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // Curved edges
                  ),
                  color: Tcolor.White, // Background color of dropdown
                  itemBuilder: (BuildContext context) {
                    return banks.map((String option) {
                      return PopupMenuItem<String>(
                        value: option,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Tcolor.White,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 10.w),
                          child: ReuseableText(
                            title: option,
                            style: TextStyle(
                                fontSize: 24.sp, color: Tcolor.TEXT_Label),
                          ),
                        ),
                      );
                    }).toList();
                  },
                ),
                controller: TextEditingController(text: controller.bank.value),
                hintText: "select option",
                onChanged: (value) {
                  controller.vehicle.value = value;
                  controller.validateForm2();
                },
              ),
            );
          }),
          SizedBox(
            height: 25.h,
          ),
          ReuseableText(
            title: "Account Number",
            style: TextStyle(
              color: Tcolor.TEXT_Label,
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          FormFieldWidget(
            obscureText: false,
            readOnly: false,
            borderColor: Colors.transparent,
            suffixIcon: Icon(
              HeroiconsOutline.chevronDown,
              size: 28.sp,
              color: Tcolor.BACKGROUND_Regaular,
            ),
            controller: controller.accountNumber,
            hintText: "Enter number",
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              controller.validateForm2();
            },
          ),
          SizedBox(
            height: 25.h,
          ),
          ReuseableText(
            title: "Name on Account",
            style: TextStyle(
              color: Tcolor.TEXT_Label,
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          FormFieldWidget(
            obscureText: false,
            readOnly: false,
            borderColor: Colors.transparent,
            suffixIcon: Icon(
              HeroiconsOutline.chevronDown,
              size: 28.sp,
              color: Tcolor.BACKGROUND_Regaular,
            ),
            controller: controller.accountName,
            // hintText: "e.g Toyota",
            keyboardType: TextInputType.text,
            onChanged: (value) {
              controller.validateForm2();
            },
          ),
          SizedBox(
            height: 40.h,
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                VerificationTracker(
                  title: '1',
                  color: Tcolor.Secondary_Checkbox_icon,
                ),
                SizedBox(
                  width: 20.w,
                ),
                VerificationTracker(
                  title: '2',
                  color: Tcolor.Primary_Checkbox_icon,
                ),
                SizedBox(
                  width: 20.w,
                ),
                VerificationTracker(
                  title: '3',
                  color: Tcolor.Secondary_Checkbox_icon,
                ),
                SizedBox(
                  width: 20.w,
                ),
                VerificationTracker(
                  title: '4',
                  color: Tcolor.Secondary_Checkbox_icon,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Obx(() => CustomButton(
            title: "Continue",
            textColor: Tcolor.Text,
            btnColor: controller.bankDetails.value ? Tcolor.PRIMARY_Button_color_2: Tcolor.PRIMARY_Button_Disabled,
                
            btnWidth: MediaQuery.of(context).size.width / 1.1,
            btnHeight: 90.h,
            raduis: 100.r,
            fontSize: 32.sp,
            showArrow: false,
            onTap: controller.bankDetails.value ? () {
              next();
              print(controller.bankDetails.value);
            }: null ,
          ),),
          
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}
