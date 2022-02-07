class UserModel {
  String uid;
  final String email;
  final String userName;
  final String phone;
  final String regNum;
  late String fullRegNum;
  late String address;
  late String voucher;
  final bool isMarketingAllowed;
  int userStep;
  String? reservationNumber;

  UserModel({
    required this.uid,
    required this.email,
    required this.userName,
    required this.phone,
    required this.regNum,
    required this.voucher,
    required this.isMarketingAllowed,
    required this.address,
    this.fullRegNum = '',
    this.userStep = 1,
    this.reservationNumber,
  });

  factory UserModel.fromJson(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      userName: data['name'] ?? '',
      phone: data['phone'] ?? '',
      regNum: data['regNum'] ?? '',
      fullRegNum: data['fullRegNum'] ?? '',
      address: data['address'] ?? '',
      userStep: data['userStep'] ?? 1,
      voucher: data['voucher'] ?? '',
      isMarketingAllowed: data['isMarketingAllowed'] ?? false,
      reservationNumber: data['reservationNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": userName,
        "phone": phone,
        "regNum": regNum,
        "fullRegNum": fullRegNum,
        "userStep": userStep,
        "voucher": voucher,
        "isMarketingAllowed": isMarketingAllowed,
        "reservationNumber": reservationNumber
      };
}
