import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/manager_controller.dart';

import 'package:app/controllers/review_controller.dart';
import 'package:app/widgets/loading/loading.dart';
import 'package:app/pages/review/midterm_review.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/modal/exit_icon_modal.dart';
import 'package:app/widgets/modal/option_modal.dart';
import 'package:app/widgets/modal/warning_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/mypage_controller.dart';

class FinalReviewPage extends StatelessWidget {
  FinalReviewPage({Key? key}) : super(key: key);
  ManagerController managerController = Get.find();
  AuthController authController = Get.find();
  MypageController mypageController = Get.find();
  ReviewController reviewController = Get.put(ReviewController(), tag: '1');
  var managerNum = Get.arguments['managerNum'];
  var editReview = Get.arguments['editReview'];
  @override
  Widget build(BuildContext context) {
    if (editReview == true) {
      reviewController.editReview = editReview;
      reviewController.targetUid.value =
          managerController.managerModelList[managerNum].value!.uid;
      reviewController.previousReviewList =
          mypageController.finalReviewModelList!;
      reviewController.reviewType.value = '기말';
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: IcoColors.white,
          appBar: IcoAppbar(
            title: '기말평가',
            usePop: false,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  "${managerController.managerModelList[managerNum].value!.name}",
                                  style: IcoTextStyle.boldTextStyle20P)
                              : SizedBox(),
                          (managerController.managerModelList.length > 1)
                              ? Text("님의 이런부분이 좋았어요!",
                                  style: IcoTextStyle.boldTextStyle17B)
                              : Text("관리사님의 이런부분이 좋았어요!",
                                  style: IcoTextStyle.boldTextStyle17B),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "중복선택",
                            style: IcoTextStyle.mediumTextStyle13P,
                            overflow: TextOverflow.ellipsis,
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
                                  checked: reviewController
                                      .checkedSpecialtiesList
                                      .contains(reviewController
                                          .specialtyTitle[index]),
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
                                      reviewController.checkedSpecialtiesList
                                          .add(reviewController
                                              .specialtyTitle[index]);
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
                                  "${managerController.managerModelList[managerNum].value!.name}",
                                  style: IcoTextStyle.boldTextStyle20P)
                              : SizedBox(),
                          Text("관리자님께 점수를 드리자면",
                              style: IcoTextStyle.boldTextStyle17B),
                        ],
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Obx(() {
                          return RatingBar(
                            ignoreGestures: false,
                            initialRating:
                                reviewController.reviewRate.value.toDouble(),
                            minRating: 1,
                            itemPadding: EdgeInsets.symmetric(horizontal: 7),
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            ratingWidget: RatingWidget(
                              full: SvgPicture.asset('icons/star_full.svg'),
                              half: SvgPicture.asset('icons/star_full.svg'),
                              empty: SvgPicture.asset('icons/star_empty.svg'),
                            ),
                            itemSize: 47,
                            onRatingUpdate: (rating) {
                              reviewController.reviewRate.value =
                                  rating.toInt();
                            },
                          );
                        }),
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
                                  "${managerController.managerModelList[managerNum].value!.name}",
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 37,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text("사진올리기", style: IcoTextStyle.boldTextStyle17B),
                          SizedBox(
                            width: 6,
                          ),
                          Text("${reviewController.imageFileList.length}/5",
                              style: IcoTextStyle.boldTextStyle15Grey4),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 221,
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(() => ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: (reviewController
                                        .imageFileList.isNotEmpty)
                                    ? reviewController.imageFileList.length + 1
                                    : 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: [
                                      (index == 0)
                                          ? SizedBox(
                                              width: 20,
                                            )
                                          : SizedBox(),
                                      Container(
                                        height: 221,
                                        width: 221,
                                        child: (reviewController
                                                    .imageFileList.isEmpty ||
                                                index ==
                                                    reviewController
                                                        .imageFileList.length)
                                            ? InkWell(
                                                onTap: () {
                                                  reviewController.selectFile(
                                                      ImageSource.gallery,
                                                      'manager/profileImage/',
                                                      managerNum);
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'icons/plus.svg',
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      '사진 선택',
                                                      style: IcoTextStyle
                                                          .boldTextStyle15Grey4,
                                                    )
                                                  ],
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Stack(children: [
                                                  Positioned(
                                                    child: Container(
                                                      width: 221,
                                                      height: 221,
                                                      decoration: BoxDecoration(
                                                        color: IcoColors.grey1,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Image.file(
                                                        reviewController
                                                                .imageFileList[
                                                            index]!,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                          Color.fromARGB(
                                                              51, 0, 0, 0),
                                                          Color.fromARGB(
                                                              33, 0, 0, 0),
                                                          Color.fromARGB(
                                                              14, 0, 0, 0),
                                                        ],
                                                            stops: [
                                                          0.1,
                                                          0.2,
                                                          0.3,
                                                        ])),
                                                  ),
                                                  Positioned(
                                                      right: 0,
                                                      child: InkWell(
                                                        onTap: () {
                                                          reviewController
                                                              .imageFileList
                                                              .removeAt(index);
                                                          reviewController
                                                              .imageNameList
                                                              .removeAt(index);
                                                          reviewController
                                                              .imageFileList
                                                              .refresh();
                                                          print(
                                                              "지운 후 이름 리스트  ${reviewController.imageNameList.length}");
                                                          print(
                                                              "지운 후 파일 리스트  ${reviewController.imageFileList.length}");
                                                        },
                                                        child: Container(
                                                          width: 50,
                                                          height: 50,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  16),
                                                          child:
                                                              SvgPicture.asset(
                                                            "icons/exit_icon.svg",
                                                            color: Colors.white,
                                                            fit: BoxFit.none,
                                                          ),
                                                        ),
                                                      )),
                                                ]),
                                              ),
                                        decoration: BoxDecoration(
                                          color: IcoColors.grey1,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: IcoColors.grey2),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      )
                                    ],
                                  );
                                })),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Obx(() => IcoButton(
                    width: IcoSize.width - 40,
                    onPressed: () async {
                      late bool goNext;

                      goNext = await IcoOptionModal(
                          title: '해당 관리자 평가를\n저장하시겠습니까?',
                          subtitle: '평가를 저장한 후에는 수정할 수 없습니다.',
                          option1: '취소',
                          option2: '저장',
                          iconUrl: 'icons/checked.svg');

                      if (goNext) {
                        startLoadingIndicator();
                        if (editReview == false) {
                          await managerController.applyReviewsToManagerModel(
                              reviewController.checkedSpecialtiesList,
                              reviewController.reviewRate.value,
                              managerNum);
                          await reviewController.createFinalReviewFireStore(
                              managerController
                                  .managerModelList[managerNum].value!,
                              authController.userModel.value!,
                              authController
                                  .reservationModel.value!.chosenCompany!,
                              reviewController.reviewContents.value,
                              authController
                                  .reservationModel.value!.reservationNumber);
                        } else {
                          print(reviewController.reviewRate.value);
                          managerController.changeReviewsToManagerModel(
                              reviewController.previousSpecialitesList,
                              reviewController.checkedSpecialtiesList,
                              reviewController.reviewRate.value -
                                  reviewController.previousReviewRate.value,
                              managerNum);
                          await reviewController.deleteFileCloudstorage(
                              reviewController.previousImageUrlList);
                          reviewController.updateFinalReviewFirestore(
                              reviewController.reviewModel.value!.date
                                  .millisecondsSinceEpoch
                                  .toString(),
                              authController.reservationModel.value!.uid);
                        }

                        if (managerNum !=
                            managerController.managerModelList.length - 1) {
                          managerNum++;
                          finishLoadingIndicator();
                          Get.offNamed(Routes.FINAL_REVIEW,
                              arguments: {
                                'managerNum': managerNum,
                                'editReview': editReview
                              },
                              preventDuplicates: false);
                        } else {
                          if (editReview == false) {
                            authController.reservationModel.value!
                                .finalReviewFinished = true;

                            authController.setUserStep(9);
                            await authController.updateReservationFirestore(
                                authController
                                    .reservationModel.value!.reservationNumber);
                          }
                          await authController.setModelInfo();
                          finishLoadingIndicator();
                          Get.offAllNamed(Routes.HOME);
                        }
                      }
                    },
                    active: (reviewController.reviewContents.value != '' &&
                            reviewController
                                .checkedSpecialtiesList.isNotEmpty &&
                            reviewController.reviewRate.value != 0)
                        ? true.obs
                        : false.obs,
                    textStyle: IcoTextStyle.buttonTextStyleW,
                    text: (managerNum !=
                            managerController.managerModelList.length - 1)
                        ? '다음으로'
                        : '기말평가 및 리뷰 등록')),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          )),
    );
  }
}
