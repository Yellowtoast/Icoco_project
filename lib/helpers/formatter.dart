// ignore_for_file: file_names

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

var dateFormatWithDot = DateFormat('yyyy.MM.dd');
var dateFormatWithDash = DateFormat('yyyy-MM-dd');
var dateFormatForReservatioNumber = DateFormat('yyMMddHHmmss');
var numFormat = NumberFormat('###,###,###,###');

class PhoneNumberTextInputFormatter extends TextInputFormatter {
  String phoneNum10Format(String param) {
    if (param.length < 7) {
      return param.substring(0, 3) + '-' + param.substring(3, param.length);
    } else {
      return param.substring(0, 3) +
          '-' +
          param.substring(3, 6) +
          '-' +
          param.substring(6, param.length);
    }
  }

  String phoneNum11Format(String param) {
    return param.substring(0, 3) +
        '-' +
        param.substring(3, 7) +
        '-' +
        param.substring(7, param.length);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    String formattedText = newText;
    int offset = newText.length;

    if (newValue.text != '' && (newValue.text.contains('-'))) {
      newText = newValue.text.replaceAll('-', '');
      // newText = newText.substring(0, newText.length - 1);
    }

    if (newText.length >= 4) {
      formattedText = phoneNum10Format(newText);
      offset = formattedText.length;
    }

    if (newText.length == 11) {
      formattedText = phoneNum11Format(newText);
      offset = formattedText.length;
    }
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}
