// ignore_for_file: file_names

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/message_format.dart';

var dateFormatWithDot = DateFormat('yyyy.MM.dd');
var dateFormatWithDash = DateFormat('yyyy-MM-dd');
var dateFormatForReservatioNumber = DateFormat('yyMMddHHmmss');
var numFormat = NumberFormat('###,###,###,###');
var phoneNumFormat = NumberFormat('###=###=####');
var phoneNumFormat2 = NumberFormat('###=####=####');

class PhoneNumberTextInputFormatter extends TextInputFormatter {
  String phoneNumFormat(int param) {
    return NumberFormat('###=###=####').format(param);
  }

  String phoneNumFormat2(int param) {
    return NumberFormat('###=####=####').format(param);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    if (newValue.text != '' && (newValue.text.contains('-'))) {
      newText = newValue.text.replaceAll('-', '');
    }
    if (newText.length >= 4) {
      newText = phoneNumFormat(int.parse(newText));
    }
    if (newText.length == 11) {
      newText = phoneNumFormat2(int.parse(newText));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: newText.length),
    );
  }
}
