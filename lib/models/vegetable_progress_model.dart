class VegetableProgressModel {
  List<CropsProgress>? cropsProgress;

  VegetableProgressModel({this.cropsProgress});

  factory VegetableProgressModel.fromJson(Map<String, dynamic> json) {
    return VegetableProgressModel(
      cropsProgress: json['crops_progress'] != null
          ? (json['crops_progress'] as List)
          .map((item) => CropsProgress.fromJson(item as Map<String, dynamic>))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'crops_progress': cropsProgress?.map((e) => e.toJson()).toList(),
    };
  }
}

class CropsProgress {
  int? cropId;
  int? landId;
  String? cropImage;
  String? cropName;
  int? userLanguage;
  int? filterType;
  double? overallProgress;
  int? totalPreferences;
  int? completedPreferences;
  List<dynamic>? preferenceDetails; // Adjust this to a specific type if known

  CropsProgress({
    this.cropId,
    this.landId,
    this.cropImage,
    this.cropName,
    this.userLanguage,
    this.filterType,
    this.overallProgress,
    this.totalPreferences,
    this.completedPreferences,
    this.preferenceDetails,
  });

  factory CropsProgress.fromJson(Map<String, dynamic> json) {
    return CropsProgress(
      cropId: json['crop_id'],
      landId: json['land_id'],
      cropImage: json['crop_image'],
      cropName: json['crop_name'],
      userLanguage: json['user_language'],
      filterType: json['filter_type'],
      overallProgress: json['overall_progress'],
      totalPreferences: json['total_preferences'],
      completedPreferences: json['completed_preferences'],
      preferenceDetails: json['preference_details'] != null
          ? (json['preference_details'] as List).map((item) => item).toList() // Modify this line based on actual data structure
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'crop_id': cropId,
      'landId': cropId,
      'crop_image': cropImage,
      'crop_name': cropName,
      'user_language': userLanguage,
      'filter_type': filterType,
      'overall_progress': overallProgress,
      'total_preferences': totalPreferences,
      'completed_preferences': completedPreferences,
      'preference_details': preferenceDetails,
    };
  }
}
