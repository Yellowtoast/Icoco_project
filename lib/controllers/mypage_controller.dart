import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MypageController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  RxBool allowEvent = false.obs;
  RxBool allowPushAlarm = false.obs;
  AuthController authController = Get.find();
  Rxn<dynamic> model = Rxn<dynamic>();
  List<String> addressList = [];
  RxList<ReviewModel>? middleReviewModelList = RxList<ReviewModel>();
  RxList<ReviewModel>? finalReviewModelList = RxList<ReviewModel>();
  Rxn<User> firebaseAuthUser = Rxn<User>();

  @override
  Future<void> onInit() async {
    firebaseAuthUser.value = await authController.getUser;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void updateUserInfoFireStore(Map<String, dynamic> userInfo) {
    db.doc('/User/${firebaseAuthUser.value!.email}').update(userInfo);
    update();
  }

  getMyPreviousReview(
      String reservationNumber, String userUid, String reviewType) async {
    ReviewModel _previousModel;
    RxList<ReviewModel> _myReviewList = RxList<ReviewModel>();

    var querySnapshot = await db
        .collection('Review')
        .where('reservationNumber', isEqualTo: reservationNumber)
        .get();

    for (var doc in querySnapshot.docs) {
      if (doc.data()['type'] == reviewType && doc.data()['userId'] == userUid) {
        _previousModel = ReviewModel.fromJson(doc.data());

        print({'before', _previousModel.contents});
        _myReviewList.add(_previousModel);
        print({'after', _previousModel.contents});

        print(_myReviewList[0].contents);
      }
    }
    for (var review in _myReviewList) {
      print(review.contents);
    }
    return _myReviewList;
  }
}
