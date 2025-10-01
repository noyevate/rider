import 'package:intl/intl.dart';

String formatTime(String isoDate) {
  DateTime date = DateTime.parse(isoDate);
  final DateFormat timeFormatter = DateFormat('h:mm a');
  return timeFormatter.format(date);
}
