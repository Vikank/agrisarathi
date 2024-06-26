class FarmerDetailsModel {
  FarmerDetailsModel({
    required this.data,
  });
  late final List<Data> data;

  FarmerDetailsModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.createdDate,
    required this.name,
    required this.mobileNo,
    required this.fkLanguageId,
    required this.fpoNameId,
    required this.profile,
    required this.coins,
    required this.badgecolor,
  });
  late final int? id;
  late final String? createdDate;
  late final String? name;
  late final String? mobileNo;
  late final int? fkLanguageId;
  late final int? fpoNameId;
  late final String? profile;
  late final int? coins;
  late final String? badgecolor;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    createdDate = json['created_date'];
    name = json['name'];
    mobileNo = json['mobile_no'];
    fkLanguageId = json['fk_language_id'];
    fpoNameId = json['fpo_name_id'];
    profile = json['profile'];
    coins = json['coins'];
    badgecolor = json['badgecolor'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_date'] = createdDate;
    _data['name'] = name;
    _data['mobile_no'] = mobileNo;
    _data['fk_language_id'] = fkLanguageId;
    _data['fpo_name_id'] = fpoNameId;
    _data['profile'] = profile;
    _data['coins'] = coins;
    _data['badgecolor'] = badgecolor;
    return _data;
  }
}