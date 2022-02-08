class CompanyModel {
  final String? uid;
  final String companyName;
  final String address;
  final String phone;

  int? totalReviewRate;
  int? totalReview;
  String? homepage;
  String? blog;
  String? momcafe;
  String? thumbnail;

  CompanyModel({
    required this.uid,
    required this.companyName,
    required this.address,
    required this.phone,
    this.totalReviewRate,
    this.totalReview,
    this.homepage,
    this.blog,
    this.momcafe,
    this.thumbnail,
  });

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
      };
}
