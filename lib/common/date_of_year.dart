import 'package:intl/intl.dart';

String getFormattedDate() {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('EEE, dd MMM yyyy');
  return formatter.format(now);
}
