import 'package:rider/hooks/fetch_trip_history.dart';
import 'package:rider/models/trip_history_model.dart';
import 'package:rider/shimer/trip_history_shimer.dart';
import 'package:rider/views/trips/widget/subwidgets/history_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class TripHistoryList extends HookWidget {
  const TripHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final riderId = box.read("userid"); 

    final hookResult = useFetchTripHistory(riderId);
    final List<TripHistoryModel> tripHistory = hookResult.data ?? [];
    final bool isLoading = hookResult.isLoading;
    final Exception? error = hookResult.error;


    return isLoading ? TripHistoryShimer(): Column(
        children: List.generate(tripHistory.length, (index) {
          var trip = tripHistory[index];
          return HistoryTile(trip: trip);
        }),
      );
    
  }
}