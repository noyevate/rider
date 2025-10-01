
import 'package:flutter/material.dart';

class FetchHook {
  final dynamic data;
  final bool isLoading; // to determin wether our data is loading
  final Exception? error;
  final VoidCallback? refetch;

  FetchHook({
    required this.data,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}