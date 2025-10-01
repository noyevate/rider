// // ignore_for_file: avoid_print

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:http/http.dart' as http;


// FetchSingleRestaurant useFetchRestaurantById(String code) {
//   final restaurants = useState<SingleRestaurantModel?>(null);
//   final isLoading = useState<bool>(false);
//   final error = useState<Exception?>(null);
//   final apiError = useState<ApiError?>(null);

//   Future<void> fetchData() async {
//     isLoading.value = true;

//     try {
//       final  url = Uri.parse("$appBaseUrl/api/restaurant/byId/$code");    
//       // print(url.toString());
//       final response = await http.get(url);
//       // print(response.statusCode);
  
//       if(response.statusCode == 200){
//         var restaurant = jsonDecode(response.body);
//         restaurants.value = SingleRestaurantModel.fromJson(restaurant);
//       } else {
//         apiError.value = apiErrorFromJson(response.body);
//       }
//     } catch (e) {
      
//     debugPrint(e.toString());
  
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   useEffect(() {
//     fetchData();
//     return null;
//   }, []);

//   void refetch() {
//     isLoading.value = true;
//     fetchData();
//   }


//   return FetchSingleRestaurant(
//     data: restaurants.value, 
//     isLoading: isLoading.value, 
//     error: error.value, 
//     refetch: refetch,
//   );
// }