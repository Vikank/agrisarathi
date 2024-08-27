class CropVariety {
  final int varietyId;
  final String variety;
  final int cropId;

  CropVariety({
    required this.varietyId,
    required this.variety,
    required this.cropId,
  });

  factory CropVariety.fromJson(Map<String, dynamic> json) {
    return CropVariety(
      varietyId: json['id'],
      variety: json['variety'],
      cropId: json['fk_crops_id'],
    );
  }
}