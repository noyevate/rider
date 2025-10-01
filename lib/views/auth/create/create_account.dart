import 'package:lottie/lottie.dart';
import 'package:rider/common/color_extension.dart';
import 'package:rider/common/custom_button.dart';
import 'package:rider/common/form_field.dart';
import 'package:rider/common/page_title.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/controllers/create_account_controller.dart';
import 'package:rider/models/create_account_model.dart';
import 'package:rider/views/verification/verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final controller = Get.put(CreateAccountController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: Column(
                children: [
                  SizedBox(height: 60.h),
                  const PageTitle(),
                ],
              ),
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    ReuseableText(
                      title: "Create your account",
                      style: TextStyle(
                        color: Tcolor.Text,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w600,
                        wordSpacing: 2.sp,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ReuseableText(
                      title:
                          "Get Choppin' with ChopNow! Sign Up for Fast & Easy Delivery.",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 60.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ReuseableText(
                            title: "First Name",
                            style: TextStyle(
                              color: Tcolor.TEXT_Label,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ReuseableText(
                            title: "Last Name",
                            style: TextStyle(
                              color: Tcolor.TEXT_Label,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: FormFieldWidget(
                            readOnly: false,
                            prefixIcon: Icon(
                              HeroiconsOutline.user,
                              size: 32.sp,
                            ),
                            hintText: "e.g john",
                            hintColor: Tcolor.TEXT_Placeholder,
                            hintFontSize: 30.sp,
                            hintFontWeight: FontWeight.w600,
                            cursorHeight: 30.sp,
                            cursorColor: Tcolor.Primary,
                            controller: controller.firstNameController,
                            onChanged: (value) => (),
                            borderColor: Colors.transparent,
                            obscureText: false,
                          ),
                        ),
                        SizedBox(width: 30.w),
                        Expanded(
                          child: FormFieldWidget(
                            readOnly: false,
                            prefixIcon: Icon(HeroiconsOutline.user, size: 32.sp),
                            hintText: "e.g Adewale",
                            hintColor: Tcolor.TEXT_Placeholder,
                            hintFontSize: 30.sp,
                            hintFontWeight: FontWeight.w600,
                            cursorHeight: 30.sp,
                            cursorColor: Tcolor.Primary,
                            controller: controller.lastNameController,
                            onChanged: (value) => controller.validateForm(),
                            borderColor: Colors.transparent,
                            obscureText: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50.h),
                    ReuseableText(
                      title: "Phone number",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align items at the start
                      children: [
                        Container(
                          width: 100.w, // Adjust the width as needed
                          height:
                              90.h, // Adjust the height to match the text field height
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w), // Padding for the icon and text
                          decoration: BoxDecoration(
                            border: Border.all(color: Tcolor.BACKGROUND_Regaular),
                            borderRadius: BorderRadius.circular(20.r),
                            color: Tcolor.BACKGROUND_Regaular,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/img/flag-for-flag-nigeria-svgrepo-com.svg",
                                height: 24.h,
                                width: 24.w,
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  "+234",
                                  style: TextStyle(
                                    color: Tcolor.TEXT_Placeholder,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormFieldWidget(
                                  readOnly: false,
                                  hintText: "81 343 XXXX",
                                  hintColor: Tcolor.TEXT_Placeholder,
                                  hintFontSize: 30.sp,
                                  hintFontWeight: FontWeight.w600,
                                  cursorHeight: 30.sp,
                                  cursorColor: Tcolor.Primary,
                                  controller: controller.phoneNumberController,
                                  fillColor: controller.errorMessage.isNotEmpty
                                      ? Tcolor.ERROR_Light_2
                                      : Tcolor.BACKGROUND_Regaular,
                                  borderColor: controller.errorMessage.isNotEmpty
                                      ? Tcolor.ERROR_Reg
                                      : Tcolor.BACKGROUND_Regaular,
                                  onChanged: (value) {
                                    controller.phoneNumber.value = value;
                                    controller.validateForm();
                                  },
                                  keyboardType: TextInputType.phone,
                                  obscureText: false,
                                ),
                                if (controller.errorMessage.isNotEmpty)
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 8.h,
                                        left: 32.w), // Adjust left padding as needed
                                    child: Row(
                                      children: [
                                        Icon(HeroiconsOutline.exclamationCircle,
                                            size: 24.sp, color: Tcolor.ERROR_Reg),
                                        SizedBox(width: 5.w),
                                        Expanded(
                                          child: ReuseableText(
                                            title: controller.errorMessage.value,
                                            style: TextStyle(
                                              color: Tcolor.ERROR_Reg,
                                              fontSize: 24.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50.h),
                    ReuseableText(
                      title: "Email Address",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    FormFieldWidget(
                      readOnly: false,
                      borderColor: Colors.transparent,
                      obscureText: false,
                      prefixIcon: Icon(
                        HeroiconsOutline.envelope,
                        size: 32.sp,
                      ),
                      hintText: "e.g Johnny@gmail.com",
                      hintColor: Tcolor.TEXT_Placeholder,
                      hintFontSize: 30.sp,
                      hintFontWeight: FontWeight.w600,
                      cursorHeight: 30.sp,
                      cursorColor: Tcolor.Primary,
                      controller: controller.emailController,
                      onChanged: (value) => controller.validateForm(),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 50.h),
                    ReuseableText(
                      title: "Password",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    FormFieldWidget(
                      readOnly: false,
                      borderColor: Colors.transparent,
                      prefixIcon: Icon(HeroiconsOutline.lockClosed, size: 32.sp,),
                      hintText: "*********",
                      obscureText: true,
                      hintColor: Tcolor.TEXT_Placeholder,
                      hintFontSize: 30.sp,
                      hintFontWeight: FontWeight.w600,
                      cursorHeight: 30.sp,
                      cursorColor: Tcolor.Primary,
                      controller: controller.passwordController,
                      onChanged: (value) => controller.validateForm(),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 100.h),
                        SizedBox(height: 100.h),
                  ],
                ),
              ),
              Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(30.sp),
                      child: Obx(
                        () => CustomButton(
                          title: "Sign Up",
                          textColor: controller.isFormFilled.value
                              ? Tcolor.Text
                              : Tcolor.TEXT_Label,
                          btnColor: controller.isFormFilled.value
                              ? Tcolor.PRIMARY_Button_color_2
                              : Tcolor.PRIMARY_Button_Disabled,
                          btnWidth: MediaQuery.of(context).size.width / 1.1,
                          btnHeight: 90.h,
                          raduis: 100.r,
                          fontSize: 32.sp,
                          showArrow: false,
                          onTap: controller.isFormFilled.value
                              ? () {
                            CreateAccountModel model = CreateAccountModel(
                                      firstName:
                                          controller.firstNameController.text,
                                      lastName: controller.lastNameController.text,
                                      phone: controller.phoneNumberController.text,
                                      email: controller.emailController.text,
                                      password: controller.passwordController.text);
                                  String data = createAccountModelToJson(model);
                                  controller.createAccountFunction(data);
                          }: null,
                          // onTap: () {
                          //   Get.to(() => VerificationView());
                          // },
        
                        ),
                      ),
                    ),
                  ),
            ],
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
