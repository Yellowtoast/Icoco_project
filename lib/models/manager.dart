import 'package:app/configs/constants.dart';

class ManagerModel {
  final String uid;
  final String name;
  final String companyName;
  final String companyUid;
  final List<dynamic> dispatchableArea;
  final String? ages;
  int totalReview;
  int totalReviewRate;
  String? status;
  String? careerCount;
  String? isCar;
  String? isResident;
  String? isCCTV;
  bool? certName;
  bool? certHealth;
  bool? certCrime;
  String? profileImage;
  int managerRate;
  String? reservationNumber;
  String? specialty;
  Map<String, dynamic>? specialtyItems;

  ManagerModel({
    required this.uid,
    required this.name,
    required this.companyName,
    required this.dispatchableArea,
    required this.ages,
    required this.companyUid,
    this.totalReviewRate = 0,
    this.totalReview = 0,
    this.status,
    this.careerCount,
    this.isCar,
    this.isResident,
    this.isCCTV,
    this.certName,
    this.certHealth,
    this.certCrime,
    this.profileImage,
    this.reservationNumber,
    this.specialty,
    this.specialtyItems,
    this.managerRate = 0,
  });

  factory ManagerModel.fromJson(Map data) {
    return ManagerModel(
      uid: data['uid'],
      name: data['name'] ?? '',
      companyName: data['companyName'],
      companyUid: data['company'] ?? '',
      dispatchableArea: data['dispatchableArea'] ?? [],
      ages: data['birthDate'] ?? '',
      totalReview: data['totalReview'] ?? 0,
      totalReviewRate: data['totalReviewRate'] ?? 0,
      status: data['status'] ?? '',
      careerCount: data['careerStartedDate'] ?? '',
      isCar: data['isCar'] ?? '',
      isResident: data['isResident'] ?? '',
      isCCTV: data['isCCTV'] ?? '',
      certName: data['certName'],
      certHealth: data['certHealth'],
      certCrime: data['certCrime'],
      profileImage: data['profileImage'] ?? emptyProfileUrl,
      reservationNumber: data['reservationNumber'] ?? '',
      specialty: data['specialty'] ?? '',
      specialtyItems: data['specialtyItems'].cast<String, dynamic>(),
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "company": companyUid,
        "dispatchableArea": dispatchableArea,
        "birthDate": ages,
        "totalReview": totalReview,
        "totalReviewRate": totalReviewRate,
        "status": status,
        "careerStartedDate": careerCount,
        "isCar": isCar,
        "isResident": isResident,
        "isCCTV": isCCTV,
        "certName": certName,
        "certHealth": certHealth,
        "certCrime": certCrime,
        "profileImage": profileImage,
        "reservationNumber": reservationNumber,
        "specialty": specialty,
        "specialtyItems": specialtyItems,
      };
}
