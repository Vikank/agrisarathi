class CropVariety {
  final int varietyId;
  final String variety;
  final String? varietyImage;
  final int cropId;

  CropVariety({
    required this.varietyId,
    required this.variety,
    this.varietyImage,
    required this.cropId,
  });

  factory CropVariety.fromJson(Map<String, dynamic> json) {
    return CropVariety(
      varietyId: json['variety_id'],
      variety: json['variety'],
      varietyImage: json['variety_image'],
      cropId: json['crop_id'],
    );
  }
}