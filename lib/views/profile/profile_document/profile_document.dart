import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/controllers/profile_controllers.dart';
import 'package:rider/views/profile/profile_document/widget/profile_document_tile.dart';
import 'package:rider/views/profile/profile_document/widget/subwidgets/driver_licence.dart';
import 'package:rider/views/profile/profile_document/widget/subwidgets/driver_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

import 'widget/subwidgets/vehicle_particular.dart';
import 'widget/subwidgets/vehicle_picture.dart';

class ProfileDocument extends StatelessWidget {
  const ProfileDocument({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var userImageUrl = box.read("userImagUrl");
    var vehicleImgUrl = box.read("vehicleImgUrl");
    var particularsImageUrl = box.read("particularsImageUrl");
    var driverLicenseImageUrl = box.read("driverLicenseImageUrl");
    final controller = Get.put(ProfileController());


    controller.userImageUrl_.value  = userImageUrl;
    controller.vehicleImgUrl_.value  = vehicleImgUrl;
    controller.particularsImageUrl_.value = particularsImageUrl;
    controller.driverLicenseImageUrl_.value = driverLicenseImageUrl;

    return Scaffold(
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: Column(
          children: [
            SizedBox(
              height: 60.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 30.w),
              height: 70.h,
              color: Tcolor.BACKGROUND_Regaular,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0, // Align the icon to the left
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 62.h,
                        width: 62.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Tcolor.White,
                        ),
                        child: Icon(
                          HeroiconsMini.chevronLeft,
                          color: Tcolor.Text,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ReuseableText(
                      title: "Documents",
                      style: TextStyle(
                        color: Tcolor.Text,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              color: Color.fromRGBO(217, 217, 217, 1),
            ),
            SizedBox(
              height: 30.h,
            ),
            Obx(() => ProfileDocumentTile(
                name_1: "assets/img/psedo_user_image.png",
                name: controller.userImageUrl_.value,
                title: "Driver’s Picture ",
                onTap: () {
                  Get.to(() => FaceCapturePage());

                  // Navigator.push(context, MaterialPageRoute(builder: (context) => FaceCapturePage()));
                },
              ),),
          
            
            
            SizedBox(
              height: 30.h,
            ),
            Obx(() => ProfileDocumentTile(
                name: controller.driverLicenseImageUrl_.value,                
                title: "Driver’s license",
                onTap: () {
                  Get.to(() => DriverLicence());
                }, name_1: 'assets/img/licence.png',
              ),),
            
            
            SizedBox(
              height: 30.h,
            ),
            Obx(() => ProfileDocumentTile(
              name: controller.particularsImageUrl_.value,
              title: "Vehicle Particulars",
              onTap: () {
                Get.to(() => VehicleParticular());
              }, name_1: 'assets/img/particulars.png',
            ),),
           
            
            SizedBox(
              height: 30.h,
            ),

            Obx(() => ProfileDocumentTile(

              name: controller.vehicleImgUrl_.value,
              title: "Vehicle Pictures",
              onTap: () {
                Get.to(() => VehiclePicture());
              },  name_1: 'assets/img/Okada.png',
            )),
            
            
          ],
        ),
      ),
    );
  }
}
