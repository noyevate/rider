import 'dart:convert';

import 'package:rider/models/address_model.dart';
import 'package:rider/models/api_error.dart';
import 'package:rider/models/rider_rating.dart';
import 'package:rider/models/single_restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../common/size.dart';
import 'package:http/http.dart' as http;

class HomepageController extends GetxController {
  final box = GetStorage();

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool newValue) {
    _isLoading.value = newValue;
  }

  Future<SingleRestaurantModel> fetchResturant(String id) async {
    setLoading = true;

    var url = Uri.parse("$appBaseUrl/api/restaurant/byId/$id");

    try {
      var response = await http.get(url);
        // print("Response Body: ${response.body}"); // Add this line to see the raw response

      if (response.statusCode == 200) {
        setLoading = false;

        var data =
            json.decode(response.body); // Assuming the API response is JSON
        if (data == null || data.isEmpty) {
          throw Exception('Empty or null response data');
        }
        return SingleRestaurantModel.fromJson(
            data); // Return a single restaurant model
      } else {
        var error = apiErrorFromJson(response.body);
        print(error);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setLoading = false;
    }
    throw Exception('Failed to fetch restaurant');
  }

  Future<AddressModel> fetchAddress(String id) async {
    setLoading = true;

    var url = Uri.parse("$appBaseUrl/api/address/$id");

    try {
      var response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        setLoading = false;

        var data =
            json.decode(response.body); // Assuming the API response is JSON
        return AddressModel.fromJson(data); // Return a single restaurant model
      } else {
        var error = apiErrorFromJson(response.body);
        // print(error);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setLoading = false;
    }
    throw Exception('Failed to fetch address');
  }

  Future<Rating> fetchRating(String orderId, String riderId) async {
    setLoading = true;

    var url = Uri.parse("$appBaseUrl/api/rider_rating/rider-rating/$orderId/$riderId");

    try {
      var response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        setLoading = false;

        var data =
            json.decode(response.body); // Assuming the API response is JSON
        return Rating.fromJson(data); // Return a single restaurant model
      } else {
        var error = apiErrorFromJson(response.body);
        // print(error);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setLoading = false;
    }
    throw Exception('Failed to fetch rting');
  }
}
