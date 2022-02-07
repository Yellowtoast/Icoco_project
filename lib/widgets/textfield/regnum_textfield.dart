import 'package:app/configs/colors.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class IcoRegNumField extends StatelessWidget {
  IcoRegNumField({
    Key? key,
    required this.frontTextController,
    required this.backTextController,
    required this.frontHintText,
    required this.backHintText,
    this.errorText,
    this.onChanged,
    this.textFieldLabel,
    this.obscureText = false,
    this.isJustLoaded = true,
    this.width = 164,
    this.isErrorTextLabel = true,
  }) : super(key: key);

  final Function(String)? onChanged;
  final TextEditingController? frontTextController;
  final TextEditingController? backTextController;
  final String? frontHintText;
  final String? backHintText;
  final bool obscureText;
  String? textFieldLabel;
  bool isJustLoaded;
  double width;
  bool isErrorTextLabel;
  Rxn<String>? errorText;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
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
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: width,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            obscureText: obscureText,
                            controller: frontTextController,
                            onChanged: onChanged,
                            decoration: InputDecoration(
                              counterText: '',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              hintText: frontHintText,
                              errorText: errorText!.value,
                              hintStyle: IcoTextStyle.mediumTextStyle16Grey3,
                              errorStyle: TextStyle(
                                  height: 0, color: Colors.transparent),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: IcoColors.primary),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: IcoColors.grey2),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 28,
                          child: SvgPicture.asset("icons/line.svg"),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            width: width,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              onTap: () {},
                              maxLength: 7,
                              obscureText: obscureText,
                              controller: backTextController,
                              onChanged: onChanged,
                              decoration: InputDecoration(
                                counterText: '',
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                errorText: errorText!.value,
                                hintText: backHintText,
                                hintStyle: IcoTextStyle.mediumTextStyle16Grey3,
                                errorStyle: TextStyle(
                                    height: 0, color: Colors.transparent),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: IcoColors.primary),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: IcoColors.grey2),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: 90,
                          child: SvgPicture.asset("icons/secureNumIcon.svg"),
                        ),
                      ],
                    ),
                    // SizedBox(
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: IcoSize.width,
            height: 22,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                (errorText!.value != null) ? errorText!.value! : '',
                style: IcoTextStyle.mediumTextStyle13Pink,
              ),
            ),
          )
        ],
      );
    });
  }
}
