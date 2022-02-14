class InquiryModel {
  final String managerId;
  final String companyId;
  final String userId;
  final String contents;
  final DateTime date;
  final String userEmail;
  final String managerName;
  InquiryModel({
    required this.managerId,
    required this.companyId,
    required this.userId,
    required this.contents,
    required this.date,
    required this.userEmail,
    required this.managerName,
  });

  factory InquiryModel.fromJson(Map data) {
    return InquiryModel(
      managerId: data['managerId'] ?? '',
      managerName: data['managerNambe'] ?? '',
      companyId: data['companyId'] ?? '',
      userId: data['userId'] ?? '',
      userEmail: data['userEmail'] ?? '',
      contents: data['contents'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(data['date']),
    );
  }

  Map<String, dynamic> toJson() => {
        "managerId": managerId,
        "managerName": managerName,
        "companyId": companyId,
        "userId": userId,
        "userEmail": userEmail,
        "contents": contents,
        "date": date.millisecondsSinceEpoch,
      };
}
