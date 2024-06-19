class UserCropModel {
  String? status;
  String? msg;
  List<Data>? data;

  UserCropModel({this.status, this.msg, this.data});

  UserCropModel.fromJson(Map<String, dynamic> json) {
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
  int? fkCropTypeId;
  String? cropName;
  String? cropImage;

  Data({this.id, this.fkCropTypeId, this.cropName, this.cropImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fkCropTypeId = json['fk_crop_type_id'];
    cropName = json['crop_name'];
    cropImage = json['crop_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fk_crop_type_id'] = fkCropTypeId;
    data['crop_name'] = cropName;
    data['crop_image'] = cropImage;
    return data;
  }
}
