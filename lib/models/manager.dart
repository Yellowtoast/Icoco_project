class ManagerModel {
  final String uid;
  final String name;
  final String company;
  final List<dynamic> dispatchableArea;
  final String? birthDate;
  int? totalReview;
  String? status;
  String? careerStartedDate;
  String? isCar;
  String? isResident;
  String? isCCTV;
  bool? certName;
  bool? certHealth;
  bool? certCrime;
  String? profileImage;
  int? averageReviewRate;
  String? reservationNumber;
  String? specialty;
  Map<String, dynamic>? specialtyItems;

  ManagerModel({
    required this.uid,
    required this.name,
    required this.company,
    required this.dispatchableArea,
    required this.birthDate,
    this.totalReview,
    this.status,
    this.careerStartedDate,
    this.isCar,
    this.isResident,
    this.isCCTV,
    this.certName,
    this.certHealth,
    this.certCrime,
    this.profileImage,
    this.averageReviewRate,
    this.reservationNumber,
    this.specialty,
    this.specialtyItems,
  });

  factory ManagerModel.fromJson(Map data) {
    return ManagerModel(
      uid: data['uid'],
      name: data['name'] ?? '',
      company: data['company'] ?? '',
      dispatchableArea: data['dispatchableArea'] ?? [],
      birthDate: data['birthDate'] ?? '',
      totalReview: data['totalReview'],
      status: data['status'] ?? '',
      careerStartedDate: data['careerStartedDate'] ?? '',
      isCar: data['isCar'] ?? '',
      isResident: data['isResident'] ?? '',
      isCCTV: data['isCCTV'] ?? '',
      certName: data['certName'],
      certHealth: data['certHealth'],
      certCrime: data['certCrime'],
      profileImage: data['profileImage'] ?? '',
      averageReviewRate: data['averageReviewRate'],
      reservationNumber: data['reservationNumber'] ?? '',
      specialty: data['specialty'] ?? '',
      specialtyItems: data['specialtyItems'].cast<String, dynamic>(),
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "company": company,
        "dispatchableArea": dispatchableArea,
        "birthDate": birthDate,
        "totalReview": totalReview,
        "status": status,
        "careerStartedDate": careerStartedDate,
        "isCar": isCar,
        "isResident": isResident,
        "isCCTV": isCCTV,
        "certName": certName,
        "certHealth": certHealth,
        "certCrime": certCrime,
        "profileImage": profileImage,
        "averageReviewRate": averageReviewRate,
        "reservationNumber": reservationNumber,
        "specialty": specialty,
        "specialtyItems": specialtyItems,
      };
}
