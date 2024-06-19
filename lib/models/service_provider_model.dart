class ServiceProviderModel {
  int? status;
  String? msg;
  List<Data>? data;

  ServiceProviderModel({this.status, this.msg, this.data});

  ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
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
  String? createdDt;

  Data({this.id, this.name, this.serviceProviderPic, this.createdDt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serviceProviderPic = json['service_provider_pic'];
    createdDt = json['created_dt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['service_provider_pic'] = serviceProviderPic;
    data['created_dt'] = createdDt;
    return data;
  }
}
