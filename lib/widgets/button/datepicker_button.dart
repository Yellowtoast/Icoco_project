import 'package:app/configs/colors.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/helpers/format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DatePickerButton extends StatelessWidget {
  DatePickerButton({Key? key, required this.date, this.onTap})
      : super(key: key);

  Rxn<DateTime> date = Rxn<DateTime>();
  void Function()? onTap;
  // var dateFormatForApp = DateFormat('yyyy-MM-dd');
  // var dateFormatForDB = DateFormat('yyyy.MM.dd');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: IcoSize.width,
      child: Obx(() {
        return InkWell(
          onTap: onTap,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 13),
            height: 50,
            width: IcoSize.width,
            decoration: BoxDecoration(
              color: IcoColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: IcoColors.grey2,
                width: 1,
              ),
            ),
            child: Text(
                (date.value == null)
                    ? "YYYY-MM-DD"
                    : dateFormatWithDash.format(date.value!),
                style: (date.value != null)
                    ? IcoTextStyle.mediumTextStyle16B
                    : IcoTextStyle.mediumTextStyle16Grey3),
          ),
        );
      }),
    );
  }
}
