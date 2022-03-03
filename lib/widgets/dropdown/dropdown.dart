import 'package:app/configs/colors.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/voucher_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

//     setServiceEndDate(serviceDurationSelected.value);
class IcoDropDown extends StatelessWidget {
  IcoDropDown({
    Key? key,
    required this.selectedValue,
    required this.dropDownList,
    required this.stepFinished,
    this.selectedTextStyle,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  Rxn<String> selectedValue;
  List<String> dropDownList;
  TextStyle? selectedTextStyle;
  String? hintText;
  Rx<bool> stepFinished;
  void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: IcoColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: IcoColors.grey2, width: 1),
        ),
        child: DropdownButton<String>(
          hint: Text(
            hintText!,
            style: IcoTextStyle.mediumTextStyle16G,
          ),
          value: selectedValue.value,
          iconSize: 0,
          isExpanded: true,
          icon: SvgPicture.asset("icons/dropdown_arrow.svg"),
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(height: 0),
          onChanged: onChanged,
          items: dropDownList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              alignment: Alignment.centerLeft,
              value: value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value,
                    style: selectedTextStyle ?? IcoTextStyle.mediumTextStyle16P,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
