class FeeModel {
  final String companyId;
  final Map<String, List<int>> govermentFeeInfo;
  final Map<String, List<int>> serviceFeeInfo;

  FeeModel(
      {required this.companyId,
      required this.govermentFeeInfo,
      required this.serviceFeeInfo});

  factory FeeModel.fromJson(Map data) {
    return FeeModel(
      companyId: data['companyId'] ?? {},
      govermentFeeInfo: data['govermentFeeInfo'] ?? {},
      serviceFeeInfo: data['serviceFeeInfo'] ?? {},
    );
  }

  Map<String, dynamic> toJson() => {
        "companyId": companyId,
        "govermentFeeInfo": govermentFeeInfo,
        "serviceFeeInfo": serviceFeeInfo,
      };
}
