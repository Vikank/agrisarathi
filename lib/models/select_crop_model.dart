// crop_model.dart
class Crop {
  final int id;
  final String cropName;
  bool? status;
  final String cropImage;
  final String seasonName;
  final int seasonId;
  final String category;

  Crop({
    required this.id,
    required this.cropName,
    required this.status,
    required this.cropImage,
    required this.seasonName,
    required this.seasonId,
    required this.category,
  });

  factory Crop.fromJson(Map<String, dynamic> json, String category) {
    return Crop(
      id: json['id'],
      cropName: json['crop_name'],
      status: json['status'],
      cropImage: json['crop_image'],
      seasonName: json['season_name'],
      seasonId: json['season_id'],
      category: category,
    );
  }
}