import 'dart:convert';
import 'package:rider/common/color_extension.dart';
import 'package:rider/common/size.dart';
import 'package:rider/models/api_error.dart';
import 'package:rider/views/auth/login/login_page.dart';
import 'package:rider/views/auth/reset_password/reset_otp_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ResetPasswordController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool value) {
    _isLoading.value = value;
  }

  void resetPasswordOtp(String email, String userType) async {
    setLoading = true;

    Uri url = Uri.parse("$appBaseUrl/api/users/reset-vendor/$email/$userType");
    print("response: ${url}");

    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(url, headers: headers);
      print("response: ${response.body}");
      if (response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        var user = responseData['user'];

        // Save data to GetStorage
        box.write('userID', user['id']);
        box.write('firstName', user['first_name']);
        box.write('lastName', user['last_name']);
        box.write('email', user['email']);
        box.write('phone', user['phone']);

        setLoading = false;

        Get.to(() => const ResetOtpPage());
      } else {
        var error = apiErrorFromJson(response.body);
        Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Otp requst failed",
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
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void changePassword(String id, String newPassword) async {
     
    setLoading = true;

    Uri url = Uri.parse("$appBaseUrl/api/users/change-Vendor-Password/$id/$newPassword");
    print("response: ${url}");

    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.put(url, headers: headers);
      print("response: ${response.body}");
      if (response.statusCode == 201) {
        

        setLoading = false;

        Get.offAll(() => const LoginPage(),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 800));
      } else {
        var error = apiErrorFromJson(response.body);
        Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Otp requst failed",
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
      setLoading = false;
    }
  }
}
