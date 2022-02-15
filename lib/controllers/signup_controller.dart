import 'dart:math';
import 'package:app/configs/purplebook.dart';
import 'package:app/controllers/fcm_controller.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/models/reservation.dart';
import 'package:app/models/user.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupController extends GetxController {
  // ignore: unused_field
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String regNum = '';
  FCMController fcmController = Get.find();
  Rxn<UserModel> userModel = Rxn<UserModel>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController authCodeController = TextEditingController();
  Rxn<String> nameErrorText = Rxn<String>();
  Rxn<String> emailErrorText = Rxn<String>();
  Rxn<String> phoneErrorText = Rxn<String>();
  Rxn<String> authCodeErrorText = Rxn<String>();
  Rxn<String> passwordErrorText = Rxn<String>();
  Rxn<String> confirmPasswordErrorText = Rxn<String>();
  Rxn<String> birthErrorText = Rxn<String>();
  Rxn<String> regNumErrorText = Rxn<String>();
  late String phoneNumber;
  RxInt codeSentTimes = 0.obs;
  bool eventAlarm = false;
  bool isDuplicateEmail = false;
  RxBool isButtonValid = false.obs;
  Rxn<bool> isTimeOut = Rxn<bool>();
  Rxn<String> authCode = Rxn<String>();
  Rx<int> timeLeft = 0.obs;
  Rxn<bool> isRightCodeNum = Rxn<bool>();
  late Timer codeTimer;
  RxBool isCodeSent = false.obs;
  RxList<Rxn<String>> errorTextList = RxList<Rxn<String>>();
  RxList<TextEditingController> controllerList =
      RxList<TextEditingController>();
  RxBool codeSendButtonValid = false.obs;
  RxBool showTimer = false.obs;
  @override
  void onReady() async {
    //run every time auth state changes
    ever(emailErrorText, validateButton);
    ever(passwordErrorText, validateButton);
    ever(confirmPasswordErrorText, validateButton);
    ever(nameErrorText, validateButton);
    ever(regNumErrorText, validateButton);
    ever(phoneErrorText, validateButton);
    ever(authCodeErrorText, validateButton);

    super.onReady();
  }

  @override
  void onClose() {
    nameController.clear();
    phoneController.clear();
    confirmPasswordController.clear();
    nameController.clear();
    authCodeController.clear();
    birthController.clear();
    genderController.clear();
    super.onClose();
  }

//auth를 생성하기 전에 중복유저가 있는지 없는지 확인해야 하기 때문에(이메일 하나씩 실시간으로 입력할때마다 확인이 필요함)
//auth가 아닌 store uid를 통해 검색할 수 밖에 없음
  checkDuplicateUser() async {
    if (emailController.value.text.isEmpty) {
      return;
    }

    await db
        .collection('User')
        .doc(emailController.value.text)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      print("This is document Snpshot:  $documentSnapshot");
      print("Is DS exists? $documentSnapshot.exists");

      isDuplicateEmail = documentSnapshot.exists;
      print("컨트롤러 내 이메일 중복 검사 결과 : $isDuplicateEmail");
      refresh();
    });
  }

  Future<String?> getExistingReservationNumber(
      String name, String phone) async {
    String reservationNumber = '';

    try {
      var querySnapshot = await db
          .collection('Reservation')
          .where(
            'phone',
            isEqualTo: phone,
          )
          .get();

      querySnapshot.docs.forEach((doc) {
        if (doc.data()['userName'] == name &&
            doc.data()['phone'] == phone &&
            doc.data()['reservationRoute'] == '전화') {
          print(doc.data()['userName']);
          print(doc.data()['phone']);
          print(doc.data()['reservationRoute']);
          reservationNumber = doc.data()['reservationNumber'];
        }
      });
      return reservationNumber;
    } catch (e) {
      print(e);
    }
  }

  createNewUserModel() {
    regNum = birthController.text + genderController.text;
    UserModel _newUser = UserModel(
      uid: '',
      email: emailController.value.text,
      userName: nameController.value.text,
      phone: phoneController.value.text,
      regNum: regNum,
      eventAlarm: eventAlarm,
      pushAlarm: true,
      fcm: fcmController.fcmToken,
    );
    userModel.value = _newUser;
  }

  // User registration using email and password
  Future<void> registerWithEmailAndPassword(
      UserModel _newUser, String _password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: _newUser.email, password: _password)
          .then((result) async {
        print('uID: ' + result.user!.uid.toString());
        print('email: ' + result.user!.email.toString());

        //auth에 계정을 생성함과 동시에 authController내에 있는 userModel에 값을 할당한다.
        userModel.value = _newUser;
        userModel.value!.uid = result.user!.uid;
        await createUserFirestore(userModel.value);
      });
    } on FirebaseAuthException catch (error) {
      print(error);
    }
  }

  Future<void> createUserFirestore(UserModel? userModel) async {
    await db.doc('/User/${userModel!.email}').set(userModel.toJson());
    update();
  }

  void updateUserFirestore(UserModel? userModel) async {
    db.doc('/User/${userModel!.email}').set(userModel.toJson());
    update();
  }

//verify code sent to user
  validateAuthCode() {
    final value = authCodeController.value.text;
    if (timeLeft.value > 0 && value == authCode.value) {
      showTimer.value = false;
      authCodeErrorText.value = null;
    } else if (value.isEmpty) {
      showTimer.value = true;
      authCodeErrorText.value = null;
    } else {
      showTimer.value = true;
      authCodeErrorText.value = '인증번호가 일치하지 않습니다';
    }
  }

  sendAuthCodeMessage() async {
    try {
      await getNewCodeNum();
      print(authCode);
      late String to = phoneNumber;
      late String text = '아이코코 인증번호 $authCode을 입력해주세요.';
      final jwt = JWT(
        {"to": to, "text": text},
      );
      var token = jwt.sign(SecretKey(JWT_KEY));
      codeSentTimes++;
      var res = await http.get(
        Uri.parse(
          'https://icoco2022-erpweb.vercel.app/api/sendMessage',
        ),
        headers: {'x-access-token': token},
      );
      print(res.statusCode);

      return;
    } catch (e) {
      print(e);
    }
  }

  getNewCodeNum() {
    try {
      List<String> codeNumList = [];

      for (int i = 0; codeNumList.length <= 4; i++) {
        var codeNum = Random().nextInt(10).toString();
        codeNumList.add(codeNum);
      }
      authCode.value = codeNumList.join("");
    } catch (e) {
      print("인증코드 생성 실패");
    }
  }

  void startAuthCodeTimer(int timeOutSecond) {
    showTimer.value = true;
    timeLeft.value = timeOutSecond;
    codeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeLeft.value = timeLeft.value - 1;
      validateAuthCode();
      if (timeLeft.value <= 0) {
        codeTimer.cancel();
        timeLeft.value = 0;
        codeSendButtonValid.value = true;
      }
    });
  }

  validateButton(errorText) {
    var noError = true;
    var notEmpty = true;
    errorTextList.forEach((element) {
      print(element.value);
      if (element.value != null) {
        noError = false;
      }
    });

    controllerList.forEach((controller) {
      if (controller.value.text.isEmpty) {
        notEmpty = false;
      }
    });

    if (noError && notEmpty) {
      isButtonValid.value = true;
    } else {
      isButtonValid.value = false;
    }
  }
}
