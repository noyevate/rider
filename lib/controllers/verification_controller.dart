// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rider/common/color_extension.dart';
import 'package:rider/common/size.dart';
import 'package:rider/main_screen.dart';
import 'package:rider/models/api_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
// import 'package:firebase_messaging/firebase_messaging.dart';

class VerificationController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  var verificationDetails = false.obs;
  var riderImageUrl = "".obs;
  var vehicleImgUrl = "".obs;

  var bankDetails = false.obs;

  var vehicle = ''.obs;
  var guarantor1Relationship = ''.obs;
  var guarantor2Relationship = ''.obs;
  var bank = ''.obs;
  RxString selectedGender = ''.obs;

  final RxList<String> selectedWorkdaysMorning = <String>[].obs;
  final RxList<String> selectedWorkdaysEvening = <String>[].obs;

  //

  var address = "".obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var postalCode = "".obs;

  final TextEditingController vehicleBrand = TextEditingController();
  final TextEditingController plateNumber = TextEditingController();
  final TextEditingController nextOfKin = TextEditingController();
  final TextEditingController guarantor1Name = TextEditingController();
  final TextEditingController guarantor1Phone = TextEditingController();
  final TextEditingController guarantor2Name = TextEditingController();
  final TextEditingController guarantor2Phone = TextEditingController();
  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController accountName = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    // Listen to changes and call validateForm1()
    ever(vehicle, (_) => validateForm1());
    ever(guarantor1Relationship, (_) => validateForm1());
    ever(guarantor2Relationship, (_) => validateForm1());
  }

  void validateForm1() {
    verificationDetails.value = vehicleBrand.text.isNotEmpty &&
        plateNumber.text.isNotEmpty &&
        nextOfKin.text.isNotEmpty &&
        guarantor1Name.text.isNotEmpty &&
        guarantor1Phone.text.isNotEmpty &&
        guarantor2Name.text.isNotEmpty &&
        guarantor2Phone.text.isNotEmpty &&
        vehicle.value.isNotEmpty &&
        guarantor1Relationship.value.isNotEmpty &&
        guarantor2Relationship.value.isNotEmpty;

    print('Verification Details: ${verificationDetails.value}');
  }

  void validateForm2() {
    bankDetails.value = accountNumber.text.isNotEmpty &&
        accountName.text.isNotEmpty &&
        bank.value.isNotEmpty;
  }

  // Future<Map<String, dynamic>> getCurrentLocation() async {
  //   try {
  //     setLoading = true;
  //     // Check permission
  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.deniedForever) {
  //         throw Exception("Location permissions are permanently denied.");
  //       }
  //     }

  //     // Define location settings
  //     LocationSettings locationSettings = LocationSettings(
  //       accuracy: LocationAccuracy.best, // High precision
  //       distanceFilter: 10, // Minimum movement in meters before update
  //     );

  //     // Get current position with new settings
  //     Position position = await Geolocator.getCurrentPosition(
  //       locationSettings: locationSettings,
  //     );

  //     latitude.value = position.latitude;
  //     longitude.value = position.longitude;

  //     // Get address from coordinates
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(position.latitude, position.longitude)
  //             .timeout(Duration(seconds: 20), onTimeout: () {
  //       throw TimeoutException("Reverse Geocoding took too long.");
  //     });

  //     if (placemarks.isNotEmpty) {
  //       Placemark place = placemarks.first;

  //       // Ensure we exclude Plus Codes
  //       List<String> addressParts = [
  //         if (place.street != null &&
  //             !place.street!.contains("+") &&
  //             place.street!.isNotEmpty)
  //           place.street!,
  //         if (place.subLocality != null &&
  //             !place.subLocality!.contains("+") &&
  //             place.subLocality!.isNotEmpty)
  //           place.subLocality!,
  //         if (place.locality != null &&
  //             !place.locality!.contains("+") &&
  //             place.locality!.isNotEmpty)
  //           place.locality!,
  //         if (place.administrativeArea != null &&
  //             !place.administrativeArea!.contains("+") &&
  //             place.administrativeArea!.isNotEmpty)
  //           place.administrativeArea!,
  //         if (place.country != null &&
  //             !place.country!.contains("+") &&
  //             place.country!.isNotEmpty)
  //           place.country!,
  //       ];

  //       address.value = addressParts.join(", "); // Construct clean address
  //       postalCode.value = place.postalCode ?? "";
  //       setLoading = false;
  //       return {
  //         "statusCode": 200,
  //         "address": address.value,
  //         "postalCode": postalCode.value,
  //         "latitude": latitude.value,
  //         "longitude": longitude.value,
  //       };
  //     } else {
  //       setLoading = false;
  //       return {"statusCode": 400, "error": "No address found"};
  //     }
  //   } catch (e) {
  //     setLoading = false;
  //     return {"statusCode": 400, "error": e.toString()};
  //   }
  // }

//   import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:geolocator/geolocator.dart';

  Future<Map<String, dynamic>> getCurrentLocation() async {
    try {
      setLoading = true;

      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          throw Exception("Location permissions are permanently denied.");
        }
      }

      // Define location settings
      LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.best, // High precision
        distanceFilter: 10, // Minimum movement in meters before update
      );

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      latitude.value = position.latitude;
      longitude.value = position.longitude;

      // Reverse Geocode using OpenStreetMap (Nominatim API)
      String url =
          "https://nominatim.openstreetmap.org/reverse?lat=${position.latitude}&lon=${position.longitude}&format=json";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent': 'rider/1.0 (chopnowafrica@gmail.com)',
        },
      ).timeout(
        Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException("Reverse Geocoding took too long.");
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data.containsKey("address")) {
          var place = data["address"];

          // Extract relevant address components
          List<String> addressParts = [
            if (place["road"] != null) place["road"],
            if (place["suburb"] != null) place["suburb"],
            if (place["city"] != null) place["city"],
            if (place["state"] != null) place["state"],
            if (place["country"] != null) place["country"],
          ];

          address.value = addressParts.join(", ");
          postalCode.value = place["postcode"] ?? "";

          setLoading = false;
          return {
            "statusCode": 200,
            "address": address.value,
            "postalCode": postalCode.value,
            "latitude": latitude.value,
            "longitude": longitude.value,
          };
        } else {
          setLoading = false;
          return {"statusCode": 400, "error": "No address found"};
        }
      } else {
        setLoading = false;
        return {
          "statusCode": response.statusCode,
          "error": "Failed to fetch address"
        };
      }
    } catch (e) {
      setLoading = false;
      return {"statusCode": 400, "error": e.toString()};
    }
  }
  // create rider

  Future<int?> createRider(String data, String userid) async {
    setLoading = true;
    // String accessToken = box.read("token");

    var url = Uri.parse("$appBaseUrl/api/rider");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? fcm = await messaging.getToken();
      print("FCM Token: $fcm");

      if (fcm == null) {
        print("Error: Unable to get FCM Token");
        return null;
      }
      Map<String, dynamic> requestData = jsonDecode(data);
      requestData['fcm'] = fcm; // Add FCM token to request body
      var response =
          await http.post(url, headers: headers, body: jsonEncode(requestData));
      print(response.body);

      if (response.statusCode == 201) {
        print(response.body);
        var responseData = jsonDecode(response.body);
        var rider = responseData['newCreateRider'];
        var user = responseData['user'];
        print("rider: $rider");

        // Save data to GetStorage
        box.write('riderId', rider['riderId']);
        box.write('vehicleType', rider['vehicle']);
        box.write('rating', rider['rating']);
        box.write('postalcode', rider['postalcode']);
        box.write('verification', rider['verification']);
        box.write('coord', rider['coord']);
        box.write('userImagUrl', rider['userImg']);
        box.write('userid', user['_id']);
        box.write('first_name', user['first_name']);
        box.write("last_name", user['last_name']);
        box.write("rating_cont", user['ratingCount']);
        box.write("fcm", fcm);

        setLoading = false;
        return 201; // Return status code 201 for success
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar("creating your rider Unsuccessful", error.message,
            colorText: Tcolor.White,
            duration: const Duration(seconds: 10),
            backgroundColor: Tcolor.BACKGROUND_Regaular,
            icon: const Icon(Icons.error_outline));
        setLoading = false;
      }
    } catch (e) {
      setLoading = false;
      debugPrint(e.toString());
    } finally {
      setLoading = false;
    }
    return null;
  }
}
