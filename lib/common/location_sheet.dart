import 'package:rider/common/color_extension.dart';
import 'package:rider/common/custom_button.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/controllers/verification_controller.dart';
// import 'package:rider/main_screen.dart';
// import 'package:rider/models/create_rider_model.dart';
// import 'package:rider/views/verification/widget/wait_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// ignore: unused_import
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:rider/models/create_rider_model.dart';
import 'package:rider/views/verification/widget/wait_page.dart';

class LocationSheet extends StatelessWidget {
  const LocationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var box = GetStorage();
    var userid = box.read("userid");
    final controller = Get.put(VerificationController());
  
    return Stack(
      children: [
        Center(
          child: Container(
            width:
                MediaQuery.of(context).size.width * 0.8, // 90% of screen width
            height: MediaQuery.of(context).size.height *
                0.6, // 50% of screen height
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.only(right: 30.w, left: 30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/img/Location.png"),
                SizedBox(height: 80.h),
                ReuseableText(
                  title: "Enable your location",
                  style: TextStyle(
                    fontSize: 45.sp,
                    fontWeight: FontWeight.w500,
                    color: Tcolor.Location_sheet_color,
                  ),
                ),
                SizedBox(height: 20.h),
                ReuseableText(
                  title: "Choose your location to start find the ",
                  style: TextStyle(
                    fontSize: 26.5.sp,
                    color: Tcolor.Location_Text_Sheet_colour,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                ReuseableText(
                  title: "request around you",
                  style: TextStyle(
                    fontSize: 26.5.sp,
                    color: Tcolor.Location_Text_Sheet_colour,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.h),
                CustomButton(
                  title: "Use my location",
                  textColor: Tcolor.Text,
                  btnColor: Tcolor.PRIMARY_Button_color_2,
                  btnWidth: 540.w,
                  btnHeight: 80.h,
                  raduis: 18.r,
                  fontSize: 24.sp,
                  showArrow: false,
                  onTap: controller.verificationDetails.value &&
                              controller.bankDetails.value &&
                              controller.selectedWorkdaysEvening.isNotEmpty ||
                          controller.selectedWorkdaysMorning.isNotEmpty
                      ? () async {
                          print("TAPPPPPPPPPPPPPPPPPPPPPPed");
                          // Navigator.of(context).pop(); // Closes the sheet

                          // Print fetched details (Optional)
                          var response = await controller.getCurrentLocation();

                          if (response["statusCode"] == 200) {
                            print("Address: ${response["address"]}");
                            print("Postal Code: ${response["postalCode"]}");
                            print("Latitude: ${response["latitude"]}");
                            print("Longitude: ${response["longitude"]}");

                            var address = response["address"];
                            var latitude = response["latitude"];
                            var longitude = response["longitude"];
                            var postalCode = response["postalCode"];

                            var guarantor1 = Guarantor(
                              name: controller.guarantor1Name.text,
                              phone: controller.guarantor1Phone.text,
                              relationship:
                                  controller.guarantor1Relationship.value,
                            );

                            var guarantor2 = Guarantor(
                              name: controller.guarantor2Name.text,
                              phone: controller.guarantor2Phone.text,
                              relationship:
                                  controller.guarantor2Relationship.value,
                            );

                            CreateRiderModel model = CreateRiderModel(
                                userId: userid,
                                vehicleImgUrl: controller.vehicleImgUrl.value,
                                vehicleType: controller.vehicle.value,
                                vehicleBrand: controller.vehicleBrand.text,
                                plateNumber: controller.plateNumber.text,
                                guarantors: [guarantor1, guarantor2],
                                bankName: controller.bank.value,
                                bankAccount: controller.accountNumber.text,
                                bankAccountName: controller.accountName.text,
                                workDays: WorkDays(
                                    morningShifts:
                                        controller.selectedWorkdaysMorning,
                                    afternoonShift:
                                        controller.selectedWorkdaysEvening),
                                userImageUrl: controller.riderImageUrl.value,
                                rating: 3.1,
                                ratingCount: 1,
                                verification: "Pending",
                                verificationMessage:
                                    "Your rider account is under review, we will notify you once it is verified",
                                coords: Coords(
                                    latitude: latitude,
                                    longitude: longitude,
                                    latitudeDelta: 0.1222,
                                    longitudeDelta: 0.1222,
                                    postalCode: postalCode,
                                    title: address));

                                    print("model.Coords:  ${model.coords.latitude}");
                                    print("model.Coords:  ${model.coords.longitude}");
                           
                            String data = createRiderModelToJson(model);
                             print("data:  ${data}");
                            int? statusCode =
                                await controller.createRider(data, userid);

                            // Check if the response status code is 201
                            if (statusCode == 201) {
                              print("Rider created successfully.");
                              // Perform additional actions on success
                              await Future.delayed(const Duration(seconds: 3));
                              Get.offAll(() => VerificationWaitPage(),
                              ); // Go back after the snackbar show
                            } else {
                              print("Error: ${response["error"]}");
                            }
                          } else {
                            print(controller.latitude.value);
                            print("Error: ${response}");
                          }
                        }
                      : () {
                        
                          print("something went terribly wrong");
                        },
                ),
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  width: 250.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Material(
                    color: Colors
                        .transparent, // Keeps the decoration color visible
                    borderRadius: BorderRadius.circular(18.r),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18.r),
                      splashColor: const Color.fromARGB(
                          255, 218, 213, 213), // The dark shade effect
                      highlightColor:
                          Colors.black26, // Lighter highlight effect
                      onTap: controller.verificationDetails.value &&
                              controller.bankDetails.value &&
                              controller.selectedWorkdaysEvening.isNotEmpty ||
                          controller.selectedWorkdaysMorning.isNotEmpty ? () async {

                            var guarantor1 = Guarantor(
                              name: controller.guarantor1Name.text,
                              phone: controller.guarantor1Phone.text,
                              relationship:
                                  controller.guarantor1Relationship.value,
                            );

                            var guarantor2 = Guarantor(
                              name: controller.guarantor2Name.text,
                              phone: controller.guarantor2Phone.text,
                              relationship:
                                  controller.guarantor2Relationship.value,
                            );

                            CreateRiderModel model = CreateRiderModel(
                                userId: userid,
                                vehicleImgUrl: controller.vehicleImgUrl.value,
                                vehicleType: controller.vehicle.value,
                                vehicleBrand: controller.vehicleBrand.text,
                                plateNumber: controller.plateNumber.text,
                                guarantors: [guarantor1, guarantor2],
                                bankName: controller.bank.value,
                                bankAccount: controller.accountNumber.text,
                                bankAccountName: controller.accountName.text,
                                workDays: WorkDays(
                                    morningShifts:
                                        controller.selectedWorkdaysMorning,
                                    afternoonShift:
                                        controller.selectedWorkdaysEvening),
                                userImageUrl: controller.riderImageUrl.value,
                                rating: 3.1,
                                ratingCount: 1,
                                verification: "Pending",
                                verificationMessage:
                                    "Your rider account is under review, we will notify you once it is verified",
                                coords: Coords(
                                    latitude: 8.4799,
                                    longitude: 4.5418,
                                    latitudeDelta: 0.1222,
                                    longitudeDelta: 0.1222,
                                    postalCode: "240103",
                                    title: "kwara state"));
                            print("model:  ${model.vehicleBrand}");
                            String data = createRiderModelToJson(model);
                            int? statusCode =
                                await controller.createRider(data, userid);

                            // Check if the response status code is 201
                            if (statusCode == 201) {
                              print("Rider created successfully.");
                              // Perform additional actions on success
                              await Future.delayed(const Duration(seconds: 3));
                              Get.offAll(() => const VerificationWaitPage()); // Go back after the snackbar show
                            } else {
                              print('error');
                            }
                          }
                        
                      : null,
                      child: Center(
                        child: ReuseableText(
                          title: "Skip for now",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 32.sp,
                            color: Tcolor.Location_Text_Sheet_colour2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
