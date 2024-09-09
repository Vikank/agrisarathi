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
  int? userLanguage;
  int? filterType;
  int? overallProgress;
  int? totalPreferences;
  int? completedPreferences;
  List<dynamic>? preferenceDetails; // Adjust this to a specific type if known

  CropsProgress({
    this.cropId,
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
      'user_language': userLanguage,
      'filter_type': filterType,
      'overall_progress': overallProgress,
      'total_preferences': totalPreferences,
      'completed_preferences': completedPreferences,
      'preference_details': preferenceDetails,
    };
  }
}
