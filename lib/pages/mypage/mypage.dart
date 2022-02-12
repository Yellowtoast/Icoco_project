import 'package:app/configs/colors.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/company_controller.dart';
import 'package:app/controllers/manager_controller.dart';
import 'package:app/controllers/mypage_controller.dart';
import 'package:app/controllers/review_controller.dart';
import 'package:app/helpers/loading.dart';
import 'package:app/pages/loading.dart';
import 'package:app/pages/mypage/inquiry_page.dart';
import 'package:app/pages/mypage/my_review.dart';
import 'package:app/pages/mypage/reservation_info/my_reservation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../empty_page.dart';
import 'edit/edit.dart';

class MyPage extends StatelessWidget {
  MyPage({Key? key}) : super(key: key);
  AuthController authController = Get.find();
  ReviewController reviewController = Get.put(ReviewController());
  ManagerController managerController = Get.find();
  MypageController mypageController = Get.find();
  CompanyController companyController = Get.put(CompanyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: IcoSize.width,
            height: IcoSize.height / 3.3,
            color: IcoColors.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "images/empty_profile.png",
                    width: 89,
                    height: 89,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${authController.homeModel.value.userName}님',
                  style: IcoTextStyle.boldTextStyle22W,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  '${authController.homeModel.value.email}',
                  style: IcoTextStyle.mediumTextStyle15W,
                )
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () {
              Get.to(EditUserInfoPage());
            },
            child: SizedBox(
              height: 55,
              width: IcoSize.width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '내 정보 수정하기',
                    style: IcoTextStyle.mediumTextStyle15B,
                  ),
                  SvgPicture.asset('icons/arrow_right1.svg')
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
              if (authController.reservationModel.value == null ||
                  authController.reservationModel.value!.userStep <= 2) {
                Get.to(EmptyInfoPage(
                  appbarText: '나의 예약정보',
                ));
              } else {
                Get.to(MyReservationPage());
              }
            },
            child: SizedBox(
              height: 55,
              width: IcoSize.width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '나의 신청내역',
                    style: IcoTextStyle.mediumTextStyle15B,
                  ),
                  SvgPicture.asset('icons/arrow_right1.svg')
                ],
              ),
            ),
          ),
          Divider(
            color: IcoColors.grey2,
            height: 1,
          ),
          InkWell(
            onTap: () async {
              if (authController.reservationModel.value == null ||
                  authController.reservationModel.value!.managersId!.isEmpty ||
                  authController.reservationModel.value!.finalReviewFinished !=
                      true) {
                Get.to(EmptyInfoPage(
                  appbarText: '평가/후기관리',
                  title: '아직 평가나 후기가 없습니다',
                  subtitle: '서비스 이용을 시작한 후에\n평가나 후기를 작성할 수 있습니다.',
                ));
              } else {
                startLoadingIndicator();
                mypageController.middleReviewModelList =
                    await reviewController.getJsonReviews(
                        authController.reservationModel.value!.uid,
                        'user',
                        0,
                        3,
                        '중간');

                mypageController.finalReviewModelList =
                    await reviewController.getJsonReviews(
                        authController.reservationModel.value!.uid,
                        'user',
                        0,
                        3,
                        '기말');
                await finishLoadingIndicator();
                Get.to(MyReviewPage());
              }
            },
            child: SizedBox(
              height: 55,
              width: IcoSize.width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '평가/후기관리',
                    style: IcoTextStyle.mediumTextStyle15B,
                  ),
                  SvgPicture.asset('icons/arrow_right1.svg')
                ],
              ),
            ),
          ),
          Divider(
            color: IcoColors.grey2,
            height: 1,
          ),
          InkWell(
            onTap: () async {
              if (authController.reservationModel.value == null ||
                  authController.reservationModel.value!.managersId == null ||
                  authController.reservationModel.value!.managersId!.isEmpty) {
                companyController.companyModel.value =
                    await companyController.getFirebaseCompanyByUid(
                        authController.reservationModel.value!.chosenCompany);
                Get.to(InquiryPage());
              } else {
                Get.to(EmptyInfoPage(
                  appbarText: '문의하기',
                  title: '아직 문의를 작성할 수 없습니다',
                  subtitle: '산후조리사를 배정받은 후에\n문의를 작성할 수 있습니다.',
                ));
              }
            },
            child: SizedBox(
              height: 55,
              width: IcoSize.width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '문의하기',
                    style: IcoTextStyle.mediumTextStyle15B,
                  ),
                  SvgPicture.asset('icons/arrow_right1.svg')
                ],
              ),
            ),
          ),
          Divider(
            color: IcoColors.grey2,
            height: 1,
          ),
        ],
      ),
    );
  }
}
