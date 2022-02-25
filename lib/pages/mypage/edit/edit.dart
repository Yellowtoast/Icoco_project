import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/mypage_controller.dart';
import 'package:app/controllers/signup_controller.dart';
import 'package:app/helpers/validator.dart';
import 'package:app/pages/mypage/edit/edit_phone.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/modal/bottomup_modal2.dart';
import 'package:app/widgets/modal/option_modal.dart';
import 'package:app/widgets/textfield/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'edit_name.dart';

class EditUserInfoPage extends StatelessWidget {
  EditUserInfoPage({Key? key}) : super(key: key);
  AuthController authController = Get.find();
  MypageController mypageController = Get.find();
  @override
  Widget build(BuildContext context) {
    Rxn<String> fullAddress = Rxn<String>();
    if (authController.reservationModel.value != null) {
      fullAddress.value = authController.homeModel.value.address;
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: IcoAppbar(title: '개인정보 수정'),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Obx(() {
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "images/empty_profile.png",
                      width: 152,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  EditTextButton(
                      title: '본명',
                      value: '${authController.homeModel.value.userName}',
                      onTap: () {
                        Get.to(EditNamePage());
                      }),
                  SizedBox(
                    height: 25,
                  ),
                  EditTextButton(
                      title: '휴대폰 번호',
                      value: '${authController.homeModel.value.phone}',
                      onTap: () {
                        Get.to(EditPhonePage());
                      }),
                  SizedBox(
                    height: 25,
                  ),
                  EditTextButton(
                    title: '메일',
                    value: '${authController.homeModel.value.email}',
                    isEditable: false,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  EditTextButton(
                      title: '주소',
                      value: (fullAddress.value == null)
                          ? '주소 없음'
                          : fullAddress.value!.split("/")[0],
                      onTap: () async {
                        var address = await Get.toNamed(Routes.ADDRESS_1,
                            arguments: '수정');
                        fullAddress.value = address;
                      }),
                  SizedBox(
                    height: 9,
                  ),
                  EditTextButton(
                    value: (fullAddress.value == null)
                        ? ''
                        : fullAddress.value!.split("/")[1],
                    isEditable: false,
                  ),
                  SizedBox(
                    height: 62,
                  ),
                  Divider(thickness: 9, color: IcoColors.grey1),
                  SizedBox(
                    height: 45,
                    width: IcoSize.width - 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '이벤트 수신동의',
                          style: IcoTextStyle.mediumTextStyle15B,
                        ),
                        CupertinoSwitch(
                          activeColor: IcoColors.primary,
                          value: mypageController.allowEvent.value,
                          onChanged: (value) {
                            mypageController.allowEvent.value = value;
                            authController.userModel.value!.eventAlarm = value;
                            authController.updateUserFirestore(
                                authController.userModel.value);
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: IcoColors.grey2,
                    height: 1,
                  ),
                  SizedBox(
                    height: 55,
                    width: IcoSize.width - 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '앱 푸쉬알림',
                          style: IcoTextStyle.mediumTextStyle15B,
                        ),
                        CupertinoSwitch(
                          dragStartBehavior: DragStartBehavior.start,
                          activeColor: IcoColors.primary,
                          value: mypageController.allowPushAlarm.value,
                          onChanged: (value) {
                            mypageController.allowPushAlarm.value = value;
                            authController.userModel.value!.pushAlarm = value;
                            authController.updateUserFirestore(
                                authController.userModel.value);
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: IcoColors.grey2,
                    height: 1,
                  ),
                  InkWell(
                    onTap: () async {
                      bool confirm = await IcoOptionModal(
                          title: '계정을 탈퇴하시겠습니까?',
                          subtitle: '탈퇴 시 회원님의 정보는\n모두 영구 삭제됩니다',
                          option1: '닫기',
                          option2: '탈퇴',
                          iconUrl: 'icons/no_girl.svg',
                          iconHeight: 138);
                      if (confirm) {
                        authController
                            .deleteUser(authController.homeModel.value.uid);
                        authController.signOut();
                      }
                    },
                    child: SizedBox(
                      height: 55,
                      width: IcoSize.width - 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '회원탈퇴',
                            style: IcoTextStyle.mediumTextStyle15B,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: IcoColors.grey2,
                    height: 1,
                  ),
                  InkWell(
                    onTap: () {
                      BottomUpModal2(
                          title: "로그아웃 되었습니다",
                          subtitle: "서비스를 이용해주셔서 감사합니다\n다음에 또 이용해주시기바랍니다.",
                          buttonText: "확인",
                          onTap: () async {
                            await authController.signOut();
                          });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 55,
                      color: IcoColors.grey1,
                      width: IcoSize.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '로그아웃',
                            style: IcoTextStyle.mediumTextStyle15B,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: IcoColors.grey2,
                    height: 1,
                  ),
                  SizedBox(height: 30),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class EditTextButton extends StatelessWidget {
  EditTextButton({
    Key? key,
    required this.value,
    this.title,
    this.onTap,
    this.isEditable = true,
  }) : super(key: key);

  String? title;
  String value;
  bool isEditable;

  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (title != null)
            ? Column(
                children: [
                  Text(
                    title!,
                    style: IcoTextStyle.labelTextStyle,
                  ),
                  SizedBox(
                    height: 9,
                  )
                ],
              )
            : SizedBox(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          width: IcoSize.width - 40,
          decoration: BoxDecoration(
              color: IcoColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: IcoColors.grey3,
                width: 1,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: IcoTextStyle.mediumTextStyle16Grey3,
              ),
              (isEditable)
                  ? InkWell(
                      onTap: onTap ?? () {},
                      child: SizedBox(
                        width: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '수정',
                              style: IcoTextStyle.mediumTextStyle15P,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            SvgPicture.asset(
                              'icons/arrow_right1.svg',
                              height: 15,
                              color: IcoColors.primary,
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
