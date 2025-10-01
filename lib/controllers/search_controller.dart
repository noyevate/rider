import 'dart:convert';

import 'package:rider/models/restaurant_search.dart';
import 'package:get/get.dart';
import '../common/size.dart';
import 'package:http/http.dart' as http;

class RestaurantSearchController extends GetxController {
  var searchResults = <RestaurantSearch>[].obs;
  var isLoading = false.obs;

  Future<void> fetchSearchResults(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      isLoading.value = true;
      final url = Uri.parse('$appBaseUrl/api/rider/search?title=$query');
      print(query);
      final response = await http.get(url);
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<RestaurantSearch> data =
            jsonData.map((item) => RestaurantSearch.fromJson(item)).toList();

        searchResults.assignAll(data);
      } else {
        searchResults.clear();
      }
    } catch (e) {
      searchResults.clear();
      print("Error fetching search results: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
