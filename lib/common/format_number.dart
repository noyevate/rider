import 'package:get/get.dart';
import 'package:intl/intl.dart';

String formatNumber(dynamic number) {
  var formatter = NumberFormat('#,###');

  // Handle RxInt, int, and String cases
  int formattedNumber;

  if (number is RxInt) {
    formattedNumber = number.value;
  } else if (number is int) {
    formattedNumber = number;
  } else if (number is String) {
    formattedNumber = int.tryParse(number) ?? 0;
  } else {
    throw ArgumentError('Invalid number type');
  }

  return formatter.format(formattedNumber);
}
