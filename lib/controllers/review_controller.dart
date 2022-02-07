// import 'dart:io';
// import 'package:app/configs/purplebook.dart';
// import 'package:app/controllers/manager_controller.dart';
// import 'package:app/models/manager.dart';
// import 'package:app/models/review.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart' as path;
// import 'dart:convert';

// import 'package:image_picker/image_picker.dart';

// class ReviewController extends GetxController {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   late String reservationNum;
//   late String userName;
//   RxList<RxList<File?>> totalFileList =
//       RxList<RxList<File?>>.generate(3, (index) => RxList<File?>());
//   firebase_storage.FirebaseStorage storage =
//       firebase_storage.FirebaseStorage.instance;
//   RxList<firebase_storage.Reference?> storageRefList =
//       RxList<firebase_storage.Reference?>();
//   RxList<Rxn<ReviewModel>> reviewModelList = RxList<Rxn<ReviewModel>>();
//   Rxn<ReviewModel> reviewModel = Rxn<ReviewModel>();
//   TextEditingController contentsTextController = TextEditingController();
//   RxList<String> checkedSpecialtiesList = RxList<String>();
//   Rx<int> managerNum = 0.obs;
//   Rxn<String> searchTarget = Rxn<String>();
//   Rxn<String> reviewType = Rxn<String>();
//   Rxn<String> targetUid = Rxn<String>();
//   Rxn<int> reviewRate = Rxn<int>();
//   List<RxBool> itemSelectStatus = [
//     false.obs,
//     false.obs,
//     false.obs,
//     false.obs,
//     false.obs,
//     false.obs,
//     false.obs
//   ];

//   List<String> specialtyTitle = [
//     '정리정돈',
//     '가족배려',
//     '체형관리',
//     '음식솜씨',
//     '실전지식',
//     '산모케어',
//     '신생아케어'
//   ];
//   List<String> specialtySubitle = [
//     "청소를 깔끔하게 잘 하세요",
//     "가족들 모두를 만족시켜주세요",
//     "체형교정에 많은 도움을 주세요",
//     "멋진 식사로 입맛이 살아나요",
//     "육아 정보를 많이 알려주세요",
//     "산모가 신경쓸 일이 없어요",
//     "아이를 사랑으로 대해주세요",
//   ];
//   Rx<String> reviewContents = ''.obs;

//   @override
//   onInit() async {
//     super.onInit();
//   }

//   @override
//   onClose() {
//     super.onClose();
//   }

//   Future<void> createMidtermReviewFirestore(ManagerModel managerModel) async {
//     ReviewModel _newReviewModel = ReviewModel(
//       contents: reviewContents.value,
//       managerId: managerModel.uid,
//       name: managerModel.name,
//       specialtyItems: checkedSpecialtiesList,
//       companyId: '',
//       date: DateTime.now(),
//       type: '중간',
//     );
//     reviewModel.value = _newReviewModel;
//     reviewModelList.add(reviewModel);

//     checkedSpecialtiesList.clear();
//     reviewType.value = null;
//     targetUid.value = null;
//     itemSelectStatus.forEach((element) {
//       element.value = false;
//     });
//     managerNum.value = 0;

//     contentsTextController.text = '';
//     reviewContents.value = '';
//   }

// //기말평가 모델 생성, 관리자 모델에 specialty count 업데이트 해주어야 함
//   Future<void> createFinalReviewModel(ManagerModel managerModel) async {
//     ReviewModel _newReviewModel = ReviewModel(
//       contents: reviewContents.value,
//       managerId: managerModel.uid,
//       thumbnails: [],
//       title: (reviewContents.value.length < 30)
//           ? reviewContents.value
//           : reviewContents.value.substring(0, 30),
//       name: managerModel.name,
//       specialtyItems: checkedSpecialtiesList,
//       companyId: '',
//       date: DateTime.now(),
//       type: '기말',
//       reviewRate: reviewRate.value,
//     );
//     reviewModel.value = _newReviewModel;
//     reviewModelList.add(reviewModel);

//     reviewType.value = null;
//     targetUid.value = null;
//     managerNum.value = 0;
//     contentsTextController.text = '';
//     reviewContents.value = '';
//     reviewRate.value = null;
//     checkedSpecialtiesList.clear();
//     itemSelectStatus.forEach((element) {
//       element.value = false;
//     });
//   }

//   updateMidtermReviewFirestore(RxList<Rxn<ReviewModel>> reviewModelList) {
//     reviewModelList.forEach((review) {
//       db.collection('Review').add(review.toJson());
//     });
//     reviewModelList.clear();

//     update();
//   }

//   updateFinalReviewFirestore(
//       Rxn<ReviewModel> reviewModel, int managerIndex) async {
//     List<String>? imagesURL =
//         await uploadFileStorage(totalFileList[managerIndex]);
//     reviewModel.value!.thumbnails = imagesURL;
//     db.collection('Review').add(reviewModel.toJson());
//     update();
//   }

//   getJsonReviews() async {
//     String uid = targetUid.value!;
//     String target = searchTarget.value!;
//     DateTime? lastDatetime;
//     int limitNumber = 3;
//     String type = reviewType.value!;
//     String token;
//     int? totalReviews;
//     Map<dynamic, dynamic> reviewObject;
//     List<dynamic> list;

//     reviewModelList.clear();

//     try {
//       var url = Uri.parse(
//         'https://icoco2022-erpweb.vercel.app/api/getReviews',
//       );
//       final jwt = JWT(
//         {
//           "uid": uid,
//           "target": target,
//           // "lastDatetime": lastDatetime,
//           "limitNumber": limitNumber,
//           "type": type
//         },
//       );
//       token = jwt.sign(SecretKey(JWT_KEY));

//       var response = await http.get(
//         url,
//         headers: {'x-access-token': token},
//       );
//       var json = jsonDecode(response.body);
//       reviewObject = json['data'].cast<String, dynamic>();
//       totalReviews = reviewObject['total'];
//       list = reviewObject['reviewList'];
//       list.forEach((reviewData) {
//         var res = reviewData.cast<dynamic, dynamic>();
//         Rxn<ReviewModel> model = Rxn<ReviewModel>();
//         model.value = ReviewModel.fromJson(res);
//         reviewModelList.add(model);
//       });
//       reviewModelList.refresh();
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<String?> selectFile(
//       ImageSource inputSource, String uploadPath, int managerNum) async {
//     final picker = ImagePicker();
//     List<XFile>? pickedImages;
//     RxList<File?> images = RxList<File?>();
//     RxList<String> fileNameList = RxList<String>();
//     try {
//       pickedImages = await picker.pickMultiImage(
//           // source: inputSource == ImageSource.camera
//           //     ? ImageSource.camera
//           //     : ImageSource.gallery,
//           maxWidth: 1920,
//           imageQuality: 70);

//       pickedImages!.forEach((image) {
//         images.add(File(image.path));

//         fileNameList.add(path.basename(image.path));
//       });
//       totalFileList[managerNum] = images;
//       images.refresh();
//       totalFileList.refresh();

//       try {
//         fileNameList.forEach((fileName) {
//           storageRefList.add(storage.ref("review/$fileName"));
//           // downloadURL = await storage.ref("review/$fileName").getDownloadURL();
//           // reviewImageURL.add(downloadURL);
//         });
//       } on FirebaseException catch (error) {
//         if (kDebugMode) {
//           print(error);
//         }
//       }
//     } catch (err) {
//       if (kDebugMode) {
//         print(err);
//       }
//     }
//   }

//   Future<List<String>?> uploadFileStorage(
//       RxList<File?> fileListForModel) async {
//     String? downloadURL;
//     List<String> reviewImageURL = [];
//     try {
//       for (var image in fileListForModel) {
//         for (var ref in storageRefList) {
//           firebase_storage.UploadTask uploadTask = ref!.putFile(
//               image!,
//               firebase_storage.SettableMetadata(customMetadata: {
//                 'uploaded_by': userName,
//                 'description': reservationNum,
//               }));

//           downloadURL = await uploadTask.then((res) {
//             res.ref.getDownloadURL();
//           });
//           reviewImageURL.add(downloadURL!);
//         }
//       }
//       return reviewImageURL.toList();
//     } catch (e) {
//       return [];
//     }
//   }
// }
import 'dart:io';
import 'package:app/configs/purplebook.dart';
import 'package:app/controllers/manager_controller.dart';
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
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late String reservationNum;
  late String userName;
  RxList<File?> totalFileList = RxList<File?>();
  RxList<String?> fileNameList = RxList<String?>();
  RxList<String?> allThumbnailsForReview = RxList<String?>();
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
  int? totalReviews;
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
    super.onReady();
  }

  Future<void> createMidtermReviewFirestore(
      ManagerModel managerModel, String userName) async {
    ReviewModel _newReviewModel = ReviewModel(
      contents: reviewContents.value,
      managerId: managerModel.uid,
      userName: managerModel.name,
      specialtyItems: checkedSpecialtiesList,
      companyId: '',
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
      managerId: managerModel.uid,
      thumbnails: [],
      userName: managerModel.name,
      specialtyItems: checkedSpecialtiesList,
      companyId: '',
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

  Future<RxList<Rxn<ReviewModel>>?> getJsonReviews(
      String uid, String target, int? reviewOffset, String reviewType) async {
    reviewOffset ??= 1;
    Map<dynamic, dynamic> reviewObject;
    List<dynamic> list;
    String token;
    RxList<Rxn<ReviewModel>> modelList = RxList<Rxn<ReviewModel>>();

    // reviewModelList.clear();

    try {
      var url = Uri.parse(
        'https://icoco2022-erpweb.vercel.app/api/getReviews',
      );
      final jwt = JWT(
        {
          "uid": uid,
          "target": target,
          "limitNumber": reviewOffset,
          "type": reviewType
        },
      );
      token = jwt.sign(SecretKey(JWT_KEY));

      var response = await http.get(
        url,
        headers: {'x-access-token': token},
      );
      var json = jsonDecode(response.body);
      reviewObject = json['data'].cast<String, dynamic>();
      totalReviews = reviewObject['total'];
      list = reviewObject['reviewList'];
      for (var reviewData in list) {
        var res = reviewData.cast<dynamic, dynamic>();
        Rxn<ReviewModel> model = Rxn<ReviewModel>();
        model.value = ReviewModel.fromJson(res);
        modelList.add(model);
      }
      allThumbnailsForReview.value = extractFirstIndexPictures(modelList);
      //  reviewModelList.refresh();
      return modelList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  extractFirstIndexPictures(RxList<Rxn<ReviewModel>> reviewModelList) {
    RxList<String> allFirstIndexThumbnails = RxList<String>();
    reviewModelList.forEach((element) {
      if (element.value != null && element.value!.thumbnails!.isNotEmpty) {
        allFirstIndexThumbnails.add(element.value!.thumbnails![0]);
      }
    });

    return allFirstIndexThumbnails;
  }

  Future<String?> selectFile(
      ImageSource inputSource, String uploadPath, int managerNum) async {
    final picker = ImagePicker();
    List<XFile>? pickedImages;
    try {
      pickedImages = await picker.pickMultiImage(imageQuality: 70);

      pickedImages!.forEach((image) {
        totalFileList.add(File(image.path));
        fileNameList.add(path.basename(image.path));
      });

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
