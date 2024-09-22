import 'package:meta/meta.dart';

@immutable
class Product {
  final int productId;
  final String productName;
  final String productImage;
  final String? productDescription;
  final String category;
  final List<int> supplierIds;
  final double? price;

  const Product({
    required this.productId,
    required this.productName,
    required this.productImage,
    this.productDescription,
    required this.category,
    required this.supplierIds,
    this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'] as int,
      productName: json['product_name'] as String,
      productImage: json['product_image'] as String,
      productDescription: json['product_description'] as String?,
      category: json['Category'] as String,
      supplierIds: (json['supplier_ids'] as List<dynamic>).cast<int>(),
      price: json['price'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'product_image': productImage,
      'product_description': productDescription,
      'Category': category,
      'supplier_ids': supplierIds,
      'price': price,
    };
  }
}

@immutable
class Stage {
  final int stageId;
  final String stages;
  final String stageName;
  final String stageAudio;
  final String stageVideo;
  final String? sowPeriod;
  final String description;
  final int stageNumber;
  final int preference;
  final bool isCompleted;
  final int daysSpent;
  final String startDate;
  final int userLanguage;
  final List<Product> products;

  const Stage({
    required this.stageId,
    required this.stages,
    required this.stageName,
    required this.stageAudio,
    required this.stageVideo,
    this.sowPeriod,
    required this.description,
    required this.stageNumber,
    required this.preference,
    required this.isCompleted,
    required this.daysSpent,
    required this.startDate,
    required this.userLanguage,
    required this.products,
  });

  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
      stageId: json['stage_id'] as int,
      stages: json['stages'] as String,
      stageName: json['stage_name'] as String,
      stageAudio: json['stage_audio'] as String,
      stageVideo: json['stage_video'] as String,
      sowPeriod: json['sow_period'] as String?,
      description: json['description'] as String,
      stageNumber: json['stage_number'] as int,
      preference: json['preference'] as int,
      isCompleted: json['is_completed'] as bool,
      daysSpent: json['days_spent'] as int,
      startDate: json['start_date'] as String,
      userLanguage: json['user_language'] as int,
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stage_id': stageId,
      'stages': stages,
      'stage_name': stageName,
      'stage_audio': stageAudio,
      'stage_video': stageVideo,
      'sow_period': sowPeriod,
      'description': description,
      'stage_number': stageNumber,
      'preference': preference,
      'is_completed': isCompleted,
      'days_spent': daysSpent,
      'start_date': startDate,
      'user_language': userLanguage,
      'products': products.map((e) => e.toJson()).toList(),
    };
  }
}

@immutable
class Preference {
  final int preferenceId;
  final String stages;
  final bool isCompleted;
  final int preferenceNumber;

  const Preference({
    required this.preferenceId,
    required this.stages,
    required this.isCompleted,
    required this.preferenceNumber,
  });

  factory Preference.fromJson(Map<String, dynamic> json) {
    return Preference(
      preferenceId: json['preference_id'] as int,
      stages: json['stages'] as String,
      isCompleted: json['is_completed'] as bool,
      preferenceNumber: json['preference_number'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'preference_id': preferenceId,
      'stages': stages,
      'is_completed': isCompleted,
      'preference_number': preferenceNumber,
    };
  }
}

@immutable
class VegetableProductionModel {
  final List<Stage> stages;
  final List<Preference> preferences;

  const VegetableProductionModel({
    required this.stages,
    required this.preferences,
  });

  factory VegetableProductionModel.fromJson(Map<String, dynamic> json) {
    return VegetableProductionModel(
      stages: (json['stages'] as List<dynamic>)
          .map((e) => Stage.fromJson(e as Map<String, dynamic>))
          .toList(),
      preferences: (json['preferences'] as List<dynamic>)
          .map((e) => Preference.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stages': stages.map((e) => e.toJson()).toList(),
      'preferences': preferences.map((e) => e.toJson()).toList(),
    };
  }

  List<Stage> filterStagesByPreference(int preference) {
    return stages.where((stage) => stage.preference == preference && !stage.isCompleted).toList();
  }
}

// Separate function to filter stages by preference
List<Stage> filterStagesByPreference(VegetableProductionModel model, int preference) {
  return model.stages.where((stage) => stage.preference == preference && !stage.isCompleted).toList();
}
/*
class VegetableProductionModel {
  List<Stages>? stages;
  List<Preferences>? preferences;

  VegetableProductionModel({this.stages, this.preferences});

  VegetableProductionModel.fromJson(Map<String, dynamic> json)
      : stages = (json['stages'] as List?)
      ?.map((v) => Stages.fromJson(v))
      .toList(),
        preferences = (json['preferences'] as List?)
            ?.map((v) => Preferences.fromJson(v))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'stages': stages?.map((v) => v.toJson()).toList(),
      'preferences': preferences?.map((v) => v.toJson()).toList(),
    };
  }
}

class Stages {
  int? stageId;
  String? stages;
  String? stageName;
  String? stageAudio;
  String? sowPeriod;
  String? description;
  int? stageNumber;
  int? preference;
  bool? isCompleted;
  int? daysSpent;
  String? startDate;
  int? userLanguage;
  List<Products>? products;

  Stages({
    this.stageId,
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
    this.products,
  });

  Stages.fromJson(Map<String, dynamic> json)
      : stageId = json['stage_id'] as int?,
        stages = json['stages'] as String?,
        stageName = json['stage_name'] as String?,
        stageAudio = json['stage_audio'] as String?,
        sowPeriod = json['sow_period'] as String?,
        description = json['description'] as String?,
        stageNumber = json['stage_number'] as int?,
        preference = json['preference'] as int?,
        isCompleted = json['is_completed'] as bool? ?? false,
        daysSpent = json['days_spent'] as int?,
        startDate = json['start_date'] as String?,
        userLanguage = json['user_language'] as int?,
        products = (json['products'] as List?)
            ?.map((v) => Products.fromJson(v))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'stage_id': stageId,
      'stages': stages,
      'stage_name': stageName,
      'stage_audio': stageAudio,
      'sow_period': sowPeriod,
      'description': description,
      'stage_number': stageNumber,
      'preference': preference,
      'is_completed': isCompleted,
      'days_spent': daysSpent,
      'start_date': startDate,
      'user_language': userLanguage,
      'products': products?.map((v) => v.toJson()).toList(),
    };
  }
}

class Products {
  int? productId;
  String? productName;
  String? productImage;
  String? productDescription;
  String? category;
  List<int>? supplierIds;
  double? price; // Price should be nullable

  Products({
    this.productId,
    this.productName,
    this.productImage,
    this.productDescription,
    this.category,
    this.supplierIds,
    this.price,
  });

  Products.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'] as int?,
        productName = json['product_name'] as String?,
        productImage = json['product_image'] as String?,
        productDescription = json['product_description'] as String?,
        category = json['Category'] as String?,
        supplierIds = (json['supplier_ids'] as List?)
            ?.map((id) => id as int)
            .toList(),
        price = (json['price'] as num?)?.toDouble();

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'product_image': productImage,
      'product_description': productDescription,
      'Category': category,
      'supplier_ids': supplierIds,
      'price': price,
    };
  }
}

class Preferences {
  int? preferenceId;
  String? stages;
  bool? isCompleted;
  int? preferenceNumber;

  Preferences({
    this.preferenceId,
    this.stages,
    this.isCompleted,
    this.preferenceNumber,
  });

  Preferences.fromJson(Map<String, dynamic> json)
      : preferenceId = json['preference_id'] as int?,
        stages = json['stages'] as String?,
        isCompleted = json['is_completed'] as bool? ?? false,
        preferenceNumber = json['preference_number'] as int?;

  Map<String, dynamic> toJson() {
    return {
      'preference_id': preferenceId,
      'stages': stages,
      'is_completed': isCompleted,
      'preference_number': preferenceNumber,
    };
  }
}
*/
