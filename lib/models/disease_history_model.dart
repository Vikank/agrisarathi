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
  String? diseaseName;
  String? serviceProvider;
  String? symptom;
  String? treatmentBefore;
  String? treatmentField;
  String? treatment;
  String? message;
  String? suggestiveProduct;
  String? uploadedImage;

  DiseaseDetails({
    this.id,
    this.diseaseName,
    this.serviceProvider,
    this.symptom,
    this.treatmentBefore,
    this.treatmentField,
    this.treatment,
    this.message,
    this.suggestiveProduct,
    this.uploadedImage,
  });

  DiseaseDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diseaseName = json['disease_name'];
    serviceProvider = json['serviceprovider'];
    symptom = json['symptom'];
    treatmentBefore = json['treatmentbefore'];
    treatmentField = json['treatmentfield'];
    treatment = json['treatment'];
    message = json['message'];
    suggestiveProduct = json['suggestiveproduct'];
    uploadedImage = json['uploaded_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['disease_name'] = diseaseName;
    data['serviceprovider'] = serviceProvider;
    data['symptom'] = symptom;
    data['treatmentbefore'] = treatmentBefore;
    data['treatmentfield'] = treatmentField;
    data['treatment'] = treatment;
    data['message'] = message;
    data['suggestiveproduct'] = suggestiveProduct;
    data['uploaded_image'] = uploadedImage;
    return data;
  }
}
