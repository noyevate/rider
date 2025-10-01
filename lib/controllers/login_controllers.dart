import 'package:rider/common/color_extension.dart';
import 'package:rider/common/size.dart';
import 'package:rider/controllers/profile_controllers.dart';
import 'package:rider/main_screen.dart';
import 'package:rider/models/api_error.dart';
import 'package:rider/models/login_response_model.dart';
import 'package:rider/views/auth/login/login_page.dart';
import 'package:rider/views/verification/verification.dart';
import 'package:rider/views/verification/widget/wait_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class LoginController extends GetxController {
  final box = GetStorage();

  final profileController = Get.put(ProfileController());

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool newValue) {
    _isLoading.value = newValue;
  }

  Future<void> login(String data) async {
    box.erase();
    // Retrieve user data from storage

    setLoading = true;
    Uri url = Uri.parse("$appBaseUrl/rider");
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(url, headers: headers, body: data);
      print("respons: ${response.body}");
      if (response.statusCode == 200) {
        LoginResponse responseData = loginResponseFromJson(response.body);        
        // String userData = jsonEncode(responseData);
        if(responseData.rider == null){
          Get.offAll(() => VerificationView(),
                transition: Transition.leftToRight,
                duration: const Duration(milliseconds: 700));

        } 
        box.write("token", responseData.userToken);
        box.write("userid", responseData.id);
        box.write("email", responseData.email);
        box.write("phone", responseData.phone);
        box.write("first_name", responseData.firstName);
        box.write("last_name", responseData.lastName);
        box.write("userImagUrl", responseData.rider?.userImageUrl);
        box.write("rating", responseData.rider?.rating);
        box.write("rating_count", responseData.rider?.ratingCount);
        box.write('riderId', responseData.rider?.id);
        box.write("vehicleImgUrl", responseData.rider?.vehicleImgUrl);
        box.write(
            "particularsImageUrl", responseData.rider?.particularsImageUrl);
        box.write(
            "driverLicenseImageUrl", responseData.rider?.driverLicenseImageUrl);
        Future.delayed(Duration(milliseconds: 300), () {
          profileController.userImageUrl_.value = box.read("userImagUrl");
        });
        if(responseData.rider != null) {
          profileController.driverLicenseImageUrl_.value =
            box.read("driverLicenseImageUrl");
        profileController.particularsImageUrl_.value =
            box.read("particularsImageUrl");
        profileController.vehicleImgUrl_.value = box.read("vehicleImgUrl");
        }
        if(responseData.rider != null) {
          switch (responseData.rider?.verification) {
          case null:
            Get.offAll(() => VerificationView(),
                transition: Transition.leftToRight,
                duration: const Duration(milliseconds: 700));
            break;
          case "Pending":
            Get.offAll(() => VerificationWaitPage(),
                transition: Transition.leftToRight,
                duration: const Duration(milliseconds: 700));
            break;
          case "Verified":
            Get.offAll(() => MainScreen(),
                transition: Transition.leftToRight,
                duration: const Duration(milliseconds: 700));
          default:
            break;
        }

        }
        setLoading = false;
      } else {
        var error = apiErrorFromJson(response.body);
        Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Login Failed",
          titleStyle: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
              color: Tcolor.TEXT_Placeholder),
          middleText: error.message,
          middleTextStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: Tcolor.TEXT_Label),
          textConfirm: "OK",
          onConfirm: () {
            Get.back();
          },
          barrierDismissible: false,
          confirmTextColor: Tcolor.Text,
          buttonColor: Tcolor.TEXT_Label,
        );
        setLoading = false;
      }
    } catch (e) {
      debugPrint(e.toString());
      Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Login Failed",
          titleStyle: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
              color: Tcolor.TEXT_Placeholder),
          middleText: "something went wrong",
          middleTextStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: Tcolor.TEXT_Label),
          textConfirm: "OK",
          onConfirm: () {
            Get.back();
          },
          barrierDismissible: false,
          confirmTextColor: Tcolor.Text,
          buttonColor: Tcolor.TEXT_Label,
        );
      setLoading = false;
    }
  }

  void logout() {
    box.erase();
    Get.offAll(() => const LoginPage());
  }

  LoginResponse? getUserInfo() {
    String? userId = box.read('userId');
    String? data;
    if (userId != null) {
      data = box.read(userId);
      print(" this is the data id: ${data}");
    }

    if (data != null) {
      return loginResponseFromJson(data);
    }
    return null;
  }
}
