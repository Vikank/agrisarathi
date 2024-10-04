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
  String? diseaseName;
  String? serviceProvider;
  String? symptom;
  String? treatmentBefore;
  String? treatmentField;
  String? treatment;
  String? message;
  String? suggestiveProduct;
  String? uploadedImage;

  DiseaseResults({
    this.id,
    this.cropId,
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

  DiseaseResults.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id = json['crop_id'];
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
    data['crop_id'] = id;
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

class ProductDiseaseResults {
  List<Product>? products;

  ProductDiseaseResults({this.products});

  ProductDiseaseResults.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? productId;
  String? productName;
  String? productImage;
  String? productDescription;
  String? category;
  List<int>? supplierIds;
  double? price;

  Product({
    this.productId,
    this.productName,
    this.productImage,
    this.productDescription,
    this.category,
    this.supplierIds,
    this.price,
  });

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    productDescription = json['product_description'];
    category = json['Category'];
    supplierIds = json['supplier_ids'] != null
        ? List<int>.from(json['supplier_ids'])
        : null;
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_image'] = productImage;
    data['product_description'] = productDescription;
    data['Category'] = category;
    if (supplierIds != null) {
      data['supplier_ids'] = supplierIds;
    }
    data['price'] = price;
    return data;
  }
}
