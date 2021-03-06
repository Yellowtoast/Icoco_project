class ReservationModel {
  final int date;
  String uid;
  final String email;

  String phone;
  final String reservationNumber;
  String? status;
  String address;
  String? voucher;
  int userStep;
  String? chosenCompany;
  bool? isBirth;
  String? birthDate;
  String? birthType;
  bool? useHospital;
  bool? useCareCenter;
  String userName;
  String? hospitalEndDate;
  String? hospitalStartDate;
  String? careCenterEndDate;
  String? careCenterStartDate;
  String? serviceStartDate;
  String? serviceEndDate;
  String? serviceDuration;
  String? lactationType;
  String? placeToBeServiced;
  String? animalType;
  List<dynamic>? careRanking;
  String? requirement;
  String? careType;
  Map<String, dynamic>? allAdditionalFamily;
  List<dynamic>? managersName;
  bool? isbirthConfirmed;
  String? fullRegNum;
  int? userCost;
  int? revenueCost;
  int? depositCost;
  int? extraCost;
  int? totalCost;
  int? balanceCost;
  String? isFinishedReservation;
  String? isFinishedBalance;
  String? isFinishedDeposit;
  bool? isManagerDispatched;
  List<dynamic>? managersId;
  String reservationRoute;
  bool? notifyDepositCost = false;
  bool? notifyBalanceCost = false;
  bool? openPopup = false;
  String? careCenterDuration;
  bool? midtermReviewFinished = false;
  bool? finalReviewFinished = false;
  bool? changeManager = false;
  List<dynamic>? changeManagerList = [];
  bool refundRequested;
  bool refundAccepted;
  String? refundBank;
  String? refundAccountNumber;
  String? refundAccountHolder;
  int? serviceRemainingDays;
  int? completedBalanceCost;
  bool isFirstDispatchManager;

  ReservationModel({
    required this.date,
    required this.uid,
    required this.email,
    required this.userName,
    required this.phone,
    required this.address,
    required this.userStep,
    required this.reservationNumber,
    required this.reservationRoute,
    this.status,
    this.voucher,
    this.chosenCompany,
    this.isBirth,
    this.birthDate,
    this.birthType,
    this.useHospital,
    this.useCareCenter,
    this.hospitalStartDate,
    this.hospitalEndDate,
    this.careCenterEndDate,
    this.careCenterStartDate,
    this.serviceStartDate,
    this.serviceEndDate,
    this.serviceDuration,
    this.careCenterDuration,
    this.lactationType,
    this.placeToBeServiced,
    this.animalType,
    this.careRanking,
    this.requirement,
    this.careType,
    this.isFinishedReservation,
    this.isFinishedDeposit,
    this.isFinishedBalance,
    this.allAdditionalFamily,
    this.managersName,
    this.isbirthConfirmed,
    this.fullRegNum,
    this.userCost,
    this.revenueCost,
    this.depositCost,
    this.extraCost,
    this.totalCost,
    this.balanceCost,
    this.isManagerDispatched,
    this.managersId,
    this.notifyDepositCost,
    this.notifyBalanceCost,
    this.openPopup,
    this.midtermReviewFinished = false,
    this.finalReviewFinished = false,
    this.changeManager,
    this.changeManagerList,
    this.completedBalanceCost,
    this.isFirstDispatchManager = true,
    this.refundAccepted = false,
    this.refundRequested = false,
  });

  factory ReservationModel.fromJson(Map data) {
    return ReservationModel(
      date: data['date'],
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
      userName: data['userName'] ?? '',
      phone: data['phone'] ?? '',
      address: data['address'] ?? '',
      userStep: data['userStep'] ?? 1,
      voucher: data['voucher'] ?? '',
      status: data['status'],
      reservationRoute: data['reservationRoute'],
      reservationNumber: data['reservationNumber'] ?? '',
      chosenCompany: data['chosenCompany'] ?? '',
      isBirth: data['isBirth'] ?? false,
      birthDate: data['birthExpectedDate'] ?? '',
      birthType: data['birthType'] ?? '',
      useHospital: data['useHospital'] ?? false,
      useCareCenter: data['useCareCenter'] ?? false,
      hospitalStartDate: data['hospitalStartDate'] ?? '',
      hospitalEndDate: data['hospitalEndDate'] ?? '',
      careCenterEndDate: data['careCenterEndDate'] ?? '',
      careCenterStartDate: data['careCenterStartDate'] ?? '',
      careCenterDuration: data['careCenterDuration'] ?? '',
      serviceStartDate: data['serviceStartDate'] ?? '',
      serviceEndDate: data['serviceEndDate'] ?? '',
      serviceDuration: data['serviceDuration'],
      lactationType: data['lactationType'] ?? '',
      placeToBeServiced: data['placeToBeServiced'] ?? '',
      animalType: data['animalType'] ?? '',
      careRanking: data['careRanking'] ?? [],
      requirement: data['requirement'] ?? '',
      careType: data['careType'] ?? '',
      allAdditionalFamily: (data['allAdditionalFamily'] == null)
          ? null
          : data['allAdditionalFamily'].cast<String, dynamic>(),
      managersName: data['managersName'] ?? [],
      managersId: data['managersId'] ?? [],
      isbirthConfirmed: data['isbirthConfirmed'] ?? true,
      isFinishedBalance: data['isFinishedBalance'] ?? '',
      isFinishedDeposit: data['isFinishedDeposit'] ?? '',
      fullRegNum: data['fullRegNum'] ?? '',
      userCost: data['userCost'] ?? 0,
      revenueCost: data['revenueCost'] ?? 0,
      depositCost: data['depositCost'] ?? 0,
      extraCost: data['extraCost'] ?? 0,
      totalCost: data['totalCost'] ?? 0,
      balanceCost: data['balanceCost'] ?? 0,
      isManagerDispatched: data['isManagerDispatched'],
      notifyDepositCost: data['notifyDepositCost'],
      notifyBalanceCost: data['notifyBalanceCost'],
      openPopup: data['openPopup'] ?? false,
      midtermReviewFinished: data['midtermReviewFinished'],
      finalReviewFinished: data['finalReviewFinished'],
      changeManager: data['changeManager'] ?? false,
      changeManagerList: data['changeManagerList'] ?? [],
      completedBalanceCost: data['completedBalanceCost'] ?? 0,
      refundRequested: data['refundRequested'] ?? false,
      refundAccepted: data['refundAccepted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "date": date,
        "uid": uid,
        "email": email,
        "userName": userName,
        "phone": phone,
        "address": address,
        "userStep": userStep,
        "voucher": voucher,
        "status": status,
        "reservationRoute": reservationRoute,
        "reservationNumber": reservationNumber,
        "chosenCompany": chosenCompany,
        "isBirth": isBirth,
        "birthExpectedDate": birthDate,
        "birthType": birthType,
        "useHospital": useHospital,
        "useCareCenter": useCareCenter,
        "hospitalStartDate": hospitalStartDate,
        "hospitalEndDate": hospitalEndDate,
        "careCenterEndDate": careCenterEndDate,
        "careCenterStartDate": careCenterStartDate,
        "serviceStartDate": serviceStartDate,
        "serviceEndDate": serviceEndDate,
        "serviceDuration": serviceDuration,
        "careCenterDuration": careCenterDuration,
        "lactationType": lactationType,
        "placeToBeServiced": placeToBeServiced,
        "animalType": animalType,
        "careRanking": careRanking,
        "requirement": requirement,
        "careType": careType,
        "allAdditionalFamily": allAdditionalFamily,
        "managersName": managersName,
        "managersId": managersId,
        "isbirthConfirmed": isbirthConfirmed,
        "fullRegNum": fullRegNum,
        "userCost": userCost,
        "revenueCost": revenueCost,
        "depositCost": depositCost,
        "extraCost": extraCost,
        "totalCost": totalCost,
        "balanceCost": balanceCost,
        "isManagerDispatched": isManagerDispatched,
        "isFinishedBalance": isFinishedBalance,
        "isFinishedDeposit": isFinishedDeposit,
        "notifyDepositCost": notifyDepositCost,
        "notifyBalanceCost": notifyBalanceCost,
        "openPopup": openPopup,
        "midtermReviewFinished": midtermReviewFinished,
        "finalReviewFinished": finalReviewFinished,
        "changeManager": changeManager,
        "changeManagerList": changeManagerList,
        "completedBalanceCost": completedBalanceCost,
        "isFirstDispatchManager": isFirstDispatchManager,
      };
}
