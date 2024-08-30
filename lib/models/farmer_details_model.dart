class FarmerDetailsModel {
  Data? data;

  FarmerDetailsModel({this.data});

  FarmerDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? email; // Changed Null to String
  bool? emailVerified;
  String? createdAt;
  String? updatedAt;
  String? name; // Changed Null to String
  String? mobile;
  String? profile; // Changed Null to String
  String? village; // Changed Null to String
  String? district; // Changed Null to String
  String? block; // Changed Null to String
  int? coins;
  String? ipAddress;
  bool? isActive;
  bool? isDeleted;
  String? badgecolor; // Changed Null to String
  int? user;
  int? fkLanguage; // Changed Null to String
  String? fpoName; // Changed Null to String
  List<String>? fkCrops; // Changed List<Null> to List<String>

  Data({
    this.id,
    this.email,
    this.emailVerified,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.mobile,
    this.profile,
    this.village,
    this.district,
    this.block,
    this.coins,
    this.ipAddress,
    this.isActive,
    this.isDeleted,
    this.badgecolor,
    this.user,
    this.fkLanguage,
    this.fpoName,
    this.fkCrops,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    email = json['email'] as String?;
    emailVerified = json['email_verified'] as bool?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    name = json['name'] as String?;
    mobile = json['mobile'] as String?;
    profile = json['profile'] as String?;
    village = json['village'] as String?;
    district = json['district'] as String?;
    block = json['block'] as String?;
    coins = json['coins'] as int?;
    ipAddress = json['ip_address'] as String?;
    isActive = json['is_active'] as bool?;
    isDeleted = json['is_deleted'] as bool?;
    badgecolor = json['badgecolor'] as String?;
    user = json['user'] as int?;
    fkLanguage = json['fk_language'] as int?;
    fpoName = json['fpo_name'] as String?;
    if (json['fk_crops'] != null) {
      fkCrops = List<String>.from(json['fk_crops']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['email_verified'] = emailVerified;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['mobile'] = mobile;
    data['profile'] = profile;
    data['village'] = village;
    data['district'] = district;
    data['block'] = block;
    data['coins'] = coins;
    data['ip_address'] = ipAddress;
    data['is_active'] = isActive;
    data['is_deleted'] = isDeleted;
    data['badgecolor'] = badgecolor;
    data['user'] = user;
    data['fk_language'] = fkLanguage;
    data['fpo_name'] = fpoName;
    if (fkCrops != null) {
      data['fk_crops'] = fkCrops;
    }
    return data;
  }
}
