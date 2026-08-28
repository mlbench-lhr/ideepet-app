import 'package:intl/intl.dart';

String formatMonthYear(DateTime? date) {
  if (date == null) return '';
  return DateFormat('MM/yyyy').format(date);
}

String formatDayMonthYear(DateTime? date) {
  if (date == null) return '';
  return DateFormat('dd/MM/yy').format(date);
}

String formatDayMonthYearFull(DateTime? date) {
  if (date == null) return '';
  return DateFormat('dd/MM/yyyy').format(date);
}

String formatDateTimeToUTC(DateTime? dateTime) {
  if (dateTime == null) return '';
  return dateTime.toUtc().toIso8601String();
}

DateTime parseUTCToDateTime(String dateTimeString) {
  return DateTime.parse(dateTimeString).toUtc();
}

DateTime parseDateToUtc(String date) {
  List<String> parts = date.split('/');
  return DateTime.utc(
    int.parse(parts[2]),
    int.parse(parts[1]),
    int.parse(parts[0]),
  );
}
