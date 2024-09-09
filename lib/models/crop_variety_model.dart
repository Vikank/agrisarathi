class CropVariety {
  final int varietyId;
  final String variety;

  CropVariety({
    required this.varietyId,
    required this.variety,
  });

  factory CropVariety.fromJson(Map<String, dynamic> json) {
    return CropVariety(
      varietyId: json['id'],
      variety: json['name'],
    );
  }
}