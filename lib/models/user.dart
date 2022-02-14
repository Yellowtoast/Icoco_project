class UserModel {
  String uid;
  final String email;
  String userName;
  String phone;
  final String regNum;
  int userStep;
  String fcm;
  bool eventAlarm;
  bool pushAlarm;

  UserModel({
    required this.uid,
    required this.email,
    required this.userName,
    required this.phone,
    required this.regNum,
    required this.fcm,
    required this.eventAlarm,
    this.pushAlarm = true,
    this.userStep = 1,
  });

  factory UserModel.fromJson(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      userName: data['name'] ?? '',
      phone: data['phone'] ?? '',
      regNum: data['regNum'] ?? '',
      userStep: data['userStep'] ?? 1,
      fcm: data['fcm'] ?? '',
      eventAlarm: data['eventAlarm'] ?? true,
      pushAlarm: data['pushAlarm'] ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": userName,
        "phone": phone,
        "regNum": regNum,
        "userStep": userStep,
        'fcm': fcm,
        'eventAlarm': eventAlarm,
        'pushAlarm': pushAlarm,
      };
}
