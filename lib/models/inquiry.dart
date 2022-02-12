class InquiryModel {
  final List<dynamic>? managersId;
  final String companyId;
  final String userId;
  final String contents;
  final DateTime date;

  InquiryModel({
    required this.managersId,
    required this.companyId,
    required this.userId,
    required this.contents,
    required this.date,
  });

  factory InquiryModel.fromJson(Map data) {
    return InquiryModel(
      managersId: data['managerId'] ?? [],
      companyId: data['companyId'] ?? '',
      userId: data['userId'] ?? '',
      contents: data['contents'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(data['date']),
    );
  }

  Map<String, dynamic> toJson() => {
        "managerId": managersId,
        "companyId": companyId,
        "userId": userId,
        "contents": contents,
        "date": date.millisecondsSinceEpoch,
      };
}
