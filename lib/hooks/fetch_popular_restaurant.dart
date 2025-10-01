// ignore_for_file: avoid_print


import 'package:rider/common/size.dart';
import 'package:rider/models/api_error.dart';
import 'package:rider/models/hook_models.dart/hook_results.dart';
import 'package:rider/models/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchPopularRestaurants() {
  final restaurants = useState<List<RestaurantModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      final url = Uri.parse("$appBaseUrl/api/restaurant/popular");

      final response = await http.get(url);
      print("useFetchPopularRestairants : ${response.statusCode}");
      print("useFetchPopularRestairants : ${response.body}");
      

      if (response.statusCode == 200) {
        restaurants.value = restaurantModelFromJson(response.body);
        print("restaurants.value : ${restaurants.value}");
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
  if (e is Exception) {
    error.value = e; // Assign only if it's an Exception
  } else {
    error.value = Exception('Unknown error: $e'); // Wrap non-Exception errors in an Exception
  }
  debugPrint('Error occurred: $e');
}finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    data: restaurants.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
