class ServiceProviderModel {
  String? status;
  String? msg;
  List<Data>? data;

  ServiceProviderModel({this.status, this.msg, this.data});

  ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? serviceProviderPic;
  bool? paidOrFree;
  String? createdDt;
  int? fkLanguageId;

  Data(
      {this.id,
        this.name,
        this.serviceProviderPic,
        this.paidOrFree,
        this.createdDt,
        this.fkLanguageId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serviceProviderPic = json['service_provider_pic'];
    paidOrFree = json['paid_or_free'];
    createdDt = json['created_dt'];
    fkLanguageId = json['fk_language_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['service_provider_pic'] = this.serviceProviderPic;
    data['paid_or_free'] = this.paidOrFree;
    data['created_dt'] = this.createdDt;
    data['fk_language_id'] = this.fkLanguageId;
    return data;
  }
}