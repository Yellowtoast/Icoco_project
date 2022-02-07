class ReservationModel {
  final int date;
  final String uid;
  final String email;
  final String userName;
  final String phone;
  final bool isMarketingAllowed;
  final String reservationNumber;
  String? status;
  String address;
  String? voucher;
  int userStep;
  String? chosenCompany;
  bool? isBirth;
  String? birthExpectedDate;
  String? birthType;
  bool? useHospital;
  bool? useCareCenter;
  String? hospitalEndDate;
  String? careCenterEndDate;
  String? serviceStartDate;
  String? serviceEndDate;
  String? serviceDuration;
  String? lactationType;
  String? placeToBeServiced;
  String? animalType;
  List<dynamic>? careRanking;
  String? extraRequests;
  String? careType;
  Map<String, dynamic>? allAdditionalFamily;
  String? managerName;
  bool? isbirthConfirmed;
  String? fullRegNum;
  int? userCost;
  int? revenueCost;
  int? depositCost;
  int? extraCost;
  int? totalCost;
  int? balanceCost;
  String? isFinishedReservation;
  String? isFinishedBalance = '입금 전';
  String? isFinishedDeposit = '입금 전';
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

  ReservationModel({
    required this.date,
    required this.uid,
    required this.email,
    required this.userName,
    required this.phone,
    required this.isMarketingAllowed,
    required this.address,
    required this.userStep,
    required this.reservationNumber,
    required this.reservationRoute,
    this.status,
    this.voucher,
    this.chosenCompany,
    this.isBirth,
    this.birthExpectedDate,
    this.birthType,
    this.useHospital,
    this.useCareCenter,
    this.hospitalEndDate,
    this.careCenterEndDate,
    this.serviceStartDate,
    this.serviceEndDate,
    this.serviceDuration,
    this.careCenterDuration,
    this.lactationType,
    this.placeToBeServiced,
    this.animalType,
    this.careRanking,
    this.extraRequests,
    this.careType,
    this.isFinishedReservation,
    this.isFinishedDeposit,
    this.isFinishedBalance,
    this.allAdditionalFamily,
    this.managerName,
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
    this.midtermReviewFinished,
    this.finalReviewFinished,
    this.changeManager,
    this.changeManagerList,
  });

  factory ReservationModel.fromJson(Map data) {
    return ReservationModel(
        date: data['date'],
        uid: data['uid'],
        email: data['email'] ?? '',
        userName: data['userName'] ?? '',
        phone: data['phone'] ?? '',
        address: data['address'] ?? '',
        userStep: data['userStep'] ?? 1,
        voucher: data['voucher'] ?? '',
        status: data['status'],
        reservationRoute: data['reservationRoute'],
        reservationNumber: data['reservationNumber'] ?? '',
        isMarketingAllowed: data['isMarketingAllowed'] ?? false,
        chosenCompany: data['chosenCompany'] ?? '',
        isBirth: data['isBirth'] ?? false,
        birthExpectedDate: data['birthExpectedDate'] ?? '',
        birthType: data['birthType'] ?? '',
        useHospital: data['useHospital'] ?? false,
        useCareCenter: data['useCareCenter'] ?? false,
        hospitalEndDate: data['hospitalEndDate'] ?? '',
        careCenterEndDate: data['careCenterEndDate'] ?? '',
        serviceStartDate: data['serviceStartDate'] ?? '',
        serviceEndDate: data['serviceEndDate'] ?? '',
        serviceDuration: data['serviceDuration'] ?? '',
        careCenterDuration: data['careCenterDuration'] ?? '',
        lactationType: data['lactationType'] ?? '',
        placeToBeServiced: data['placeToBeServiced'] ?? '',
        animalType: data['animalType'] ?? '',
        careRanking: data['careRanking'] ?? [],
        extraRequests: data['extraRequests'] ?? '',
        careType: data['careType'] ?? '',
        allAdditionalFamily: (data['allAdditionalFamily'] == null)
            ? null
            : data['allAdditionalFamily'].cast<String, dynamic>(),
        managerName: data['managerName'] ?? '',
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
        openPopup: data['openPopup'],
        midtermReviewFinished: data['midtermReviewFinished'],
        finalReviewFinished: data['finalReviewFinished'],
        changeManager: data['changeManager'] ?? false,
        changeManagerList: data['changeManagerList']);
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
        "isMarketingAllowed": isMarketingAllowed,
        "chosenCompany": chosenCompany,
        "isBirth": isBirth,
        "birthExpectedDate": birthExpectedDate,
        "birthType": birthType,
        "useHospital": useHospital,
        "useCareCenter": useCareCenter,
        "hospitalEndDate": hospitalEndDate,
        "careCenterEndDate": careCenterEndDate,
        "serviceStartDate": serviceStartDate,
        "serviceEndDate": serviceEndDate,
        "serviceDuration": serviceDuration,
        "careCenterDuration": careCenterDuration,
        "lactationType": lactationType,
        "placeToBeServiced": placeToBeServiced,
        "animalType": animalType,
        "careRanking": careRanking,
        "extraRequests": extraRequests,
        "careType": careType,
        "allAdditionalFamily": allAdditionalFamily,
        "managerName": managerName,
        "isbirthConfirmed": isbirthConfirmed,
        "fullRegNum": fullRegNum,
        "userCost": userCost,
        "revenueCost": revenueCost,
        "depositCost": depositCost,
        "extraCost": extraCost,
        "totalCost": totalCost,
        "balanceCost": balanceCost,
        "isManagerDispatched": isManagerDispatched,
        "managersId": managersId,
        "isFinishedBalance": isFinishedBalance,
        "isFinishedDeposit": isFinishedDeposit,
        "notifyDepositCost": notifyDepositCost,
        "notifyBalanceCost": notifyBalanceCost,
        "openPopup": openPopup,
        "midtermReviewFinished": midtermReviewFinished,
        "finalReviewFinished": finalReviewFinished,
        "changeManager": changeManager,
        "changeManagerList": changeManagerList,
      };
}
