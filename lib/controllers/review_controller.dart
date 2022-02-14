import 'dart:io';
import 'package:app/configs/purplebook.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/manager.dart';
import 'package:app/models/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class ReviewController extends GetxController {
  AuthController authController = Get.find();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late String reservationNum;
  late String userName;
  RxList<File?> totalFileList = RxList<File?>();
  RxList<String?> fileNameList = RxList<String?>();
  RxList<Rxn<ReviewModel>> reviewListWithPicture = RxList<Rxn<ReviewModel>>();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  RxList<firebase_storage.Reference?> storageRefList =
      RxList<firebase_storage.Reference?>();
  RxList<Rxn<ReviewModel>> reviewModelList = RxList<Rxn<ReviewModel>>();
  RxList<Rxn<ReviewModel>>? middleReviewModelList = RxList<Rxn<ReviewModel>>();
  RxList<Rxn<ReviewModel>>? finalReviewModelList = RxList<Rxn<ReviewModel>>();
  Rxn<ReviewModel> reviewModel = Rxn<ReviewModel>();
  TextEditingController contentsTextController = TextEditingController();
  RxList<String> checkedSpecialtiesList = RxList<String>();
  Rx<int> managerNum = 0.obs;
  Rxn<String> searchTarget = Rxn<String>();
  Rxn<String> reviewType = Rxn<String>();
  Rxn<String> targetUid = Rxn<String>();
  Rxn<int> reviewRate = Rxn<int>();
  Rxn<int> totalReviews = Rxn<int>();
  Rxn<int> reviewCount = Rxn<int>();
  List<RxBool> itemSelectStatus = [
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs
  ];

  List<String> specialtyTitle = [
    '정리정돈',
    '가족배려',
    '체형관리',
    '음식솜씨',
    '실전지식',
    '산모케어',
    '신생아케어'
  ];
  List<String> specialtySubitle = [
    "청소를 깔끔하게 잘 하세요",
    "가족들 모두를 만족시켜주세요",
    "체형교정에 많은 도움을 주세요",
    "멋진 식사로 입맛이 살아나요",
    "육아 정보를 많이 알려주세요",
    "산모가 신경쓸 일이 없어요",
    "아이를 사랑으로 대해주세요",
  ];
  Rx<String> reviewContents = ''.obs;

  @override
  void onReady() {
    // ever(managerNum, setPreviousReview);
  }

  setPreviousReview(dynamic modelList, int _managerNum) {
    checkedSpecialtiesList.clear();
    itemSelectStatus.fillRange(0, 6, false.obs);
    for (var element in modelList![_managerNum].value!.specialtyItems!) {
      checkedSpecialtiesList.add(element);
      itemSelectStatus[specialtyTitle.indexOf(element)] = true.obs;
      checkedSpecialtiesList.refresh();
    }

    contentsTextController.text = modelList![_managerNum].value!.contents;
    reviewContents.value = modelList![_managerNum].value!.contents;
  }

  createMidtermReviewFirestore(ManagerModel managerModel, String userName) {
    ReviewModel _newReviewModel = ReviewModel(
      userName: authController.reservationModel.value!.userName,
      userId: authController.reservationModel.value!.uid,
      contents: reviewContents.value,
      managerId: managerModel.uid,
      companyId: authController.reservationModel.value!.chosenCompany!,
      specialtyItems: checkedSpecialtiesList.toList(),
      date: DateTime.now(),
      type: '중간',
    );
    reviewModel.value = _newReviewModel;
    reviewModelList.add(reviewModel);

    checkedSpecialtiesList.clear();
    reviewType.value = null;
    targetUid.value = null;
    itemSelectStatus.forEach((element) {
      element.value = false;
    });
    managerNum.value = 0;
    contentsTextController.text = '';
    reviewContents.value = '';
  }

//기말평가 모델 생성, 관리자 모델에 specialty count 업데이트 해주어야 함
  Future<void> createFinalReviewModel(ManagerModel managerModel) async {
    ReviewModel _newReviewModel = ReviewModel(
      contents: reviewContents.value,
      userId: authController.reservationModel.value!.uid,
      managerId: managerModel.uid,
      thumbnails: [],
      userName: authController.reservationModel.value!.userName,
      specialtyItems: checkedSpecialtiesList.toList(),
      companyId: authController.reservationModel.value!.chosenCompany!,
      date: DateTime.now(),
      type: '기말',
      reviewRate: reviewRate.value,
    );

    reviewModel.value = _newReviewModel;
    reviewType.value = null;
    targetUid.value = null;
    managerNum.value = 0;
    contentsTextController.text = '';
    reviewContents.value = '';
    reviewRate.value = null;
    checkedSpecialtiesList.clear();
    itemSelectStatus.forEach((element) {
      element.value = false;
    });
  }

  updateFinalReviewFirestore(Rxn<ReviewModel> review) async {
    List<String>? imagesURL = await uploadFileStorage(totalFileList);
    review.value!.thumbnails = imagesURL;
    db.collection('Review').add(review.toJson());
    reviewModel.value = null;
    storageRefList.clear();
    fileNameList.clear();
    totalFileList.clear();
    update();
  }

  updateMidtermReviewFirestore(RxList<Rxn<ReviewModel>> reviewModelList) {
    reviewModelList.forEach((review) {
      db.collection('Review').add(review.toJson());
    });
    reviewModelList.clear();

    update();
  }

  getMoreReviews(RxList<Rxn<ReviewModel>> reviewList, String uid,
      String reviewType, String target, int offset, int limitNumber) async {
    int reviewCount = 0;
    RxList<Rxn<ReviewModel>>? addedReviewList =
        await getJsonReviews(uid, target, offset, limitNumber, reviewType);

    if (addedReviewList != null) {
      reviewList.value = [...reviewList, ...addedReviewList].toList();
      reviewCount = reviewList.length;
    }

    reviewList.refresh();
    reviewListWithPicture.refresh();
    return reviewCount;
  }

  Future<RxList<Rxn<ReviewModel>>?> getJsonReviews(String uid, String target,
      int offset, int limitNumber, String reviewType) async {
    Map<dynamic, dynamic> reviewObject;
    List<dynamic> list;
    RxList<Rxn<ReviewModel>> modelList = RxList<Rxn<ReviewModel>>();
    var currentUser = await authController.getUser;
    String userToken = await currentUser.getIdToken();

    // reviewModelList.clear();
    var queryParameters = {
      "uid": uid,
      "target": target,
      "offset": offset.toString(),
      "limitNumber": limitNumber.toString(),
      "type": reviewType
    };

    try {
      var uri = Uri.http(
          'icoco2022-erpweb.vercel.app', '/api/getReviews', queryParameters);

      var response = await http.get(
        uri,
        headers: {'x-access-token': userToken},
      );
      var json = jsonDecode(response.body);
      reviewObject = json['data'].cast<String, dynamic>();
      totalReviews.value = reviewObject['total'];
      list = reviewObject['reviewList'];
      for (var reviewData in list) {
        var res = reviewData.cast<dynamic, dynamic>();
        Rxn<ReviewModel> model = Rxn<ReviewModel>();
        model.value = ReviewModel.fromJson(res);
        modelList.add(model);
      }

      return modelList;
    } catch (e) {
      print('리뷰 불러오기 실패, null 배열 리턴');
      return null;
    }
  }

  extractFirstIndexPictures(
      int totalReview,
      String uid,
      String target,
      int offset,
      int limitNumber,
      String reviewType,
      RxList<Rxn<ReviewModel>>? reviewListWithPicture) async {
    var modelList =
        await getJsonReviews(uid, target, 0, totalReview, reviewType);
    if (modelList != null && modelList.isNotEmpty) {
      for (var model in modelList) {
        if (model.value!.thumbnails != null &&
            model.value!.thumbnails!.isNotEmpty &&
            reviewListWithPicture!.length <= 5) {
          reviewListWithPicture.add(model);
        }
      }
    }
    reviewListWithPicture!.refresh();
  }

  Future<String?> selectFile(
      ImageSource inputSource, String uploadPath, int managerNum) async {
    final picker = ImagePicker();
    List<XFile>? pickedImages;
    try {
      pickedImages = await picker.pickMultiImage(imageQuality: 70);

      for (var image in pickedImages!) {
        totalFileList.add(File(image.path));
        fileNameList.add(path.basename(image.path));
      }

      totalFileList.refresh();

      try {} on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<List<String>?> uploadFileStorage(
      RxList<File?> fileListForModel) async {
    String? downloadURL;
    List<String> reviewImageURL = [];
    try {
      for (var fileName in fileNameList) {
        storageRefList.add(storage.ref("review/$fileName"));
      }
      for (int i = 0; i < fileListForModel.length; i++) {
        firebase_storage.UploadTask uploadTask = storageRefList[i]!.putFile(
            fileListForModel[i]!,
            firebase_storage.SettableMetadata(customMetadata: {
              'uploaded_by': userName,
              'description': reservationNum,
            }));

        downloadURL = await (await uploadTask).ref.getDownloadURL();
        reviewImageURL.add(downloadURL);
      }
      return reviewImageURL.toList();
    } catch (e) {
      return [];
    }
  }
}
