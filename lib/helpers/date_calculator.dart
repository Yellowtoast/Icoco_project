import 'package:app/helpers/formatter.dart';

String calcCertainDateBefore(int duration, String date) {
  DateTime dateTime = dashStringDateToDateTime(date);
  DateTime newDateTime =
      DateTime(dateTime.year, dateTime.month, dateTime.day - duration);
  return dateFormatWithDot.format(newDateTime);
}

int calcDifferenceBetweenDates(String fromDate, String dateNow) {
  DateTime fromDateTime = dashStringDateToDateTime(fromDate);
  DateTime untilDateTime = dashStringDateToDateTime(dateNow);
  int newDateTime = 0;
  if (untilDateTime.isAfter(fromDateTime)) {
    newDateTime =
        int.parse(fromDateTime.difference(untilDateTime).inDays.toString());
  }

  return newDateTime;
}

int calcYearFromNow(String fromDate) {
  DateTime fromDateTime = dashStringDateToDateTime(fromDate);
  DateTime untilDateTime = DateTime.now();
  int year = 0;

  year = untilDateTime.difference(fromDateTime).inDays ~/ 365 + 1;
  if (year == 0) {
    year = 1;
  }

  return year;
}

DateTime dashStringDateToDateTime(String dateString) {
  dateString = dateString.replaceAll(".", "-");
  return DateTime.parse(dateString);
}
