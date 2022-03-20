class CompanyModel {
  final String? uid;
  final String companyName;
  final String address;
  final String phone;
  final String bankName;
  final String accountNumber;
  final String accountHolderName;

  int totalReviewRate;
  int totalReview;
  String? homepage;
  String? blog;
  String? momcafe;
  String? thumbnail;
  int extraFamilyCost;
  int kindergartenerCost;
  int preschoolerCost;
  int schoolerCost;

  CompanyModel(
      {required this.uid,
      required this.companyName,
      required this.address,
      required this.phone,
      required this.bankName,
      required this.accountNumber,
      required this.accountHolderName,
      this.totalReviewRate = 0,
      this.totalReview = 0,
      this.homepage,
      this.blog,
      this.momcafe,
      this.thumbnail,
      required this.extraFamilyCost,
      required this.kindergartenerCost,
      required this.preschoolerCost,
      required this.schoolerCost});

  factory CompanyModel.fromJson(Map data) {
    return CompanyModel(
      uid: data['uid'] ?? '',
      companyName: data['companyName'] ?? '',
      address: data['address'] ?? '',
      phone: data['phone'] ?? '',
      totalReviewRate: data['totalReviewRate'] ?? 0,
      totalReview: data['totalReview'] ?? 0,
      homepage: data['homepage'] ?? '',
      blog: data['blog'] ?? '',
      momcafe: data['momcafe'] ?? '',
      thumbnail: data['thumbnail'],
      accountNumber: data['accountNumber'] ?? '',
      bankName: data['bankName'] ?? '',
      accountHolderName: data['accountHolderName'] ?? '',
      extraFamilyCost: data['extraFamilyCost'] ?? 5000,
      kindergartenerCost: data['kindergartenerCost'] ?? 5000,
      preschoolerCost: data['preschoolerCost'] ?? 11000,
      schoolerCost: data['schoolerCost'] ?? 5000,
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "companyName": companyName,
        "address": address,
        "phone": phone,
        "totalReviewRate": totalReviewRate,
        "totalReview": totalReview,
        "homepage": homepage,
        "blog": blog,
        "momcafe": momcafe,
        "thumbnail": thumbnail,
        "accountNumber": accountNumber,
        "bankName": bankName,
        "accountHolderName": accountHolderName,
      };
}
