class DiseaseHistoryModel {
  String? status;
  List<DiseaseDetails>? diseaseDetails;

  DiseaseHistoryModel({this.status, this.diseaseDetails});

  DiseaseHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['disease_details'] != null) {
      diseaseDetails = <DiseaseDetails>[];
      json['disease_details'].forEach((v) {
        diseaseDetails!.add(DiseaseDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (diseaseDetails != null) {
      data['disease_details'] =
          diseaseDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DiseaseDetails {
  int? id;
  int? cropId;
  String? serviceProvider;
  String? disease;
  String? image;
  String? uploadData;

  DiseaseDetails(
      {this.id,
        this.cropId,
        this.serviceProvider,
        this.disease,
        this.image,
        this.uploadData});

  DiseaseDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cropId = json['crop_id'];
    serviceProvider = json['Service_Provider'];
    disease = json['disease'];
    image = json['image'];
    uploadData = json['Upload_Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['crop_id'] = cropId;
    data['Service_Provider'] = serviceProvider;
    data['disease'] = disease;
    data['image'] = image;
    data['Upload_Data'] = uploadData;
    return data;
  }
}