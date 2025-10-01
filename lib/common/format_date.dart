import 'package:intl/intl.dart';

String formatDate(String isoDate) {
  DateTime date = DateTime.parse(isoDate);
  String day = date.day.toString();
  String suffix;

  if (day.endsWith('1') && day != '11') {
    suffix = 'st';
  } else if (day.endsWith('2') && day != '12') {
    suffix = 'nd';
  } else if (day.endsWith('3') && day != '13') {
    suffix = 'rd';
  } else {
    suffix = 'th';
  }

  final DateFormat monthYearFormatter = DateFormat('MMMM yyyy');
  String formattedDate = '$day$suffix, ${monthYearFormatter.format(date)}';

  return formattedDate;
}
