import 'package:rider/common/color_extension.dart';
import 'package:rider/common/custom_button.dart';
import 'package:rider/common/form_field.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/common/verification_tracker.dart';
import 'package:rider/controllers/upload_controller.dart';
import 'package:rider/controllers/verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class VerificationDetails extends StatelessWidget {
  const VerificationDetails({super.key, required this.next});

  final Function() next;

  @override
  Widget build(BuildContext context) {
    final uploadController = Get.put(UploaderController());
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
              height: 10.h,
            ),
            ReuseableText(
              title: "Provide some personal information to verify your account",
              style: TextStyle(
                color: Tcolor.TEXT_Label,
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                wordSpacing: 2.sp,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        uploadController.pickImage("cover");
                      },
                      child: Obx(
                        () => Container(
                          height: 270.h,
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.r),
                                  topRight: Radius.circular(30.r),
                                  bottomLeft: Radius.circular(30.r),
                                  bottomRight: Radius.circular(30.r)),
                              border: Border.all(color: Tcolor.BORDER_Regular),
                              color: Tcolor.BACKGROUND_Regaular),
                          child: uploadController.coverUrl == ''
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Container(
                                      height: 100.h,
                                      width: 100.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Tcolor.BACKGROUND_Dark),
                                      child: Icon(
                                        HeroiconsOutline.camera,
                                        color: Tcolor.Text,
                                        size: 40.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    ReuseableText(
                                      title: "Upload cover image",
                                      style: TextStyle(
                                        color: Tcolor.TEXT_Body,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    ReuseableText(
                                      title:
                                          "JPG & PNG format of max size of 2MB",
                                      style: TextStyle(
                                        color: Tcolor.TEXT_Label,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.r),
                                      topRight: Radius.circular(30.r)),
                                  child: Image.network(
                                    uploadController.coverUrl,
                                    width: 170.w,
                                    height: 170.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    ReuseableText(
                      title: "Vehicle type",
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

                              controller.vehicle.value = selectedOption;
                              controller.validateForm1();
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(15.0), // Curved edges
                            ),
                            color: Tcolor.White, // Background color of dropdown
                            itemBuilder: (BuildContext context) {
                              return vehicleType.map((String option) {
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
                                          fontSize: 24.sp,
                                          color: Tcolor.TEXT_Label),
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                          ),
                          controller: TextEditingController(
                              text: controller.vehicle.value),
                          hintText: "select option",
                          onChanged: (value) {
                            controller.vehicle.value = value;
                            controller.validateForm1();
                          },
                        ),
                      );
                    }),
                    SizedBox(
                      height: 25.h,
                    ),
                    ReuseableText(
                      title: "Vehicle brand",
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
                      styleColor: Tcolor.TEXT_Placeholder,
                      obscureText: false,
                      readOnly: false,
                      borderColor: Colors.transparent,
                      suffixIcon: Icon(
                        HeroiconsOutline.chevronDown,
                        size: 28.sp,
                        color: Tcolor.BACKGROUND_Regaular,
                      ),
                      controller: controller.vehicleBrand,
                      hintText: "e.g Toyota",
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        controller.validateForm1();
                      },
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    ReuseableText(
                      title: "Plate number",
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
                      styleColor: Tcolor.TEXT_Placeholder,
                      obscureText: false,
                      readOnly: false,
                      borderColor: Colors.transparent,
                      suffixIcon: Icon(
                        HeroiconsOutline.chevronDown,
                        size: 28.sp,
                        color: Tcolor.BACKGROUND_Regaular,
                      ),
                      controller: controller.plateNumber,
                      hintText: "Enter number",
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        controller.validateForm1();
                      },
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    ReuseableText(
                      title: "Gender",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Obx(() => GestureDetector(
                              onTap: () {
                                controller.selectedGender.value = 'Male';
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 40.w,
                                    height: 40.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: controller
                                                    .selectedGender.value ==
                                                'Male'
                                            ? Tcolor.Primary_Checkbox_icon
                                            : Tcolor.Secondary_Checkbox_icon,
                                        width: 1,
                                      ),
                                      color: controller.selectedGender.value ==
                                              'Male'
                                          ? Colors.transparent
                                          : Tcolor.White,
                                    ),
                                    child: controller.selectedGender.value ==
                                            'Male'
                                        ? Center(
                                            child: Container(
                                              width: 20.w,
                                              height: 20.w,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Tcolor
                                                    .Primary_Checkbox_icon,
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                  SizedBox(width: 10.w),
                                  ReuseableText(
                                    title: 'Male',
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Tcolor.TEXT_Label,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(width: 30.w),
                        Obx(() => GestureDetector(
                              onTap: () {
                                controller.selectedGender.value = 'Female';
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 40.w,
                                    height: 40.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: controller
                                                    .selectedGender.value ==
                                                'Female'
                                            ? Tcolor.Primary_Checkbox_icon
                                            : Tcolor.Secondary_Checkbox_icon,
                                        width: 1,
                                      ),
                                      color: controller.selectedGender.value ==
                                              'Female'
                                          ? Colors.transparent
                                          : Tcolor.White,
                                    ),
                                    child: controller.selectedGender.value ==
                                            'Female'
                                        ? Center(
                                            child: Container(
                                              width: 20.w,
                                              height: 20.w,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Tcolor
                                                    .Primary_Checkbox_icon,
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                  SizedBox(width: 10.w),
                                  ReuseableText(
                                    title: 'Female',
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Tcolor.TEXT_Label,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    ReuseableText(
                      title: "Next kin name",
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
                      styleColor: Tcolor.TEXT_Placeholder,
                      obscureText: false,
                      readOnly: false,
                      borderColor: Colors.transparent,
                      suffixIcon: Icon(
                        HeroiconsOutline.chevronDown,
                        size: 28.sp,
                        color: Tcolor.BACKGROUND_Regaular,
                      ),
                      controller: controller.nextOfKin,
                      hintText: "e.g John Doe",
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        controller.validateForm1();
                      },
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    ReuseableText(
                      title: "Guarantor 1 Name ",
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
                      styleColor: Tcolor.TEXT_Placeholder,
                      obscureText: false,
                      readOnly: false,
                      borderColor: Colors.transparent,
                      suffixIcon: Icon(
                        HeroiconsOutline.chevronDown,
                        size: 28.sp,
                        color: Tcolor.BACKGROUND_Regaular,
                      ),
                      controller: controller.guarantor1Name,
                      hintText: "Enter name",
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        controller.validateForm1();
                      },
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReuseableText(
                              title: "Guarantor 1 Phone",
                              style: TextStyle(
                                color: Tcolor.TEXT_Label,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            FormFieldWidget(
                              styleColor: Tcolor.TEXT_Placeholder,
                              obscureText: false,
                              readOnly: false,
                              borderColor: Colors.transparent,
                              width1: width / 2.1,
                              suffixIcon: Icon(
                                HeroiconsOutline.chevronDown,
                                size: 28.sp,
                                color: Tcolor.BACKGROUND_Regaular,
                              ),
                              hintText: "Enter number",
                              controller: controller.guarantor1Phone,
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                controller.validateForm1();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReuseableText(
                                title: "Relationship",
                                style: TextStyle(
                                  color: Tcolor.TEXT_Label,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10.h),
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
                                        controller.guarantor1Relationship
                                            .value = selectedOption;
                                        controller.validateForm1();
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            15.0), // Curved edges
                                      ),
                                      color: Tcolor
                                          .White, // Background color of dropdown
                                      itemBuilder: (BuildContext context) {
                                        return guarantorRelationship
                                            .map((String option) {
                                          return PopupMenuItem<String>(
                                            value: option,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Tcolor.White,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.h,
                                                  horizontal: 10.w),
                                              child: ReuseableText(
                                                title: option,
                                                style: TextStyle(
                                                    fontSize: 24.sp,
                                                    color: Tcolor.TEXT_Label),
                                              ),
                                            ),
                                          );
                                        }).toList();
                                      },
                                    ),
                                    controller: TextEditingController(
                                        text: controller
                                            .guarantor1Relationship.value),
                                    hintText: "select option",
                                    onChanged: (value) {
                                      controller.guarantor1Relationship.value =
                                          value;
                                      controller.validateForm1();
                                    },
                                  ),
                                );
                              }),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    ReuseableText(
                      title: "Guarantor 2 Name ",
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
                      styleColor: Tcolor.TEXT_Placeholder,
                      obscureText: false,
                      readOnly: false,
                      borderColor: Colors.transparent,
                      suffixIcon: Icon(
                        HeroiconsOutline.chevronDown,
                        size: 28.sp,
                        color: Tcolor.BACKGROUND_Regaular,
                      ),
                      controller: controller.guarantor2Name,
                      hintText: "Enter name",
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        controller.validateForm1();
                      },
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReuseableText(
                              title: "Guarantor 2 Phone",
                              style: TextStyle(
                                color: Tcolor.TEXT_Label,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            FormFieldWidget(
                              styleColor: Tcolor.TEXT_Placeholder,
                              obscureText: false,
                              readOnly: false,
                              borderColor: Colors.transparent,
                              width1: width / 2.1,
                              suffixIcon: Icon(
                                HeroiconsOutline.chevronDown,
                                size: 28.sp,
                                color: Tcolor.BACKGROUND_Regaular,
                              ),
                              hintText: "Enter number",
                              controller: controller.guarantor2Phone,
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                controller.validateForm1();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReuseableText(
                                title: "Relationship",
                                style: TextStyle(
                                  color: Tcolor.TEXT_Label,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10.h),
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
                                        controller.guarantor2Relationship
                                            .value = selectedOption;
                                        controller.validateForm1();
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            15.0), // Curved edges
                                      ),
                                      color: Tcolor
                                          .White, // Background color of dropdown
                                      itemBuilder: (BuildContext context) {
                                        return guarantorRelationship
                                            .map((String option) {
                                          return PopupMenuItem<String>(
                                            value: option,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Tcolor.White,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.h,
                                                  horizontal: 10.w),
                                              child: ReuseableText(
                                                title: option,
                                                style: TextStyle(
                                                    fontSize: 24.sp,
                                                    color: Tcolor.TEXT_Label),
                                              ),
                                            ),
                                          );
                                        }).toList();
                                      },
                                    ),
                                    controller: TextEditingController(
                                        text: controller
                                            .guarantor2Relationship.value),
                                    hintText: "Select",
                                    onChanged: (value) {
                                      controller.guarantor2Relationship.value =
                                          value;
                                      controller.validateForm1();
                                    },
                                  ),
                                );
                              }),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          VerificationTracker(
                            title: '1',
                            color: Tcolor.Primary_Checkbox_icon,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          VerificationTracker(
                            title: '2',
                            color: Tcolor.Secondary_Checkbox_icon,
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
                      height: 35.h,
                    ),
                    Obx(
                      () => CustomButton(
                        title: "Continue",
                        textColor: Tcolor.Text,
                        btnColor: controller.verificationDetails.value && uploadController.coverUrl != "" && controller.selectedGender.value != ""
                            ? Tcolor.PRIMARY_Button_color_2
                            : Tcolor.PRIMARY_Button_Disabled,
                        btnWidth: MediaQuery.of(context).size.width / 1.1,
                        btnHeight: 90.h,
                        raduis: 100.r,
                        fontSize: 32.sp,
                        showArrow: false,
                        onTap: controller.verificationDetails.value
                            ? () {
                                controller.vehicleImgUrl.value =
                                    uploadController.coverUrl;
                                next();
                                print(uploadController.coverUrl);
                               
                              }
                            : () {
                                print(controller.verificationDetails.value);
                              },
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
