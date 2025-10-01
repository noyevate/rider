import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/common/size.dart';
import 'package:rider/models/api_error.dart';
import 'package:rider/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rider/models/payout_response_model.dart';

import '../common/color_extension.dart';

class TripsController extends GetxController {
  final box = GetStorage();

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool newValue) {
    _isLoading.value = newValue;
  }

  Future<OrderModel> fetchActiveOrder(String riderId) async {
    setLoading = true;

    var url = Uri.parse("$appBaseUrl/api/rider/current-trip/$riderId");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        setLoading = false;
        print("trip ordee:  ${response.body}");

        var data =
            json.decode(response.body); // Assuming the API response is JSON
        return OrderModel.fromJson(data); // Return a single restaurant model
      } else {
        var error = apiErrorFromJson(response.body);
        print("error: ${error}");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setLoading = false;
    }
    throw Exception('Failed to fetch trip');
  }

  Future<PayoutResponseModel> restaurantPayout(String data) async {
    setLoading = true;

    Uri url = Uri.parse("$payoutUrl/delivery-payout");
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(url, headers: headers, body: data);
      print(response.body);
      if (response.statusCode == 200) {
        PayoutResponseModel responseData =
            payoutResponseModelFromJson(response.body);
        setLoading = false;
        return responseData;
      } else {
        var error = jsonDecode(response.body);
        Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Error",
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
    } catch (e) {
      debugPrint(e.toString());
      Get.defaultDialog(
        backgroundColor: Tcolor.White,
        title: "error",
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
    throw Exception('Payout Failed');
  }
}
