import 'package:rider/common/broken_border_line.dart';
import 'package:rider/common/color_extension.dart';
import 'package:rider/common/custom_button.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/controllers/profile_controllers.dart';
import 'package:rider/models/image_update.dart';
import 'package:rider/models/particulars_image_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../../controllers/upload_controller.dart';

class VehicleParticular extends StatelessWidget {
  const VehicleParticular({super.key});

  @override
  Widget build(BuildContext context) {
    final uploadController = Get.put(UploaderController());
    final box = GetStorage();
    final profileController = Get.put(ProfileController());
    var riderId = box.read("riderId");
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.h),
              child: Center(
                child: ReuseableText(
                  title: "Update Vehicle Particulars",
                  style: TextStyle(
                    color: Tcolor.Text,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  // right: 0, // Align the icon to the left
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 55.h,
                      width: 55.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Tcolor.White,
                          border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.49))),
                      child: Icon(
                        HeroiconsMini.chevronLeft,
                        color: Tcolor.Text,
                        size: 40.sp,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: GestureDetector(
                          onTap: () {
                            uploadController.pickImage("two");
                          },
                          child: Obx(
                            () =>  CircleAvatar(
                                radius: 200.r,
                                backgroundColor: Color.fromRGBO(251, 251, 251, 1),
                                child: CustomPaint(
                                  size: Size(400.w, 400.w),
                              painter: BrokenBorderPainter(
                                color: Tcolor.TEXT_Placeholder,
                                dashWidth: 10.w,
                                gapWidth: 5.w,
                                strokeWidth: 4.w,
                              ),
                                  child: ClipOval(
                                    child: uploadController.imageTwoUrl == '' ? Center(
                                      child: Container(
                                          height: 96.h,
                                          width: 96.w,
                                          decoration: BoxDecoration(
                                            color: Tcolor.BACKGROUND_Dark,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Icon(
                                              HeroiconsOutline.camera,
                                              color: Tcolor.Text,
                                              size: 40.sp,
                                            ),
                                          ),
                                        ),
                                    ) : Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          Image.network(uploadController.imageTwoUrl,
                                              fit: BoxFit.cover,
                                              width: 400.w,
                                              height: 400.h),
                                          
                                        ],
                                      ),
                                  ),
                                ),
                              ),
                            
                          )),
                    ),
        
                    SizedBox(height: 80.h),
                    ReuseableText(
                      title: "Update Vehicle pictures",
                      style: TextStyle(
                        color: Tcolor.Text,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
        
                    Obx(() => CustomButton(
                        title: "Complete Update",
                        textColor: Tcolor.Text,
                        btnColor: uploadController.imageTwoUrl != ''   ? Tcolor.PRIMARY_Button_color_2 : Color.fromRGBO(193, 193, 193, 1),
                        btnWidth: MediaQuery.of(context).size.width / 1.1,
                        btnHeight: 90.h,
                        raduis: 100.r,
                        fontSize: 32.sp,
                        showArrow: false,
                        onTap: uploadController.imageTwoUrl != '' 
                            ? () {
                                ParticularImageUpdate model = ParticularImageUpdate(particularsImageUrl: uploadController.imageTwoUrl);
                                  String data = particularImageUpdateToJson(model);
                                  profileController.updateParticulars(data, riderId);
                              }
                            : null),)
        
                    
                  ],
                )
              ],
            ),
          ),
        ),
        Obx(() {
          if (profileController.isLoading) {
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
