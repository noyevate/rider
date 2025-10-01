
import 'package:rider/common/size.dart';
import 'package:rider/models/api_error.dart';
import 'package:rider/models/hook_models.dart/hook_results.dart';
import 'package:rider/models/order_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;


FetchHook useFetchNewRestaurantOrder(String restaurantId, String orderStatus, String paymentStatus, String riderId) {
  final box = GetStorage();
  final order = useState<List<OrderModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  // Using a variable to keep track of whether the hook is disposed
  bool isDisposed = false;

  Future<void> fetchData() async {
    if (isDisposed) return;  // Prevent any updates if disposed

    isLoading.value = true;

    try {
      final url = Uri.parse("$appBaseUrl/api/rider/restaurant_orders/$restaurantId/$orderStatus/$paymentStatus/$riderId");
      final response = await http.get(url);
      print(restaurantId);
      print("Fetch new order status code: ${response.body}");

      if (response.statusCode == 200) {
        if (!isDisposed) {
          order.value = orderModelFromJson(response.body);
        }
      } else {
        if (!isDisposed) {
          apiError.value = apiErrorFromJson(response.body);
        }
      }
    } catch (e) {
      if (!isDisposed) {
        error.value = Exception(e.toString());
      }
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
      isDisposed = true;  // Mark as disposed when unmounting
    };
  }, []);

  void refetch() {
    if (!isDisposed) {
      isLoading.value = true;
      fetchData();
    }
  }

  return FetchHook(
    data: order.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
