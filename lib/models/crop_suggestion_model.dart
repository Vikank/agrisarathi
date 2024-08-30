class CropSuggestionModel {
  List<SuggestedCrops>? suggestedCrops;

  CropSuggestionModel({this.suggestedCrops});

  CropSuggestionModel.fromJson(Map<String, dynamic> json) {
    if (json['crops'] != null) {
      suggestedCrops = <SuggestedCrops>[];
      json['crops'].forEach((v) {
        suggestedCrops!.add(SuggestedCrops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (suggestedCrops != null) {
      data['crops'] =
          suggestedCrops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SuggestedCrops {
  int? cropId;
  String? cropName;
  String? cropImage;

  SuggestedCrops({this.cropId, this.cropName, this.cropImage});

  SuggestedCrops.fromJson(Map<String, dynamic> json) {
    cropId = json['crop_id'];
    cropName = json['crop_name'];
    cropImage = json['crop_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['crop_id'] = cropId;
    data['crop_name'] = cropName;
    data['crop_image'] = cropImage;
    return data;
  }
}