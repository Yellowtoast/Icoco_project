import 'dart:io';
import 'package:app/configs/colors.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/manager.dart';
import 'package:app/models/review.dart';
import 'package:app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ReviewController extends GetxController {
  AuthController authController = Get.find();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late String reservationNum;
  late String userName;
  RxList<File?> imageFileList = RxList<File?>();
  RxList<String?> imageNameList = RxList<String?>();
  RxList<Rxn<ReviewModel>> reviewListWithPicture = RxList<Rxn<ReviewModel>>();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  RxList<firebase_storage.Reference?> storageRefList =
      RxList<firebase_storage.Reference?>();
  RxList<ReviewModel> previousReviewList = RxList<ReviewModel>();
  RxList<Rxn<ReviewModel>>? middleReviewModelList = RxList<Rxn<ReviewModel>>();
  RxList<Rxn<ReviewModel>>? finalReviewModelList = RxList<Rxn<ReviewModel>>();
  Rxn<ReviewModel> reviewModel = Rxn<ReviewModel>();
  TextEditingController contentsTextController = TextEditingController();
  RxList<String> checkedSpecialtiesList = RxList<String>();
  RxList<String> previousSpecialitesList = RxList<String>();
  List<dynamic> previousImageUrlList = [];
  Rx<int> managerNum = 0.obs;
  Rxn<String> searchTarget = Rxn<String>();
  Rxn<String> reviewType = Rxn<String>();
  Rxn<String> targetUid = Rxn<String>();
  Rx<int> reviewRate = 0.obs;
  Rx<int> previousReviewRate = 0.obs;
  Rxn<int> totalReviews = Rxn<int>();
  Rxn<int> reviewCount = Rxn<int>();
  bool editReview = false;

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
  Future<void> onReady() async {
    if (editReview == true) {
      await setPreviousReview(
          previousReviewList, targetUid.value!, reviewType.value!);
    }
    super.onReady();
  }

  setPreviousReview(RxList<ReviewModel> reviewModelList, String managerUid,
      String reviewType) {
    late ReviewModel _reviewModel;
    for (var element in reviewModelList) {
      if (element.managerId == managerUid) {
        _reviewModel = element;
        reviewModel.value = _reviewModel;
      }
    }
    checkedSpecialtiesList.clear();
    previousSpecialitesList.clear();
    for (var element in _reviewModel.specialtyItems!) {
      checkedSpecialtiesList.add(element);
      previousSpecialitesList.add(element);
    }

    contentsTextController.text = _reviewModel.contents;
    reviewContents.value = _reviewModel.contents;

    if (reviewType == '기말') {
      reviewRate.value = _reviewModel.reviewRate!;
      previousReviewRate.value = _reviewModel.reviewRate!;
      previousImageUrlList = _reviewModel.thumbnails!;
      imageFileList.clear();
      imageNameList.clear();
      previousImageUrlList.forEach((url) async {
        print('convert 전');
        print(url);
        var imageMap = await convertUrlToFile(url);
        imageFileList.add(imageMap['file']);
        imageNameList.add(imageMap['fileName']);
      });
      imageFileList.refresh();
    }
    checkedSpecialtiesList.refresh();
  }

  convertUrlToFile(String url) async {
    print('convert 시작');
    print(url);
    final http.Response responseData = await http.get(Uri.parse(url));

    var uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    File file = await File('${tempDir.path}/$fileName').writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return {'file': file, 'fileName': fileName};
  }

  createMidtermReviewFirestore(ManagerModel managerModel, UserModel userModel,
      String companyUid, String contents, String reservationNumber) {
    ReviewModel _newReviewModel = ReviewModel(
        userName: userModel.userName,
        userId: userModel.uid,
        contents: contents,
        managerId: managerModel.uid,
        companyId: companyUid,
        specialtyItems: checkedSpecialtiesList.toList(),
        date: DateTime.now(),
        type: '중간',
        reservationNumber: reservationNumber);
    reviewModel.value = _newReviewModel;
    // reviewModelList.add(reviewModel);
    setMidtermReviewFirestore(_newReviewModel);
    checkedSpecialtiesList.clear();
    reviewType.value = null;
    targetUid.value = null;

    contentsTextController.text = '';
    reviewContents.value = '';
  }

//기말평가 모델 생성, 관리자 모델에 specialty count 업데이트 해주어야 함
  Future<void> createFinalReviewFireStore(
      ManagerModel managerModel,
      UserModel userModel,
      String companyUid,
      String contents,
      String reservationNumber) async {
    List<String>? imagesURL = await uploadFileCloudstorage(
        imageFileList, userModel.uid, imageNameList);
    ReviewModel _newReviewModel = ReviewModel(
        contents: contents,
        userId: userModel.uid,
        managerId: managerModel.uid,
        thumbnails: imagesURL,
        userName: authController.reservationModel.value!.userName,
        specialtyItems: checkedSpecialtiesList.toList(),
        companyId: companyUid,
        date: DateTime.now(),
        type: '기말',
        reviewRate: reviewRate.value,
        reservationNumber: reservationNumber);

    setFinalReviewFirestore(_newReviewModel);

    reviewModel.value = _newReviewModel;
    reviewType.value = null;
    targetUid.value = null;
    managerNum.value = 0;
    contentsTextController.text = '';
    reviewContents.value = '';
    reviewRate.value = 0;
    checkedSpecialtiesList.clear();
    storageRefList.clear();
    imageNameList.clear();
    imageFileList.clear();
  }

  updateFinalReviewFirestore(String documentNumber, String userId) async {
    List<String>? imagesURL =
        await uploadFileCloudstorage(imageFileList, userId, imageNameList);
    await db.doc('/Review/$documentNumber').update({
      'thumbnails': imagesURL,
      'contents': reviewContents.value,
      'specialtyItems': checkedSpecialtiesList,
      'reviewRate': reviewRate.value,
    });
    storageRefList.clear();
    imageNameList.clear();
    imageFileList.clear();
    update();
  }

  setFinalReviewFirestore(ReviewModel reviewModel) async {
    await db
        .doc('/Review/${reviewModel.date.millisecondsSinceEpoch}')
        .set(reviewModel.toJson());
    update();
  }

  setMidtermReviewFirestore(ReviewModel reviewModel) {
    db
        .doc('/Review/${reviewModel.date.millisecondsSinceEpoch}')
        .set(reviewModel.toJson());
    update();
  }

  updateMidtermReviewFirestore(String documentNumber) {
    db.doc('/Review/$documentNumber').update({
      'contents': reviewContents.value,
      'specialtyItems': checkedSpecialtiesList
    });
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

  selectFile(ImageSource inputSource, String uploadPath, int managerNum) async {
    final picker = ImagePicker();
    List<XFile>? pickedImages;

    try {
      pickedImages = await picker.pickMultiImage(imageQuality: 60);
      if (pickedImages == null) {
        Get.snackbar('선택된 이미지가 없습니다', '첨부된 이미지가 없습니다',
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            backgroundColor: Color.fromARGB(168, 0, 0, 0),
            colorText: IcoColors.white,
            borderRadius: 5,
            duration: Duration(milliseconds: 1600));
        return;
      } else if ((pickedImages.length + imageFileList.length) > 5) {
        Get.snackbar('최대 5개 이미지만 선택 가능', '5개 이하의 이미지를 첨부해주세요',
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            backgroundColor: Color.fromARGB(168, 0, 0, 0),
            colorText: IcoColors.white,
            borderRadius: 5,
            duration: Duration(milliseconds: 1600));
        return;
      }
      pickedImageToFile(pickedImages);
    } catch (err) {
      print('image selection failed');
    }
  }

  pickedImageToFile(List<XFile>? pickedImages) {
    for (var image in pickedImages!) {
      imageFileList.add(File(image.path));
      imageNameList
          .add(path.basename(DateTime.now().microsecondsSinceEpoch.toString()));
    }
    print("추가한 후 이름 리스트  ${imageNameList.length}");
    print("추가한 후 파일 리스트  ${imageFileList.length}");

    imageFileList.refresh();
  }

  Future<List<String>?> uploadFileCloudstorage(
      RxList<File?> fileList, String uid, RxList<String?> fileNameList) async {
    String? downloadURL;
    List<String> reviewImageURL = [];
    try {
      for (var fileName in fileNameList) {
        storageRefList.add(storage.ref("review/$fileName"));
      }
      for (int i = 0; i < fileList.length; i++) {
        firebase_storage.UploadTask uploadTask = storageRefList[i]!.putFile(
            fileList[i]!,
            firebase_storage.SettableMetadata(customMetadata: {
              'uid': uid,
            }));

        downloadURL = await (await uploadTask).ref.getDownloadURL();
        reviewImageURL.add(downloadURL);
      }
      storageRefList.clear();
      imageFileList.clear();
      fileNameList.clear();
      return reviewImageURL.toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> deleteFileCloudstorage(List<dynamic?> thumbnailUrls) async {
    try {
      if (thumbnailUrls.isNotEmpty) {
        thumbnailUrls.forEach((url) {
          var fileRef = storage.refFromURL(url!);
          fileRef.delete().then((value) => print('file deleted'));
        });
      }
    } catch (e) {
      print('cloud storage delete failed');
    }
  }
}
