class SingleCropSuggestionModel {
  CropDetails? cropDetails;

  SingleCropSuggestionModel({this.cropDetails});

  SingleCropSuggestionModel.fromJson(Map<String, dynamic> json) {
    cropDetails = json['crop_details'] != null
        ? CropDetails.fromJson(json['crop_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (cropDetails != null) {
      data['crop_details'] = cropDetails!.toJson();
    }
    return data;
  }
}

class CropDetails {
  int? cropId;
  String? cropName;
  String? description;
  String? season;
  String? weatherTemperature;
  String? costOfCultivation;
  String? marketPrice;
  String? production;
  String? language;
  String? cropImage;
  String? cropAudio;

  CropDetails(
      {this.cropId,
        this.cropName,
        this.description,
        this.season,
        this.weatherTemperature,
        this.costOfCultivation,
        this.marketPrice,
        this.production,
        this.language,
        this.cropImage,
        this.cropAudio});

  CropDetails.fromJson(Map<String, dynamic> json) {
    cropId = json['crop_id'];
    cropName = json['crop_name'];
    description = json['description'];
    season = json['season'];
    weatherTemperature = json['weather_temperature'];
    costOfCultivation = json['cost_of_cultivation'];
    marketPrice = json['market_price'];
    production = json['production'];
    language = json['language'];
    cropImage = json['crop_image'];
    cropAudio = json['crop_audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['crop_id'] = cropId;
    data['crop_name'] = cropName;
    data['description'] = description;
    data['season'] = season;
    data['weather_temperature'] = weatherTemperature;
    data['cost_of_cultivation'] = costOfCultivation;
    data['market_price'] = marketPrice;
    data['production'] = production;
    data['language'] = language;
    data['crop_image'] = cropImage;
    data['crop_audio'] = cropAudio;
    return data;
  }
}