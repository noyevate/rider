
import 'package:rider/common/size.dart';
import 'package:rider/models/api_error.dart';
import 'package:rider/models/hook_models.dart/hook_results.dart';
import 'package:rider/models/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchRestaurants(String code) {
  final restaurants = useState<List<RestaurantModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      final url = Uri.parse("$appBaseUrl/api/restaurant/$code");

      final response = await http.get(url);
      print("useFetchRestairants : ${response.statusCode}");
      

      if (response.statusCode == 200) {
        restaurants.value = restaurantModelFromJson(response.body);
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      error.value = e as Exception;
      // error.value = e;  // Correctly set the error state
      debugPrint('Error occurred: $e');  // Print the correct error
    } finally {
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
