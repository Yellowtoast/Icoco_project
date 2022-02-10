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
import 'package:flutter/services.dart';
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

  Future<User> get getUser async => _auth.currentUser!;
  Stream<User?> get user => _auth.authStateChanges();

  @override
  void onReady() async {
    ever(firebaseAuthUser, handleAuthChanged);
    firebaseAuthUser.bindStream(user);

    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  handleAuthChanged(_firebaseAuthUser) async {
    startLoadingIndicator();
    if (_firebaseAuthUser != null &&
        (reservationModel.value != null || userModel.value != null)) {
      return;
    }

    if (_firebaseAuthUser == null) {
      Get.offAllNamed(Routes.START);
    } else {
      await setModelInfo();
      finishLoadingIndicator();
      Get.offAllNamed(Routes.HOME);
    }
  }

  setModelInfo() async {
    userModel.value = await getFirestoreUser(await getUser);
    reservationModel.value =
        await getFirebaseReservationModel(userModel.value!.uid);
    await storeModelInLocalStorage();
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

  Future<ReservationModel?> getFirebaseReservationModel(String uid) async {
    ReservationModel? reservationModel;

    try {
      if (uid != "") {
        var doc = await db
            .collection('Reservation')
            .where('uid', isEqualTo: uid)
            .get();
        print(doc.docs[0].data());
        reservationModel = ReservationModel.fromJson(doc.docs[0].data());
        return reservationModel;
      }
    } catch (e) {
      return null;
    }
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

  //handles updating the user when updating profile
  Future<void> updateUser(BuildContext context, UserModel user, String oldEmail,
      String password) async {
    try {
      try {
        await _auth
            .signInWithEmailAndPassword(email: oldEmail, password: password)
            .then((_firebaseUser) {
          _firebaseUser.user!
              .updateEmail(user.email)
              .then((value) => updateUserFirestore(user, _firebaseUser.user!));
        });
      } catch (err) {
        print('Caught error: $err');

        if (err ==
            "Error: [firebase_auth/email-already-in-use] The email address is already in use by another account.") {
        } else {}
      }
    } on PlatformException catch (error) {
      print(error.code);
      String authError;
      switch (error.code) {
        case 'ERROR_WRONG_PASSWORD':
          authError = 'auth.wrongPasswordNotice'.tr;
          break;
        default:
          authError = 'auth.unknownError'.tr;
          break;
      }
    }
  }

  //유저정보를 firestore에 updqte
  void updateUserFirestore(UserModel? user, User? _firebaseUser) {
    db.doc('/User/${_firebaseUser!.email}').update(user!.toJson());
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

  Future<void> createReservationFirestore(UserModel userModel) async {
    reservationNumber.value =
        dateFormatForReservatioNumber.format(DateTime.now());
    ReservationModel _newReservationModel = ReservationModel(
      address: '',
      email: userModel.email,
      isMarketingAllowed: userModel.isMarketingAllowed,
      userName: userModel.userName,
      phone: userModel.phone,
      fullRegNum: '',
      uid: userModel.uid,
      userStep: userModel.userStep,
      date: DateTime.now().millisecondsSinceEpoch,
      reservationNumber: reservationNumber.value!,
      reservationRoute: '앱',
      isFinishedBalance: '입금 전',
      isFinishedDeposit: '입금 전',
    );
    reservationModel.value = _newReservationModel;

    db
        .doc('/Reservation/${reservationNumber.value}')
        .set(_newReservationModel.toJson());
    update();
  }

  setUserStep(int currentStep) {
    reservationModel.value!.userStep = currentStep;
  }

  updateReservationFirestore(String reservationNumber) async {
    db.doc('/Reservation/$reservationNumber').set(reservationModel.toJson());
    update();
  }

  Future<void> deleteUser(String uid) async {
    String token;
    try {
      var url = Uri.parse(
        'http://172.30.1.22:3000/api/deleteUser',
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
