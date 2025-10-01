import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../common/size.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final box = GetStorage();

  var userImageUrl_ = "".obs;
  var driverLicenseImageUrl_ = "".obs;
  var vehicleImgUrl_ = "".obs;
  var particularsImageUrl_ = "".obs;

 

  // ignore: prefer_final_fields
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool newValue) {
    _isLoading.value = newValue;
  }

  Future<void> updateUserImage(String data, String riderId) async {
    setLoading = true;
    Uri url =
        Uri.parse("$appBaseUrl/api/rider/update-user-image/$riderId/userImageUrl");
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.patch(url, headers: headers, body: data);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        box.write("userImagUrl", responseData['userImageUrl']);
        userImageUrl_.value = box.read("userImagUrl");
        Get.close(1);
        setLoading = false;
      } else {
        print("update user image was not successful");
        setLoading = false;
      }
    } catch (e) {
      setLoading = false;
      debugPrint(e.toString());
    }
  }

  Future<void> updateVehicleImage(String data, String riderId) async {
    setLoading = true;
    Uri url = Uri.parse(
        "$appBaseUrl/api/rider/update-vehicle-image/$riderId/vehicleImgUrl");
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.patch(url, headers: headers, body: data);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
         box.write("vehicleImgUrl", responseData['vehicleImgUrl']);
         vehicleImgUrl_.value = box.read("vehicleImgUrl");
         Get.close(1);
         setLoading = false;
      } else {
        print("update vehicle image was not successful");
        setLoading = false;
      }
    } catch (e) {
      setLoading = false;
      debugPrint(e.toString());
    }
  }

  Future<void> updateDriverLicense(String data, String riderId) async {    // Retrieve user data from storage

    setLoading = true;
    Uri url = Uri.parse(
        "$appBaseUrl/api/rider/update-driver-license-image/$riderId/driverLicenseImageUrl");
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.patch(url, headers: headers, body: data);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        box.write("driverLicenseImageUrl", responseData['driverLicenseImageUrl']);
        driverLicenseImageUrl_.value = box.read("driverLicenseImageUrl");
        Get.close(1);
        setLoading = false;
      } else {
        print("update driver licence was not successful");
        setLoading = false;
      }
    } catch (e) {
      setLoading = false;
      debugPrint(e.toString());
    }
  }

  Future<void> updateParticulars(String data, String riderId) async {
    setLoading = true;
    Uri url = Uri.parse(
        "$appBaseUrl/api/rider/update-particulars-image/$riderId/particularsImageUrl");
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.patch(url, headers: headers, body: data);
       print(response.body);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        box.write("particularsImageUrl", responseData['particularsImageUrl']);
        particularsImageUrl_.value = box.read("particularsImageUrl");
        Get.close(1);
         setLoading = false;
      } else {
        print("update particular was not successful");
        setLoading = false;
      }
    } catch (e) {
      setLoading = false;
      debugPrint(e.toString());
    }
  }
}