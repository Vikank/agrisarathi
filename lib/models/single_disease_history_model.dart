class SingleDiseaseHistoryModel {
  List<DiseaseResults>? diseaseResults;
  List<ProductDiseaseResults>? productDiseaseResults;

  SingleDiseaseHistoryModel({this.diseaseResults, this.productDiseaseResults});

  SingleDiseaseHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['disease_results'] != null) {
      diseaseResults = <DiseaseResults>[];
      json['disease_results'].forEach((v) {
        diseaseResults!.add(DiseaseResults.fromJson(v));
      });
    }
    if (json['product_disease_results'] != null) {
      productDiseaseResults = <ProductDiseaseResults>[];
      json['product_disease_results'].forEach((v) {
        productDiseaseResults!.add(ProductDiseaseResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (diseaseResults != null) {
      data['disease_results'] =
          diseaseResults!.map((v) => v.toJson()).toList();
    }
    if (productDiseaseResults != null) {
      data['product_disease_results'] =
          productDiseaseResults!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DiseaseResults {
  int? id;
  int? cropId;
  String? disease;
  String? images;
  String? treatmentbefore;
  String? treatmentfield;
  String? treatment;
  String? symptom;
  String? suggestiveproduct;
  String? uploadData;

  DiseaseResults(
      {this.id,
        this.cropId,
        this.disease,
        this.images,
        this.treatmentbefore,
        this.treatmentfield,
        this.treatment,
        this.symptom,
        this.suggestiveproduct,
        this.uploadData});

  DiseaseResults.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cropId = json['crop_id'];
    disease = json['disease'];
    images = json['images'];
    treatmentbefore = json['treatmentbefore'];
    treatmentfield = json['treatmentfield'];
    treatment = json['treatment'];
    symptom = json['symptom'];
    suggestiveproduct = json['suggestiveproduct'];
    uploadData = json['Upload_Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['crop_id'] = cropId;
    data['disease'] = disease;
    data['images'] = images;
    data['treatmentbefore'] = treatmentbefore;
    data['treatmentfield'] = treatmentfield;
    data['treatment'] = treatment;
    data['symptom'] = symptom;
    data['suggestiveproduct'] = suggestiveproduct;
    data['Upload_Data'] = uploadData;
    return data;
  }
}

class ProductDiseaseResults {
  int? productid;
  String? productimage;
  String? productname;
  double? price;
  String? category;

  ProductDiseaseResults(
      {this.productid,
        this.productimage,
        this.productname,
        this.price,
        this.category});

  ProductDiseaseResults.fromJson(Map<String, dynamic> json) {
    productid = json['productid'];
    productimage = json['productimage'];
    productname = json['productname'];
    price = json['price'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['productid'] = productid;
    data['productimage'] = productimage;
    data['productname'] = productname;
    data['price'] = price;
    data['category'] = category;
    return data;
  }
}
