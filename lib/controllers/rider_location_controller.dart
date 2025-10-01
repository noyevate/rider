// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:rider/common/size.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class RiderLocationController extends GetxController {
  RxBool _isDefaultFetched =
      false.obs; // Flag to indicate default address fetched

  RxBool _isDefault = false.obs;
  bool get isDefault => _isDefault.value;
  set setIsDefault(bool value) {
    _isDefault.value = value;
  }

  RxInt _tabIndex = 0.obs;
  int get tabIndex => _tabIndex.value;
  set setTabIndex(int value) {
    _tabIndex.value = value;
  }

  LatLng position = const LatLng(0, 0);

  void setPosition(LatLng value) {
    value = position;
    update();
  }

  RxString _address = "".obs;
  String get address => _address.value;

  set setAddress(String value) {
    if (!_isDefaultFetched.value) {
      _address.value = value;
    }
  }

  RxString _postalCode = "".obs;
  String get postalCode => _postalCode.value;

  set setPostalCode(String value) {
    _postalCode.value = value;
  }

  void setDefaultAddress(String address) {
    _address.value = address;
    _isDefaultFetched.value =
        true; // Set the flag to indicate default address is fetched
  }

  void getUserAddress(LatLng position) async {
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApiKey");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      String address = responseBody['results'][0]['formatted_address'];

      // Remove the plus_code part from the formatted_address if it exists
      final addressComponents =
          responseBody['results'][0]['address_components'];
      for (var component in addressComponents) {
        if (component['types'].contains('plus_code')) {
          final plusCode = component['long_name'];
          address = address.replaceAll(plusCode, "").trim();
        }
      }

      // Remove any leading commas
      address = address.replaceFirst(RegExp(r'^,+\s*'), '');

      setAddress = address;

      for (var component in addressComponents) {
        if (component['types'].contains('postal_code')) {
          setPostalCode = component['long_name'];
        }
      }
    }
  }

  // Future<void> fetchCurrentLocation() async {
  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     setPosition(LatLng(position.latitude, position.longitude));
  //     getUserAddress(LatLng(position.latitude, position.longitude));
  //   } catch (e) {
  //     print("Error getting current location: $e");
  //   }
  // }
}
