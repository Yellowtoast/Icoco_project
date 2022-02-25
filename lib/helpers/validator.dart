import 'package:get/get.dart';

final RegExp koreanRegExp = RegExp(r'[\uac00-\ud7af]', unicode: true);
final RegExp numberRegExp = RegExp(r'^[0-9]');
final RegExp alphabetRegExp = RegExp(r'[a-zA-Z]');
final RegExp specialRegExp = RegExp(r'^[_\-=@,\.;]+$');
final RegExp passwordRegExp =
    RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,12}$');

final RegExp phoneRegExp =
    RegExp(r'^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$');

validateEmail(
    String email, Rxn<String> emailErrorText, bool isDuplicateEmail) async {
  if (email.isEmpty) {
    emailErrorText.value = null;
  } else if (!GetUtils.isEmail(email)) {
    emailErrorText.value = '올바른 이메일 형식이 아닙니다';
  } else if (isDuplicateEmail) {
    emailErrorText.value = "이미 가입된 이메일입니다";
  } else {
    emailErrorText.value = null;
  }
}

validatePassword(
    String password, Rxn<String> passwordErrorText, RxBool stepCheck) {
  if (password.isEmpty) {
    stepCheck.value = false;
    passwordErrorText.value = null;
  } else if (!passwordRegExp.hasMatch(password)) {
    stepCheck.value = false;
    passwordErrorText.value = '8~12자 / 영문숫자조합';
  } else {
    stepCheck.value = true;
    passwordErrorText.value = null;
  }
}

validateConfirmPassword(String confirmPassword, String password,
    Rxn<String> confirmPasswordErrorText, RxBool stepCheck) {
  if (confirmPassword.isEmpty) {
    stepCheck.value = false;
    confirmPasswordErrorText.value = null;
  } else if (password != confirmPassword) {
    stepCheck.value = false;
    confirmPasswordErrorText.value = '비밀번호가 다릅니다';
  } else {
    stepCheck.value = true;
    confirmPasswordErrorText.value = null;
  }
}

validateName(String name, Rxn<String> nameErrorText) {
  if (name.isEmpty) {
    nameErrorText.value = null;
  } else if (koreanRegExp.allMatches(name).length != name.length) {
    nameErrorText.value = '이름을 정확히 입력해주세요';
  } else if (alphabetRegExp.hasMatch(name) || numberRegExp.hasMatch(name)) {
    nameErrorText.value = '한글만 입력 가능합니다';
  } else {
    nameErrorText.value = null;
  }
}

validateRegNum(String birth, String gender, Rxn<String> regNumErrorText) {
  if (birth.isEmpty && gender.isEmpty) {
    regNumErrorText.value = null;
  } else if (!numberRegExp.hasMatch(birth) && !numberRegExp.hasMatch(gender)) {
    regNumErrorText.value = '숫자만 입력 가능합니다';
  } else {
    regNumErrorText.value = null;
  }
}

validatePhoneNumber(
    String phone, RxBool codeSendButtonValid, Rxn<String> phoneErrorText) {
  phone = phone.replaceAll('-', '');
  if (phone.isEmpty) {
    codeSendButtonValid.value = false;
    phoneErrorText.value = null;
  } else if (!phoneRegExp.hasMatch(phone)) {
    codeSendButtonValid.value = false;
    phoneErrorText.value = '번호를 정확히 입력해주세요';
  } else {
    codeSendButtonValid.value = true;
    phoneErrorText.value = null;
  }
}

validateFullRegNum(
    String frontRegNum, String backRegNum, Rxn<String> fullRegNumErrorText) {
  if (backRegNum == '' && frontRegNum == '') {
    fullRegNumErrorText.value = null;
  } else if (frontRegNum.length != 6 || backRegNum.length != 7) {
    fullRegNumErrorText.value = '주민번호를 모두 입력해주세요';
  } else {
    fullRegNumErrorText.value = null;
  }
}
