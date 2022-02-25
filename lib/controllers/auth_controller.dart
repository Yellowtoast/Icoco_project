import 'dart:convert';
import 'package:app/configs/purplebook.dart';
import 'package:app/helpers/database.dart';
import 'package:app/configs/routes.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/models/reservation.dart';
import 'package:app/models/user.dart';
import 'package:app/pages/loading.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final RxBool admin = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rxn<String> reservationNumber = Rxn<String>();
  late CollectionReference userDoc;
  Rxn<User> firebaseAuthUser = Rxn<User>();
  Rxn<UserModel> userModel = Rxn<UserModel>();
  Rxn<ReservationModel> reservationModel = Rxn<ReservationModel>();
  RxBool isJustLoaded = true.obs;
  bool isMarketingAllowed = false;
  late Rxn<dynamic> homeModel;
  Rx<bool> openPopup = false.obs;
  Rx<bool> isLoggedIn = true.obs;

  @override
  void onReady() async {
    ever(firebaseAuthUser, handleAuthChanged);
    firebaseAuthUser.bindStream(user);

    super.onReady();
  }

  Future<User> get getUser async => _auth.currentUser!;
  Stream<User?> get user => _auth.authStateChanges();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // handleAuthChanged(_firebaseAuthUser) async {
  //   startLoadingIndicator();
  //   if (_firebaseAuthUser != null &&
  //       (reservationModel.value != null || userModel.value != null)) {
  //     return;
  //   }

  //   if (_firebaseAuthUser == null) {
  //     Get.offAllNamed(Routes.START);
  //   } else {
  //     await setModelInfo();
  //     finishLoadingIndicator();
  //     Get.offAllNamed(Routes.HOME);
  //   }
  // }

  handleAuthChanged(_firebaseAuthUser) async {
    startLoadingIndicator();
    if (_firebaseAuthUser != null &&
        (reservationModel.value != null || userModel.value != null) &&
        isLoggedIn.value == false) {
      return;
    }

    if (_firebaseAuthUser == null) {
      Get.offAllNamed(Routes.START);
    } else {
      if (isLoggedIn.value == true) {
        await setModelInfo();

        isLoggedIn.value = true;
        Get.offAllNamed(Routes.HOME);
      }
    }
    finishLoadingIndicator();
  }

  // handleAuthChanged(_firebaseAuthUser) async {
  //   startLoadingIndicator();
  //   if (_firebaseAuthUser == null || userModel.value == null) {
  //     isLoggedIn.value = false;
  //   } else {
  //     isLoggedIn.value = true;
  //   }
  //   // if (_firebaseAuthUser != null &&
  //   //     (reservationModel.value != null || userModel.value != null)) {
  //   //   return;
  //   // }
  //   if (isLoggedIn.value == false) {
  //     Get.offAllNamed(Routes.START);
  //   } else {
  //     await setModelInfo();
  //     finishLoadingIndicator();
  //     Get.offAllNamed(Routes.HOME);
  //   }
  // }

  setModelInfo() async {
    try {
      userModel.value = await getFirestoreUser(await getUser);
      reservationModel.value =
          await getFirebaseReservationByUid(userModel.value!.uid);
      await storeModelInLocalStorage();
    } catch (e) {
      await Get.offAllNamed(Routes.START);
    }
  }

  storeModelInLocalStorage() async {
    userBox = await Hive.openBox<UserModel>('userModel');
    reservationBox = await Hive.openBox<ReservationModel>('reservationModel');
    await reservationBox.clear();
    await userBox.clear();

    if (reservationModel.value != null) {
      userBox.put('userModel', userModel.value!);
      reservationBox.put('reservationModel', reservationModel.value!);
      homeModel = reservationModel;
      openPopup.value = reservationModel.value!.openPopup!;
    } else {
      userBox.put('userModel', userModel.value!);
      homeModel = userModel;
    }
  }

  //Streams the firestore user from the firestore collection
  Stream<UserModel> streamFirestoreUser() {
    if (kDebugMode) {
      print(
          '${firebaseAuthUser.value!.email} : auth컨트롤러에 있는 streamFireStore firebaseAuth 잘 실행됨');
    }

    if (kDebugMode) {
      print("user stream init");
    }
    return db
        .doc('/User/${firebaseAuthUser.value!.email}')
        .snapshots()
        .map((snapshot) => UserModel.fromJson(snapshot.data()!));
  }

  //get the firestore user from the firestore collection
  Future<UserModel?> getFirestoreUser(User? authUser) {
    return db.doc('/User/${authUser!.email}').get().then(
        (documentSnapshot) => UserModel.fromJson(documentSnapshot.data()!));
  }

  Future<ReservationModel?> getFirebaseReservationByUid(String uid) async {
    ReservationModel? _reservationModel;

    try {
      var querySnapshot =
          await db.collection('Reservation').where('uid', isEqualTo: uid).get();

      querySnapshot.docs.forEach((doc) async {
        if (doc.data()['uid'] == uid && doc.data()['userStep'] != 0) {
          _reservationModel = ReservationModel.fromJson(doc.data());
        }
      });
      return _reservationModel;
    } catch (e) {
      print('$e : getFirebaseReservationByUid 실패');
    }
  }

  Future<ReservationModel?> setPreviousReservation(
      String reservationNumber, String userUid, String email) async {
    ReservationModel? _previousModel;

    var querySnapshot = await db
        .collection('Reservation')
        .where('reservationNumber', isEqualTo: reservationNumber)
        .get();

    querySnapshot.docs.forEach((doc) async {
      if (doc.data()['status'] != '서비스종료') {
        await db.collection('Reservation').doc(reservationNumber).update({
          'email': email,
          'uid': userUid,
          'reservationRoute': '앱',
        });
      }
    });
  }

  //Method to handle user sign in using email and password
  signInWithEmailAndPassword(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      emailController.clear();
      passwordController.clear();
    } catch (error) {}
  }

  // //handles updating the user when updating profile
  // Future<void> updateUser(BuildContext context, UserModel user, String oldEmail,
  //     String password) async {
  //   try {
  //     try {
  //       await _auth
  //           .signInWithEmailAndPassword(email: oldEmail, password: password)
  //           .then((_firebaseUser) {
  //         _firebaseUser.user!
  //             .updateEmail(user.email)
  //             .then((value) => updateUserFirestore(user, _firebaseUser.user!));
  //       });
  //     } catch (err) {
  //       print('Caught error: $err');

  //       if (err ==
  //           "Error: [firebase_auth/email-already-in-use] The email address is already in use by another account.") {
  //       } else {}
  //     }
  //   } on PlatformException catch (error) {
  //     print(error.code);
  //     String authError;
  //     switch (error.code) {
  //       case 'ERROR_WRONG_PASSWORD':
  //         authError = 'auth.wrongPasswordNotice'.tr;
  //         break;
  //       default:
  //         authError = 'auth.unknownError'.tr;
  //         break;
  //     }
  //   }
  // }

  //유저정보를 firestore에 updqte
  void updateUserFirestore(UserModel? user) {
    db.doc('/User/${user!.email}').update(user.toJson());
    update();
  }

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
    } on FirebaseAuthException catch (error) {
      // hideLoadingIndicator();

    }
  }

  // isAdmin() async {
  //   await getUser.then((user) async {
  //     DocumentSnapshot adminRef =
  //         await db.collection('admin').doc(user.uid).get();
  //     if (adminRef.exists) {
  //       admin.value = true;
  //     } else {
  //       admin.value = false;
  //     }
  //     update();
  //   });
  // }

  Stream<ReservationModel> streamFirestoreReservation() {
    print('streamFirestoreReservation()');
    return db
        .doc('/Reservation/${reservationNumber.value}')
        .snapshots()
        .map((snapshot) => ReservationModel.fromJson(snapshot.data()!));
  }

  Future<void> createReservationFirestore(
    UserModel userModel,
    String address,
    String? fullRegNum,
    int userStep,
    String voucher,
  ) async {
    reservationNumber.value =
        dateFormatForReservatioNumber.format(DateTime.now());
    ReservationModel _newReservationModel = ReservationModel(
      address: address,
      email: userModel.email,
      isMarketingAllowed: userModel.eventAlarm,
      userName: userModel.userName,
      phone: userModel.phone,
      fullRegNum: fullRegNum,
      uid: userModel.uid,
      userStep: userStep,
      date: DateTime.now().millisecondsSinceEpoch,
      reservationNumber: reservationNumber.value!,
      reservationRoute: '앱',
      isFinishedBalance: '입금 전',
      isFinishedDeposit: '입금 전',
      voucher: voucher,
    );
    reservationModel.value = _newReservationModel;

    db
        .doc('/Reservation/${reservationNumber.value}')
        .set(_newReservationModel.toJson());
    update();
  }

  setUserStep(int stepToSet) {
    reservationModel.value!.userStep = stepToSet;
  }

  updateReservationFirestore(String reservationNumber) async {
    db.doc('/Reservation/$reservationNumber').set(reservationModel.toJson());
    update();
  }

  updateSingleDataFirestore(
      String reservationNumber, Map<String, dynamic> data) async {
    db.doc('/Reservation/$reservationNumber').update(data);
    update();
  }

  Future<void> deleteUser(String uid) async {
    String token;
    try {
      var url = Uri.parse(
        'https://icoco2022-erpweb.vercel.app/api/deleteUser',
      );
      final jwt = JWT(
        {
          "uid": uid,
        },
      );
      token = jwt.sign(SecretKey(JWT_KEY));

      var response = await http.delete(
        url,
        headers: {'x-access-token': token},
      );

      print(response);
      var res = jsonDecode(response.body);
      var code = response.statusCode;
      print(res);

      if (res['success'] == false) {
        print('회원 탈퇴 실패 : $code/${res['message']}');
      }
    } catch (e) {
      print('회원 탈퇴 실패 : 클라이언트 오류');
    }
  }

  Future<void> signOut() {
    userModel.value = null;
    reservationModel.value = null;
    return _auth.signOut();
  }

  changeUsername(String newName, String uid) {}
}
