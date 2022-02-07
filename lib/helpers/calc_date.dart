import 'package:app/helpers/format.dart';

String calcCertainDateBefore(int num, String date) {
  var dateTimeString = date.replaceAll(".", "-");
  var dateTime = DateTime.parse(dateTimeString);
  var newDateTime = DateTime(dateTime.year, dateTime.month, dateTime.day - num);
  return dateFormatWithDot.format(newDateTime);
}
