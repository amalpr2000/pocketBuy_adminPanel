class BrandModel {
  String? brandImg;
  String? brandName;

  BrandModel({required this.brandImg, required this.brandName});

  Map<String, dynamic> toJson() => {
        'brandName': brandName,
        'brandImg': brandImg,
      };
}
