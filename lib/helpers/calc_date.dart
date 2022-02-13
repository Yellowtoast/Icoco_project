import 'package:app/helpers/formatter.dart';

String calcCertainDateBefore(int duration, String date) {
  DateTime dateTime = dashStringDateToDateTime(date);
  DateTime newDateTime =
      DateTime(dateTime.year, dateTime.month, dateTime.day - duration);
  return dateFormatWithDot.format(newDateTime);
}

int calcDifferenceBetweenDates(String fromDate, String untilDate) {
  DateTime fromDateTime = dashStringDateToDateTime(fromDate);
  DateTime untilDateTime = dashStringDateToDateTime(untilDate);
  int newDateTime =
      int.parse(fromDateTime.difference(untilDateTime).inDays.toString());

  return newDateTime;
}

DateTime dashStringDateToDateTime(String dateString) {
  dateString = dateString.replaceAll(".", "-");
  return DateTime.parse(dateString);
}
