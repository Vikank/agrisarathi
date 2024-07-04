// video_model.dart
class DiseaseDetectionVideoModel {
  final int id;
  final int fkLanguageId;
  final String videoUrl;

  DiseaseDetectionVideoModel({
    required this.id,
    required this.fkLanguageId,
    required this.videoUrl,
  });

  factory DiseaseDetectionVideoModel.fromJson(Map<String, dynamic> json) {
    return DiseaseDetectionVideoModel(
      id: json['id'],
      fkLanguageId: json['fk_language_id'],
      videoUrl: json['video'],
    );
  }
}