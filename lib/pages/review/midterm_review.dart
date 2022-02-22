import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/manager_controller.dart';
import 'package:app/controllers/mypage_controller.dart';
import 'package:app/controllers/review_controller.dart';
import 'package:app/models/review.dart';
import 'package:app/pages/loading.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MidtermReviewPage extends StatelessWidget {
  MidtermReviewPage({Key? key}) : super(key: key);
  ManagerController managerController = Get.find();
  AuthController authController = Get.find();
  MypageController mypageController = Get.find();
  ReviewController reviewController = Get.put(ReviewController(), tag: '1');
  @override
  Widget build(BuildContext context) {
    int managerNum = Get.arguments['managerNum'];
    var editReview = Get.arguments['editReview'];

    if (editReview == true) {
      reviewController.editReview = editReview;
      reviewController.targetUid.value =
          managerController.managerModelList[managerNum].value!.uid;
      reviewController.previousReviewList =
          mypageController.middleReviewModelList!;
      reviewController.reviewType.value = '중간';
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: IcoColors.white,
        appBar: IcoAppbar(
          title: '예약하기',
          usePop: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 27,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (managerController.managerModelList.length > 1)
                            ? Text(
                                managerController
                                    .managerModelList[managerNum].value!.name,
                                style: IcoTextStyle.boldTextStyle20P)
                            : SizedBox(),
                        Text("관리사님의 이런부분이 좋았어요!",
                            style: IcoTextStyle.boldTextStyle17B),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "중복선택",
                          style: IcoTextStyle.mediumTextStyle13P,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 7,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Obx(() {
                              return IconCheckButton(
                                title: reviewController.specialtyTitle[index],
                                subtitle:
                                    reviewController.specialtySubitle[index],
                                checked: reviewController.checkedSpecialtiesList
                                    .contains(
                                        reviewController.specialtyTitle[index]),
                                onTap: () {
                                  reviewController.checkedSpecialtiesList
                                      .contains(reviewController
                                          .specialtyTitle[index]);
                                  if (reviewController.checkedSpecialtiesList
                                      .contains(reviewController
                                          .specialtyTitle[index])) {
                                    reviewController.checkedSpecialtiesList
                                        .remove(reviewController
                                            .specialtyTitle[index]);
                                  } else {
                                    reviewController.checkedSpecialtiesList.add(
                                        reviewController.specialtyTitle[index]);
                                  }
                                  reviewController.checkedSpecialtiesList
                                      .refresh();
                                },
                              );
                            }),
                            SizedBox(
                              height: 12,
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 41,
              ),
              Divider(
                thickness: 9,
                color: IcoColors.grey1,
              ),
              SizedBox(
                height: 41,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        (managerController.managerModelList.length > 1)
                            ? Text(
                                managerController
                                    .managerModelList[managerNum].value!.name,
                                style: IcoTextStyle.boldTextStyle20P)
                            : SizedBox(),
                        Text("관리사님께 한마디 부탁드려요!",
                            style: IcoTextStyle.boldTextStyle17B),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 225,
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(17, 9, 17, 9),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: IcoColors.grey2,
                            width: 1,
                          )),
                      child: TextField(
                        onChanged: (value) {
                          reviewController.reviewContents.value = value;
                        },
                        controller: reviewController.contentsTextController,
                        keyboardType: TextInputType.multiline,
                        style: IcoTextStyle.mediumTextStyle13B,
                        maxLines: 20,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 21,
                    ),
                  ],
                ),
              ),
              Container(
                width: IcoSize.width - 40,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: IcoColors.grey1,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "작성내용은 리뷰에 노출되지 않고 관리사님께만 전달되며\n소중한 의견은 이후 서비스 향상에 도움이 됩니다 :)",
                  style: IcoTextStyle.mediumTextStyle13B,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 57,
              ),
              Obx(() => IcoButton(
                  width: IcoSize.width - 40,
                  onPressed: () {
                    if (editReview == false) {
                      reviewController.createMidtermReviewFirestore(
                          managerController.managerModelList[managerNum].value!,
                          authController.userModel.value!,
                          authController.reservationModel.value!.chosenCompany!,
                          reviewController.reviewContents.value,
                          authController
                              .reservationModel.value!.reservationNumber);

                      reviewController.setMidtermReviewFirestore(
                          reviewController.reviewModel.value!);
                    } else {
                      reviewController.updateMidtermReviewFirestore(
                          reviewController
                              .reviewModel.value!.date.millisecondsSinceEpoch
                              .toString());
                    }

                    if (managerNum ==
                        managerController.managerModelList.length - 1) {
                      authController
                          .reservationModel.value!.midtermReviewFinished = true;
                      authController.updateReservationFirestore(authController
                          .reservationModel.value!.reservationNumber);
                      Get.offAllNamed(Routes.HOME);
                    } else {
                      managerNum++;
                      Get.offNamed(Routes.MIDTERM_REVIEW,
                          arguments: {
                            'managerNum': managerNum,
                            'editReview': true
                          },
                          preventDuplicates: false);
                    }
                  },
                  active: (reviewController.reviewContents.value != '' &&
                          reviewController.checkedSpecialtiesList.isNotEmpty)
                      ? true.obs
                      : false.obs,
                  textStyle: IcoTextStyle.buttonTextStyleW,
                  text: (managerNum !=
                              managerController.managerModelList.length - 1 &&
                          editReview == true)
                      ? '다음으로'
                      : (editReview == true)
                          ? '중간평가 수정'
                          : '중간평가 등록')),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IconCheckButton extends StatelessWidget {
  IconCheckButton({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.checked,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final String subtitle;
  bool checked;
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: IcoSize.width - 40,
            height: 50,
            decoration: BoxDecoration(
              color: (checked) ? IcoColors.purple1 : IcoColors.white,
              border: Border.all(
                width: 1,
                color: (checked) ? IcoColors.primary : IcoColors.grey2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: IcoTextStyle.boldTextStyle14B,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.left,
                  style: IcoTextStyle.mediumTextStyle14Grey4,
                ),
                Expanded(
                  child: SvgPicture.asset(
                    (checked) ? 'icons/checked.svg' : 'icons/unchecked.svg',
                    width: 24,
                    alignment: Alignment.centerRight,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
