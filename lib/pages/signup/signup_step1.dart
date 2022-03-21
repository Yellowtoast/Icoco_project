import 'dart:ui';

import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/terms.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/button/small_text_button.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/modal/option_modal.dart';

class SignupStep1Page extends StatefulWidget {
  const SignupStep1Page({Key? key}) : super(key: key);

  @override
  State<SignupStep1Page> createState() => _SignupStep1PageState();
}

class _SignupStep1PageState extends State<SignupStep1Page> {
  List<String> _checkIconAsset = ["icons/unchecked.svg", "icons/checked.svg"];
  int _isAllChecked = 0;
  @override
  Widget build(BuildContext context) {
    int pageNum = 1;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: IcoAppbar(title: '회원가입'),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 27,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '약관동의',
                      style: IcoTextStyle.boldTextStyle24B,
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: IcoColors.purple1,
                      ),
                      width: 57,
                      height: 31,
                      child: Text("$pageNum/3",
                          style: GoogleFonts.notoSans(
                              fontSize: 13,
                              color: IcoColors.primary,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 27,
              ),
              Container(
                height: 176,
                width: double.infinity,
                color: IcoColors.grey1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(IcoPolicyBrain.icoPolicyTitle,
                          style: GoogleFonts.notoSans(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 7,
                      ),
                      Text(IcoPolicyBrain.icoPolicyBody1,
                          style: GoogleFonts.notoSans(
                              fontSize: 12, fontWeight: FontWeight.normal)),
                      SizedBox(
                        height: 9,
                      ),
                      Text(IcoPolicyBrain.icoPolicyBody2,
                          style: GoogleFonts.notoSans(
                              color: IcoColors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 52,
                      child: Container(
                        width: 335,
                        height: 1,
                        color: IcoColors.grey2,
                      ),
                    ),
                    ExpansionTile(
                      textColor: IcoColors.black,
                      iconColor: IcoColors.black,
                      tilePadding: EdgeInsets.only(left: 8),
                      title: Transform.translate(
                          offset: Offset(-34, 0),
                          child: Text(
                            "전체 약관동의",
                            style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.bold),
                          )),
                      leading: IconButton(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(0),
                          icon: SvgPicture.asset(
                            _checkIconAsset[(_isAllChecked == 5) ? 1 : 0],
                            width: 21,
                            height: 21,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_isAllChecked >= 0 && _isAllChecked < 5) {
                                _isAllChecked = 5;
                                policyCheckList.forEach((key, value) {
                                  policyCheckList[key] = true;
                                });

                                print(_isAllChecked);
                              } else if (_isAllChecked == 5) {
                                _isAllChecked = 0;
                                policyCheckList.forEach((key, value) {
                                  policyCheckList[key] = false;
                                });
                                print(_isAllChecked);
                              }
                            });
                          }),
                      children: policyCheckList.keys.map((String key) {
                        return Container(
                          // margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (policyCheckList[key] == true) {
                                        // _isChecked = true;
                                        policyCheckList[key] = false;
                                        _isAllChecked--;
                                        print(_isAllChecked);
                                      } else {
                                        // _isChecked = false;
                                        policyCheckList[key] = true;
                                        _isAllChecked++;
                                        print(_isAllChecked);
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        _checkIconAsset[
                                            (policyCheckList[key] == true)
                                                ? 1
                                                : 0],
                                        width: 21,
                                        height: 21,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        child: Text.rich(
                                          TextSpan(
                                            text: key,
                                            style: GoogleFonts.notoSans(
                                                color: IcoColors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: (key == '중요정보 푸시서비스 동의')
                                                    ? ' (선택)'
                                                    : ' (필수)',
                                                style: GoogleFonts.notoSans(
                                                    fontSize: 13,
                                                    color: IcoColors.primary,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SmallTextButton(),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IcoButton(
                        active: (_isAllChecked == 5) ? true.obs : false.obs,
                        buttonColor: IcoColors.primary,
                        textStyle: IcoTextStyle.buttonTextStyleW,
                        text: "다음으로",
                        onPressed: () {
                          // Get.dialog(CupertinoAlertDialog(
                          //   title: Text(
                          //     "'아이코코'에서 알림을 보내고자 합니다.",
                          //   ),
                          //   content: const Text(
                          //       '경고, 사운드 및 아이콘 배지가 알림에 포함될 수 있습니다. 설정에서 이를 구성할 수 있습니다.'),
                          //   actions: <CupertinoDialogAction>[
                          //     CupertinoDialogAction(
                          //       child: const Text(
                          //         '허용안함',
                          //       ),
                          //       onPressed: () {
                          //         Get.back();
                          //       },
                          //     ),
                          //     CupertinoDialogAction(
                          //       child: const Text('허용',style: TextStyle(color: ),),
                          //       isDestructiveAction: true,
                          //       onPressed: () {
                          //         // Do something destructive.
                          //       },
                          //     )
                          //   ],
                          // ));

                          Get.toNamed(Routes.SIGNUP_STEP2);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
