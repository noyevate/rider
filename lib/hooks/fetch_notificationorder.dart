import 'dart:convert';

import 'package:get/get.dart';
import 'package:rider/common/size.dart';
import 'package:rider/controllers/order_controller.dart';
import 'package:rider/models/api_error.dart';
import 'package:rider/models/current_trip_order_model.dart';
import 'package:rider/models/hook_models.dart/hook_results.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

FetchHook fetchNotificationOrde(String userId) {
  final box = GetStorage();
  final order =
      useState<CurrentTripOrderModel?>(null); // Changed to OrderModel?
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);
  final orderController = Get.put(OrderController());

  // Using a variable to keep track of whether the hook is disposed
  bool isDisposed = false;

  Future<void> fetchData() async {
    if (isDisposed) return; // Prevent any updates if disposed

    isLoading.value = true;

    try {
      var url = Uri.parse("$appBaseUrl/api/rider/current-trip/$userId");
      final response = await http.get(url);
      print(url);

      if (response.statusCode == 200) {
        var trip = jsonDecode(response.body);
        order.value = CurrentTripOrderModel.fromJson(trip);
        orderController.status.value = order.value!.riderStatus;
        print("Fetch new order status code: ${order.value}");
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      if (!isDisposed) {
        error.value = Exception(e.toString());
        print(error.value);
      }
      print(error.value);
    } finally {
      if (!isDisposed) {
        isLoading.value = false;
      }
    }
  }

  useEffect(() {
    fetchData();

    // Set up a dispose function
    return () {
      isDisposed = true; // Mark as disposed when unmounting
    };
  }, []);

  void refetch() {
    if (!isDisposed) {
      isLoading.value = true;
      fetchData();
    }
  }

  return FetchHook(
    data: order.value, // Now returning a single OrderModel
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
