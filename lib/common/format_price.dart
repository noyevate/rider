import 'package:intl/intl.dart';

String formatPrice(int price) {
  // Create a NumberFormat instance to add commas as thousand separators
  var formatter = NumberFormat('#,###');

  // Use the format method to apply the formatting
  return formatter.format(price);
}