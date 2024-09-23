class CropVariety {
  final int varietyId;
  final String variety;

  CropVariety({
    required this.varietyId,
    required this.variety,
  });

  factory CropVariety.fromJson(Map<String, dynamic> json) {
    return CropVariety(
      varietyId: json['variety_id'],
      variety: json['name'],
    );
  }
}