import 'package:app/configs/colors.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class IcoTextField extends StatelessWidget {
  IcoTextField({
    Key? key,
    required this.width,
    this.onChanged,
    this.myTextController,
    this.myValidator,
    this.textFieldLabel = '',
    this.hintText,
    this.obscureText = false,
    this.isJustLoaded = true,
    this.errorText,
    this.isErrorTextLabel = true,
    this.maxLength = 30,
    this.keyboardType = TextInputType.text,
    this.showErrorText = true,
    this.textInputFormatter,
  }) : super(key: key);

  // final GetxController controller;
  final Function(String)? onChanged;
  final String? myValidator;
  var myTextController;
  final String? hintText;
  final bool obscureText;
  String? textFieldLabel;
  Rxn<String>? errorText;
  bool isJustLoaded;
  double width;
  bool isErrorTextLabel;
  int maxLength;
  bool showErrorText;
  TextInputType keyboardType;
  List<TextInputFormatter>? textInputFormatter;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (textFieldLabel != '')
                ? Column(
                    children: [
                      Text(
                        textFieldLabel!,
                        style: IcoTextStyle.labelTextStyle,
                      ),
                      SizedBox(
                        height: 9,
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(
              height: 50,
              width: width,
              child: TextFormField(
                inputFormatters: textInputFormatter,
                keyboardType: keyboardType,
                maxLength: maxLength,
                obscureText: obscureText,
                controller: myTextController,
                onChanged: onChanged,
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  hintText: hintText,
                  hintStyle: IcoTextStyle.mediumTextStyle16Grey3,
                  errorText: errorText!.value,
                  errorStyle: TextStyle(height: 0, color: Colors.transparent),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: IcoColors.primary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: IcoColors.grey2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            (showErrorText)
                ? SizedBox(
                    width: width,
                    height: 22,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        (errorText!.value != null) ? errorText!.value! : '',
                        style: IcoTextStyle.mediumTextStyle13Pink,
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      );
    });
  }
}
