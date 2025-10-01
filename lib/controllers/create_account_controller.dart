import 'dart:convert';

import 'package:rider/common/color_extension.dart';
import 'package:rider/common/size.dart';
import 'package:rider/models/api_error.dart';
import 'package:rider/views/auth/create/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CreateAccountController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  // Observables
  var isFormFilled = false.obs;
  var errorMessage = "".obs;
  var phoneNumber = ''.obs;

   // Text Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.onClose();
  }

  // Validate form
  void validateForm() {
    isFormFilled.value = firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        errorMessage.value.isEmpty;
  }

 

  @override
  void onInit() {
    super.onInit();
    firstNameController.addListener(validateForm); // Call validateForm on first name change
    lastNameController.addListener(validateForm); // Call validateForm on last name change
    emailController.addListener(validateForm); // Call validateForm on email change
    passwordController.addListener(validateForm);
    phoneNumberController.addListener(() {
      phoneNumber.value = phoneNumberController.text;
      validateForm(); // Call validateForm on phone number change
    });

    debounce(phoneNumber, (_) => checkPhoneNumber(phoneNumberController.text),
        time: const Duration(milliseconds: 100));
    errorMessage.listen((_) {
      validateForm(); // Call validateForm whenever errorMessage changes
    });
  }

  Future<void> checkPhoneNumber(String phone) async {
    final response = await http.post(
      Uri.parse('$appBaseUrl/verify-phone/$phone'), // Update with your backend URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone': phone,
      }),
    );
    print(response.body);

    if (response.statusCode == 400 || response.statusCode == 404) {
      print(response.body);
      final responseData = jsonDecode(response.body);
      errorMessage.value = responseData['message'];
    } else {
      errorMessage.value = '';
    }

    validateForm(); // Ensure this is called after updating the errorMessage
  }

  void createAccountFunction(String data) async {
    box.erase();
    setLoading = true;

    Uri url = Uri.parse("$appBaseUrl/create_rider_account");
    print("response: ${url}");

    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(url, headers: headers, body: data);
      print("response: ${response.body}");
      if (response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        var user = responseData['user'];

        // Save data to GetStorage
        box.write('userid', user['id']);
        box.write('firstName', user['first_name']);
        box.write('lastName', user['last_name']);
        box.write('email', user['email']);
        box.write('phone', user['phone']);

        setLoading = false;
        String email = box.read("email");
        
        Get.to(() =>  OTPPage(email: email,));
      } else {
        var error = apiErrorFromJson(response.body);
        print(error.message);
        Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Account Creation Failed",
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
      print("${e.toString()}");
      Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Account Creation Failed",
          titleStyle: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
              color: Tcolor.TEXT_Placeholder),
          middleText: e.toString(),
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
}