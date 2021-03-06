class RefundModel {
  bool refundRequested;
  bool? refundAccepted;
  String refundBank;
  String refundAccountNumber;
  String refundAccountHolder;
  int serviceRemainingDays;
  String status;

  RefundModel({
    required this.refundRequested,
    required this.refundBank,
    required this.refundAccountNumber,
    required this.refundAccountHolder,
    required this.serviceRemainingDays,
    required this.status,
    this.refundAccepted,
  });

  factory RefundModel.fromJson(Map data) {
    return RefundModel(
      refundRequested: data['refundRequested'],
      refundAccepted: data['refundAccepted'],
      refundBank: data['refundBank'],
      refundAccountNumber: data['refundAccountNumber'],
      refundAccountHolder: data['refundAccountHolder'],
      serviceRemainingDays: data['serviceRemainingDays'],
      status: data['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "refundRequested": refundRequested,
        "refundAccepted": refundAccepted,
        "refundBank": refundBank,
        "refundAccountNumber": refundAccountNumber,
        "refundAccountHolder": refundAccountHolder,
        "serviceRemainingDays": serviceRemainingDays,
        "status": status,
      };
}
