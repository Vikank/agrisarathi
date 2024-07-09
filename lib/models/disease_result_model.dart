class DiseaseResultModel {
  DiseaseResults? diseaseResults;
  List<ProductDisease>? productDisease;

  DiseaseResultModel({this.diseaseResults, this.productDisease});

  DiseaseResultModel.fromJson(Map<String, dynamic> json) {
    diseaseResults = json['disease_results'] != null
        ? DiseaseResults.fromJson(json['disease_results'])
        : null;
    if (json['product_disease'] != null) {
      productDisease = <ProductDisease>[];
      json['product_disease'].forEach((v) {
        productDisease!.add(ProductDisease.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (diseaseResults != null) {
      data['disease_results'] = diseaseResults!.toJson();
    }
    if (productDisease != null) {
      data['product_disease'] =
          productDisease!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DiseaseResults {
  String? disease;
  int? cropId;
  String? symptom;
  String? treatmentbefore;
  String? treatmentfield;
  String? treatment;
  String? message;
  String? suggestiveproduct;
  List<Images>? images;
  String? basePath;

  DiseaseResults(
      {this.disease, this.cropId,
        this.symptom,
        this.treatmentbefore,
        this.treatmentfield,
        this.treatment,
        this.message,
        this.suggestiveproduct,
        this.images,
        this.basePath});

  DiseaseResults.fromJson(Map<String, dynamic> json) {
    disease = json['disease'];
    cropId = json['crop_id'];
    symptom = json['symptom'];
    treatmentbefore = json['treatmentbefore'];
    treatmentfield = json['treatmentfield'];
    treatment = json['treatment'];
    message = json['message'];
    suggestiveproduct = json['suggestiveproduct'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    basePath = json['base_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['disease'] = disease;
    data['crop_id'] = cropId;
    data['symptom'] = symptom;
    data['treatmentbefore'] = treatmentbefore;
    data['treatmentfield'] = treatmentfield;
    data['treatment'] = treatment;
    data['message'] = message;
    data['suggestiveproduct'] = suggestiveproduct;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['base_path'] = basePath;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['disease_file'] = diseaseFile;
    return data;
  }
}

class ProductDisease {
  int? productid;
  String? productimage;
  String? productname;
  String? price;
  String? category;

  ProductDisease(
      {this.productid,
        this.productimage,
        this.productname,
        this.price,
        this.category});

  ProductDisease.fromJson(Map<String, dynamic> json) {
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