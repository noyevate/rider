import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rider/common/color_extension.dart';
import 'package:rider/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rider/services/location_streaming_socket_io.dart';

class OrderController extends GetxController {
  final box = GetStorage();

  LocationStreamingSocketIo streamSocket = LocationStreamingSocketIo();

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  RxInt totalOrder = 0.obs;
  var status = ''.obs;

  set setLoading(bool value) {
    _isLoading.value = value;
  }

  Future<int?> acceptOrder(String orderId, String userid) async {
    setLoading = true;

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcm = await messaging.getToken();
    print("FCM Token: $fcm");

    if (fcm == null) {
      print("Error: Unable to get FCM Token");
      return null;
    }

    Uri url =
        Uri.parse("$appBaseUrl/api/rider/assign-rider/$orderId/$userid/$fcm");
    Map<String, String> headers = {'Content-Type': 'application/json'};
    print(url);

    try {
      var response = await http.put(url, headers: headers);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        var responseData = jsonDecode(response.body);
        var order = responseData['data'];

        status.value = order['riderStatus'];
        return response.statusCode;
      } else {
        print(response.body);
        Get.snackbar(
          "Error",
          response.body,
          colorText: Tcolor.Text,
          duration: const Duration(seconds: 3),
          backgroundColor: Tcolor.ERROR_Light_2,
          icon: const Icon(Ionicons.fast_food_outline),
        );
      }
    } catch (e) {
      print('Error occurred: $e');
      setLoading = false;
      return null;
    } finally {
      setLoading = false;
    }
    return null;
  }

  Future<int?> rejectOrder(String orderId, String riderId) async {
    setLoading = true;

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcm = await messaging.getToken();
    print("FCM Token: $fcm");

    if (fcm == null) {
      print("Error: Unable to get FCM Token");
      return null;
    }
    Uri url =
        Uri.parse("$appBaseUrl/api/rider/reject-order/$orderId/$riderId/$fcm");
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.put(url, headers: headers);

      if (response.statusCode == 200) {
        print(response.body);
        return response.statusCode;
      } else {
        print(response.body);
        Get.snackbar(
          "Error",
          response.body,
          colorText: Tcolor.Text,
          duration: const Duration(seconds: 3),
          backgroundColor: Tcolor.ERROR_Light_2,
          icon: const Icon(Ionicons.fast_food_outline),
        );
      }
    } catch (e) {
      print('Error occurred: $e');
      setLoading = false;
      return null;
    } finally {
      setLoading = false;
    }
    return null;
  }

  Future<int?> updateRiderStaus(String orderId, String riderStatus) async {
    setLoading = true;

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcm = await messaging.getToken();
    print("FCM Token: $fcm");

    if (fcm == null) {
      print("Error: Unable to get FCM Token");
      return null;
    }

    Uri url = Uri.parse(
        "$appBaseUrl/api/rider/update-riderStatus/$orderId/$riderStatus/$fcm");
    Map<String, String> headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.patch(url, headers: headers);

      print(response.body);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var order = responseData['order'];

        status.value = order['riderStatus'];

        print(status.value);
        setLoading = false;
        print(response.statusCode);
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (error) {
      print("Error: $error");
      setLoading = false;
    }
    return null;
  }

  Future<void> startStreamingLocation(String orderId, String riderId) async {
    streamSocket.initSocket(orderId, riderId);
    await box.write('activeOrderId', orderId);
    await box.write('activeRiderId', riderId);
    print("✅ Saved active order to storage: $orderId");
  }

  void stopStreamingLocation() {
    print("🛑 Stopping location streaming for the completed order.");
    streamSocket.disconnect();
    box.remove('activeOrderId');
    box.remove('activeRiderId');
    print("✅ Cleared active order from storage.");
  }
}
