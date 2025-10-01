import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:rider/common/size.dart';
import 'package:rider/models/api_error.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rider/models/api_error.dart';
import 'package:rider/models/hook_models.dart/hook_result.dart';
import 'package:rider/models/order_model.dart';

FetchHook useFetchSingleOrder(String id) {
  final box = GetStorage();
  final order = useState<OrderModel?>(null); // Corrected declaration
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    String accessToken = box.read("token");


    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final url = Uri.parse("$appBaseUrl/api/order/fetch-order/$id");
      final response = await http.get(url, headers: headers);
      print("useFetchSingleOrder: ${response.body}");
      print("I______D: $id");

      if (response.statusCode == 200) {
        var singleOrder = jsonDecode(response.body);
        order.value = OrderModel.fromJson(singleOrder);
        print("useFetchSingleOrder: ${response.statusCode}");
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
      error.value = e is Exception ? e : Exception('Unknown error');
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, []); // Added dependency on id

  void refetch() {
    fetchData();
  }

  return FetchHook(
    data: order.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
