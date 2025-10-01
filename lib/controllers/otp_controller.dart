import 'dart:async';
import 'dart:convert';
import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/models/api_error.dart';
import 'package:rider/models/otp_success_model.dart';
import 'package:rider/views/verification/verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OtpController extends GetxController {
  final box = GetStorage();

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool value) {
    _isLoading.value = value;
  }

  var errorMessage = "".obs;
  var isOtpWrong = false.obs;
  var otp = List.generate(4, (index) => ''.obs).obs;
  var canResend = false.obs;
  var countdown = 60.obs;
  var otpError = List.generate(4, (index) => false.obs).obs;

  late TextEditingController otp1Controller,
      otp2Controller,
      otp3Controller,
      otp4Controller;
  late List<FocusNode> focusNodes;
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    otp1Controller = TextEditingController();
    otp2Controller = TextEditingController();
    otp3Controller = TextEditingController();
    otp4Controller = TextEditingController();
    focusNodes = List.generate(4, (_) => FocusNode());
    startTimer();
  }

  @override
  void onClose() {
    otp1Controller.dispose();
    otp2Controller.dispose();
    otp3Controller.dispose();
    otp4Controller.dispose();
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void handleOTPInput(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      otp[index].value = value;
      focusNodes[index + 1].requestFocus();
    } else if (index == 3 && value.isNotEmpty) {
      otp[index].value = value;
      submitOTP();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  void handleBackspace(String value, int index) {
    if (value.isEmpty && index > 0) {
      otp[index - 1].value = '';
      focusNodes[index - 1].requestFocus();
    }
  }

  void clearOTP() {
    for (var i = 0; i < otp.length; i++) {
      otp[i].value = '';
      otpError[i].value = false;
    }
    otp1Controller.clear();
    otp2Controller.clear();
    otp3Controller.clear();
    otp4Controller.clear();
    focusNodes[0].requestFocus();
  }

  void submitOTP() async {
    String fullOTP = otp.map((e) => e.value).join();

    if (fullOTP.length == 4) {
      print(fullOTP);
      setLoading = true;

      // Retrieve user data from storage
      var userID = box.read('userid');
      var data = jsonEncode({
        'user_id': userID,
        'otp': fullOTP,
      });

      Uri url =
          Uri.parse("$appBaseUrl/api/users/verify-vendor-otp/$userID/$fullOTP");
      Map<String, String> headers = {'Content-Type': 'application/json'};

      try {
        print(url);
        var response = await http.post(url, headers: headers, body: data);
        print(response.body);
        if (response.statusCode == 201) {
          OtpSucessModel responseData = otpSucessModelFromJson(response.body);
          print("otp-response Statuscode ${response.statusCode}");

          String userId = responseData.id;
          var user = jsonEncode(responseData);

          // Save data to GetStorage
          box.write(userId, user);
          box.write('first_name', responseData.firstName);
          box.write('userId', responseData.id);
          box.write("verification1", responseData.verification);
          box.write('last_name', responseData.lastName);
          box.write('email', responseData.email);
          box.write('phone', responseData.phone);
          box.write('token', responseData.token);
          box.write('verification', responseData.phoneVerification);
          Get.offAll(() => const VerificationView(),
          transition: Transition.fade,
          duration: const Duration(milliseconds: 900));

          setLoading = false;
          isOtpWrong.value = false;
          
        } else {
          isOtpWrong.value = true;
          var error = apiErrorFromJson(response.body);
          final responseData = jsonDecode(response.body);
          errorMessage.value = responseData['message'];

          // Get.defaultDialog(
          //   backgroundColor: Tcolor.White,
          //   title: "Verification Failed",
          //   titleStyle: TextStyle(
          //       fontSize: 28.sp,
          //       fontWeight: FontWeight.w600,
          //       color: Tcolor.TEXT_Placeholder),
          //   middleText: error.message,
          //   middleTextStyle: TextStyle(
          //       fontSize: 20.sp,
          //       fontWeight: FontWeight.w400,
          //       color: Tcolor.TEXT_Label),
          //   textConfirm: "OK",
          //   onConfirm: () {
          //     Get.back();
          //   },
          //   barrierDismissible: false,
          //   confirmTextColor: Tcolor.Text,
          //   buttonColor: Tcolor.TEXT_Label,
          // );

          // Set error state
          for (var i = 0; i < otp.length; i++) {
            otpError[i].value = true;
          }

          setLoading = false;
        }
      } catch (e) {
        
          errorMessage.value = "something went wrong";
        setLoading = false;
      }
    }
  }

  void startTimer() {
    canResend.value = false;
    countdown.value = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value == 0) {
        canResend.value = true;
        _timer.cancel();
      } else {
        countdown.value--;
      }
    });
  }

  void resendCode() async {
    // Logic to resend the code
    setLoading = true;

    // Retrieve user data from storage
    var userID = box.read('userID');
    var data = jsonEncode({
      'user_id': userID,
    });

    Uri url = Uri.parse("$appBaseUrl/resend-otp/$userID");
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(url, headers: headers);
      print(response.body);
      if (response.statusCode == 201) {
        Get.snackbar(
          "",
          "",
          duration: const Duration(seconds: 3),
          backgroundColor: Tcolor.BACKGROUND_Regaular,
          titleText: ReuseableText(
            title: "Otp Sent",
            style: TextStyle(
                fontSize: 28.sp,
                color: Tcolor.Text,
                fontWeight: FontWeight.w600),
          ),
          messageText: ReuseableText(
            title: "a new one time pin as been sent to your number.",
            style: TextStyle(
                fontSize: 20.sp,
                color: Tcolor.Text_Secondary,
                fontWeight: FontWeight.w600),
          ) 
        );
        setLoading = false;
      } else {
        var error = jsonDecode(response.body);
        errorMessage.value = error.message;

        Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Verification Failed",
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

        // Set error state

        setLoading = false;
      }
    } catch (e) {
      debugPrint(e.toString());
      setLoading = false;
    }
  }
}
