class DiseaseResultModel {
  String? disease;
  String? symptom;
  String? reason;
  String? treatment;
  List<Images>? images;
  String? basePath;
  String? message;

  DiseaseResultModel(
      {
        this.disease,
        this.symptom,
        this.reason,
        this.treatment,
        this.images,
        this.basePath,
        this.message});

  DiseaseResultModel.fromJson(Map<String, dynamic> json) {
    disease = json['disease'];
    symptom = json['symptom'];
    reason = json['reason'];
    treatment = json['treatment'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    basePath = json['base_path'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['disease'] = disease;
    data['symptom'] = symptom;
    data['reason'] = reason;
    data['treatment'] = treatment;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['base_path'] = basePath;
    data['message'] = message;
    return data;
  }
}

class Images {
  int? id;
  String? diseaseFile;

  Images({this.id, this.diseaseFile});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diseaseFile = json['disease_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['disease_file'] = diseaseFile;
    return data;
  }
}
