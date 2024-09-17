class VegetableProductionModel {
  List<Stages>? stages;
  List<Preferences>? preferences;

  VegetableProductionModel({this.stages, this.preferences});

  VegetableProductionModel.fromJson(Map<String, dynamic> json) {
    if (json['stages'] != null) {
      stages = <Stages>[];
      json['stages'].forEach((v) {
        stages!.add(new Stages.fromJson(v));
      });
    }
    if (json['preferences'] != null) {
      preferences = <Preferences>[];
      json['preferences'].forEach((v) {
        preferences!.add(new Preferences.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stages != null) {
      data['stages'] = this.stages!.map((v) => v.toJson()).toList();
    }
    if (this.preferences != null) {
      data['preferences'] = this.preferences!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stages {
  int? stageId;
  String? stages;
  String? stageName;
  Null? stageAudio;
  Null? sowPeriod;
  String? description;
  int? stageNumber;
  int? preference;
  bool? isCompleted;
  int? daysSpent;
  String? startDate;
  int? userLanguage;
  List<Products>? products;

  Stages(
      {this.stageId,
        this.stages,
        this.stageName,
        this.stageAudio,
        this.sowPeriod,
        this.description,
        this.stageNumber,
        this.preference,
        this.isCompleted,
        this.daysSpent,
        this.startDate,
        this.userLanguage,
        this.products});

  Stages.fromJson(Map<String, dynamic> json) {
    stageId = json['stage_id'];
    stages = json['stages'];
    stageName = json['stage_name'];
    stageAudio = json['stage_audio'];
    sowPeriod = json['sow_period'];
    description = json['description'];
    stageNumber = json['stage_number'];
    preference = json['preference'];
    isCompleted = json['is_completed'];
    daysSpent = json['days_spent'];
    startDate = json['start_date'];
    userLanguage = json['user_language'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stage_id'] = this.stageId;
    data['stages'] = this.stages;
    data['stage_name'] = this.stageName;
    data['stage_audio'] = this.stageAudio;
    data['sow_period'] = this.sowPeriod;
    data['description'] = this.description;
    data['stage_number'] = this.stageNumber;
    data['preference'] = this.preference;
    data['is_completed'] = this.isCompleted;
    data['days_spent'] = this.daysSpent;
    data['start_date'] = this.startDate;
    data['user_language'] = this.userLanguage;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? productId;
  String? productName;
  String? productImage;
  String? productDescription;
  String? category;
  List<int>? supplierIds;
  Null? price;

  Products(
      {this.productId,
        this.productName,
        this.productImage,
        this.productDescription,
        this.category,
        this.supplierIds,
        this.price});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    productDescription = json['product_description'];
    category = json['Category'];
    supplierIds = json['supplier_ids'].cast<int>();
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['product_description'] = this.productDescription;
    data['Category'] = this.category;
    data['supplier_ids'] = this.supplierIds;
    data['price'] = this.price;
    return data;
  }
}

class Preferences {
  int? preferenceId;
  String? stages;
  bool? isCompleted;
  int? preferenceNumber;

  Preferences(
      {this.preferenceId,
        this.stages,
        this.isCompleted,
        this.preferenceNumber});

  Preferences.fromJson(Map<String, dynamic> json) {
    preferenceId = json['preference_id'];
    stages = json['stages'];
    isCompleted = json['is_completed'];
    preferenceNumber = json['preference_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['preference_id'] = this.preferenceId;
    data['stages'] = this.stages;
    data['is_completed'] = this.isCompleted;
    data['preference_number'] = this.preferenceNumber;
    return data;
  }
}