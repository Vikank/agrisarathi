class FarmerProfile {
  final int? id;
  final String? email;
  final bool? emailVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final String? mobile;
  final String? profile;
  final String? village;
  final String? district;
  final String? block;
  final int? coins;
  final String? ipAddress;
  final bool? isActive;
  final bool? smsStatus;
  final bool? notificationStatus;
  final bool? isDeleted;
  final String? badgeColor;
  final int? user;
  final int? fkLanguage;
  final String? fpoName;

  FarmerProfile({
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
    this.smsStatus,
    this.notificationStatus,
    this.isDeleted,
    this.badgeColor,
    this.user,
    this.fkLanguage,
    this.fpoName,
  });

  factory FarmerProfile.fromJson(Map<String, dynamic> json) {
    return FarmerProfile(
      id: json['id'],
      email: json['email'],
      emailVerified: json['email_verified'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      name: json['name'],
      mobile: json['mobile'],
      profile: json['profile'],
      village: json['village'],
      district: json['district'],
      block: json['block'],
      coins: json['coins'],
      ipAddress: json['ip_address'],
      isActive: json['is_active'],
      smsStatus: json['sms_status'],
      notificationStatus: json['notification_status'],
      isDeleted: json['is_deleted'],
      badgeColor: json['badgecolor'],
      user: json['user'],
      fkLanguage: json['fk_language'],
      fpoName: json['fpo_name'],
    );
  }
}
