// crop_model.dart
class Crop {
  final int id;
  final String cropName;
  bool? status;
  List<String> cropImages;
  final String seasonName;
  final int seasonId;
  final String category;

  Crop({
    required this.id,
    required this.cropName,
    required this.status,
    required this.cropImages,
    required this.seasonName,
    required this.seasonId,
    required this.category,
  });

  factory Crop.fromJson(Map<String, dynamic> json, String category) {
    return Crop(
      id: json['id'],
      cropName: json['crop_name'],
      status: json['status'],
      cropImages: json["crop_images"] == null ? [] : List<String>.from(json["crop_images"]!.map((x) => x)),
      seasonName: json['season_name'],
      seasonId: json['season_id'],
      category: category,
    );
  }
}