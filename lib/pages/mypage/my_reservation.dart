import 'package:app/configs/colors.dart';
import 'package:app/configs/enum.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/mypage_controller.dart';
import 'package:app/helpers/url_launcher.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_4.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/loading/loading.dart';
import 'my_review.dart';

class MyReservationPage extends StatelessWidget {
  MyReservationPage({Key? key}) : super(key: key);
  AuthController authController = Get.find();
  MypageController mypageController = Get.find();

  @override
  Widget build(BuildContext context) {
    RxList<dynamic> careRankingEnumList = [
      carePriority.CLEANING,
      carePriority.CLEANING,
      carePriority.CLEANING,
      carePriority.CLEANING
    ].obs;

    if (authController.reservationModel.value!.careRanking != null &&
        authController.reservationModel.value!.careRanking!.isNotEmpty) {
      var careRanking = authController.reservationModel.value!.careRanking;
      print(careRanking);

      // careRankingEnumList[0] = carePriority.MOTHERCARE;
      print(careRanking);
      for (var element in careRanking!) {
        print(element);
        print(element.compareTo('산모케어'));
        print('');
        switch (element.toString()) {
          case '정리정돈':
            careRankingEnumList[careRanking.indexOf('정리정돈')] =
                carePriority.CLEANING;
            break;
          case '요리':
            careRankingEnumList[careRanking.indexOf('요리')] =
                carePriority.COOKING;
            break;
          case '산모케어':
            print('산모케어 리스트에 있음');
            careRankingEnumList[careRanking.indexOf('산모케어')] =
                carePriority.MOTHERCARE;
            break;
          case '신생아케어':
            careRankingEnumList[careRanking.indexOf('신생아케어')] =
                carePriority.BABYCARE;
            break;
          default:
        }
      }
    } else {
      careRankingEnumList = [].obs;
    }

    return Scaffold(
      appBar: IcoAppbar(title: '나의 신청내역'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 27,
              ),
              Container(
                width: IcoSize.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '내 예약정보 확인',
                      style: IcoTextStyle.boldTextStyle24B,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '본명',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          authController.reservationModel.value!.userName,
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '서비스 이용주소',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            authController.reservationModel.value!.address,
                            style: IcoTextStyle.regularTextStyle13Grey4,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 9,
                height: 9,
                color: IcoColors.grey1,
              ),
              Container(
                width: IcoSize.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '출산일 (예정일)',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          (authController.reservationModel.value!.birthDate ==
                                  '')
                              ? '입력안함'
                              : authController
                                  .reservationModel.value!.birthDate!,
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '출산형태',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          (authController.reservationModel.value!.birthType ==
                                  '')
                              ? '입력안함'
                              : authController
                                  .reservationModel.value!.birthType!,
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '병원이용여부',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          (authController.reservationModel.value!.useHospital ==
                                  true)
                              ? '예'
                              : (authController.reservationModel.value!
                                          .useHospital ==
                                      null)
                                  ? '입력안함'
                                  : '아니오',
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '병원입원',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          (authController.reservationModel.value!
                                      .hospitalEndDate ==
                                  '')
                              ? '입력안함'
                              : authController
                                  .reservationModel.value!.hospitalEndDate!,
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '조리원이용여부',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          (authController
                                      .reservationModel.value!.useCareCenter ==
                                  true)
                              ? '예'
                              : (authController.reservationModel.value!
                                          .useCareCenter ==
                                      null)
                                  ? '입력안함'
                                  : '아니오',
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '조리원이용일',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          (authController.reservationModel.value!
                                      .careCenterEndDate ==
                                  '')
                              ? '입력안함'
                              : "${authController.reservationModel.value!.careCenterStartDate} ~ ${authController.reservationModel.value!.careCenterEndDate}",
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 9,
                height: 9,
                color: IcoColors.grey1,
              ),
              Container(
                width: IcoSize.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '서비스시작일',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          (authController.reservationModel.value!
                                      .serviceStartDate ==
                                  '')
                              ? '입력안함'
                              : authController
                                  .reservationModel.value!.serviceStartDate!,
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '이용기간',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          (authController.reservationModel.value!
                                      .serviceStartDate ==
                                  '')
                              ? '입력안함'
                              : "${authController.reservationModel.value!.serviceStartDate} ~ ${authController.reservationModel.value!.serviceEndDate}",
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '수유형태',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          (authController
                                      .reservationModel.value!.lactationType ==
                                  '')
                              ? '입력안함'
                              : authController
                                  .reservationModel.value!.lactationType!,
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '조리장소',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          (authController.reservationModel.value!
                                      .placeToBeServiced ==
                                  '')
                              ? '입력안함'
                              : authController
                                  .reservationModel.value!.placeToBeServiced!,
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '애완동물',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          (authController.reservationModel.value!.animalType ==
                                  '')
                              ? '입력안함'
                              : authController
                                  .reservationModel.value!.animalType!,
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '선호순위',
                          style: IcoTextStyle.boldTextStyle13B,
                        ),
                        SizedBox(
                          height: 11,
                        ),
                        Row(
                          children: [
                            OrderSelectionButton(
                              width: IcoSize.width / 2 - 20 - 4,
                              onTap: () {},
                              icon: SvgPicture.asset("icons/cleaning_icon.svg"),
                              selectionList: careRankingEnumList,
                              selectionType: carePriority.CLEANING,
                              text: '정리정돈',
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            OrderSelectionButton(
                              width: IcoSize.width / 2 - 20 - 4,
                              onTap: () {},
                              icon: SvgPicture.asset("icons/cooking_icon.svg"),
                              selectionList: careRankingEnumList,
                              selectionType: carePriority.COOKING,
                              text: '요리',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            OrderSelectionButton(
                              width: IcoSize.width / 2 - 20 - 4,
                              onTap: () {},
                              icon: SvgPicture.asset(
                                  "icons/mother_caring_icon.svg"),
                              selectionList: careRankingEnumList,
                              selectionType: carePriority.MOTHERCARE,
                              text: '산모케어',
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            OrderSelectionButton(
                              width: IcoSize.width / 2 - 20 - 4,
                              onTap: () {},
                              icon: SvgPicture.asset(
                                  "icons/baby_caring_icon.svg"),
                              selectionList: careRankingEnumList,
                              selectionType: carePriority.BABYCARE,
                              text: '신생아케어',
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 34,
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 9,
                height: 9,
                color: IcoColors.grey1,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 34,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '기타 요청사항',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            (authController
                                        .reservationModel.value!.requirement ==
                                    '')
                                ? '입력안함'
                                : authController
                                    .reservationModel.value!.requirement!,
                            style: IcoTextStyle.regularTextStyle13Grey4,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '서비스 이용주소',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            authController.reservationModel.value!.address,
                            style: IcoTextStyle.regularTextStyle13Grey4,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 9,
                height: 9,
                color: IcoColors.grey1,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '케어형태',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          (authController.reservationModel.value!.careType ==
                                  '')
                              ? '입력안함'
                              : authController
                                  .reservationModel.value!.careType!,
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '자녀',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '미취학 아동 ${authController.reservationModel.value!.allAdditionalFamily!['kindergartener']}명',
                              style: IcoTextStyle.regularTextStyle13Grey4,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '유치원/어린이집 ${authController.reservationModel.value!.allAdditionalFamily!['kindergartener']}명',
                              style: IcoTextStyle.regularTextStyle13Grey4,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '초등생 ${authController.reservationModel.value!.allAdditionalFamily!['schooler']}명',
                              style: IcoTextStyle.regularTextStyle13Grey4,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '기타가족',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          '기타가족 ${authController.reservationModel.value!.allAdditionalFamily!['extraFamily']}명',
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45,
                    ),
                  ],
                ),
              ),
              IcoButton(
                  width: IcoSize.width - 40,
                  onPressed: () async {
                    startLoadingIndicator();
                    mypageController.middleReviewModelList =
                        await mypageController.getMyPreviousReview(
                            authController
                                .reservationModel.value!.reservationNumber,
                            authController.reservationModel.value!.uid,
                            '중간');
                    mypageController.finalReviewModelList =
                        await mypageController.getMyPreviousReview(
                            authController
                                .reservationModel.value!.reservationNumber,
                            authController.reservationModel.value!.uid,
                            '기말');
                    finishLoadingIndicator();
                    Get.to(MyReviewPage());
                  },
                  active: true.obs,
                  buttonColor: IcoColors.primary,
                  textStyle: IcoTextStyle.buttonTextStyleW,
                  text: '담당 관리사님 확인하기'),
              SizedBox(
                height: 10,
              ),
              IcoButton(
                  leadingIcon: true,
                  iconColor: IcoColors.white,
                  width: IcoSize.width - 40,
                  onPressed: () {
                    // UrlLauncher().call()
                  },
                  active: true.obs,
                  textStyle: IcoTextStyle.buttonTextStyleW,
                  text: '고객센터에 수정요청'),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
